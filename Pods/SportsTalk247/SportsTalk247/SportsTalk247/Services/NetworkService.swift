import Foundation

public typealias Completion<T: Decodable> = (_ code: Int?, _ message: String?, _ kind: String?, _ data: T?) -> Void

enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

open class NetworkService {
    public var config: ClientConfig
    
    init(config: ClientConfig) {
        self.config = config
    }
    
    func makeRequest<T: Decodable>(_ serviceName: String?, useDefaultUrl:Bool = true, withData data: [AnyHashable: Any]?, requestType: RequestType, expectation: T.Type, append: Bool = true, completionHandler: @escaping (_ response: ApiResponse<T>?) -> Void) {

        guard didSucceedValidationParameters(data) else {
            if SportsTalkSDK.shared.debugMode {
                print("Failed to satisfy request requirement. Please check your request model and try again.")
            }
            
            completionHandler(nil)
            return
        }
        
        // Create the request
        if let request = makeURLRequest(serviceName, useDefaultUrl: useDefaultUrl, withData: data, requestType: requestType, appendData: append) {
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
                if let error = error {
                    // Deal with your error
                    if (response is HTTPURLResponse) {
                        let httpResponse = response as? HTTPURLResponse
                        print(String(format: "\(httpError) %ld", Int(httpResponse?.statusCode ?? 0)))
                    }
                    
                    print(error)
                    completionHandler(nil)
                } else {
                    if let data = data {
                        if SportsTalkSDK.shared.debugMode {
                            print("Response(\(serviceName ?? "non service")): \(data.string ?? "")")
                        }
                        
                        if let json = try? JSONDecoder().decode(ApiResponse<T>.self, from: data) {
                            completionHandler(json)
                        } else {
                            print("\(jsonParsingError) \(serviceName ?? emptyString)")
                            completionHandler(nil)
                        }
                    }
                }
            }).resume()
        }
    }
    
    func makeURLRequest(_ serviceName: String?, useDefaultUrl: Bool, withData data: [AnyHashable: Any]?, requestType: RequestType, appendData: Bool) -> URLRequest? {
        var parameters = [String:Any]()
        
        for (key, value) in (data ?? [AnyHashable: Any]()) {
           parameters[key as! String] = value
        }
        
        // Generate url.
        var url:URL?
        
        if useDefaultUrl {
            url = URL(string: "\(self.config.endpoint.absoluteString)/\(config.appId)/\(serviceName ?? "")")
        } else {
            url = URL(string: "\(serviceName ?? emptyString)")!
        }
        
        guard let requestUrl = url else { return nil}
        
        // Create the request
        var request = URLRequest(url: requestUrl, timeoutInterval: Double.infinity)
        request.httpMethod = requestType.rawValue
        
        if (requestType == .POST && appendData) || requestType == .PUT || requestType == .DELETE {
            let httpData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = httpData
            
        } else if requestType == .GET && appendData {
            var components = URLComponents(string: requestUrl.absoluteString)!
            components.queryItems = [URLQueryItem]()

            for (key, value) in (data ?? [AnyHashable : Any]()) {
                let item: URLQueryItem
                if let v = value as? Bool {
                    item = URLQueryItem(name: "\(key)", value: "\(v ? "true" : "false")")
                } else {
                    item = URLQueryItem(name: "\(key)", value: "\(value)")
                }
                
                components.queryItems?.append(item)
            }

            if let componentUrl = components.url {
                request.url = componentUrl
            }
        }
        
        request.addValue(acceptHeaderValue, forHTTPHeaderField: acceptHeaderTitle)
        request.addValue(contentTypeValue, forHTTPHeaderField: contentTypeTitle)
        request.addValue(config.authToken, forHTTPHeaderField: tokenTitle)
        
        if SportsTalkSDK.shared.debugMode {
            request.log()
        }
        
        return request
    }
    
    private func didSucceedValidationParameters(_ dataDictionary: [AnyHashable: Any]?) -> Bool {
        if let dataDictionary = dataDictionary, dataDictionary[errorMessageTitle] != nil  {
            return false
        }
        
        return true
    }
}

/// This is basically for debugging purpose. this helps in converting data to string.. making this file private so that this doesn't affect outside of the SDK.
fileprivate extension Data {
    var string: String? {
        return String(data: self, encoding: .utf8)
    }
}

/// This is basically for debugging purpose. This helps in logging each request.  making this file private so that this doesn't affect outside of the SDK.
fileprivate extension URLRequest {
    func log() {
        print("---------Request---------")
        print("\(httpMethod ?? "") \(self)")
        print("BODY \n \(httpBody?.string ?? "")")
        print("HEADERS \n \(allHTTPHeaderFields ?? [:])")
    }
}
