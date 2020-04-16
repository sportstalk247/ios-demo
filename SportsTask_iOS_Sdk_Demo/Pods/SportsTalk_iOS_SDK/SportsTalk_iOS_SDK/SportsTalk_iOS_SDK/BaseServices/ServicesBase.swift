import Foundation
import CommonCrypto

public typealias CompletionHandler = (_ success:[AnyHashable: Any]) -> Void

enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

open class ServicesBase
{
    public var authToken: String?
    public var url: URL?
    public var services: Services?
    public var user: Services.User?
    public var appId: String?
    
    func makeRequest(_ serviceName: String?, useDefaultUrl:Bool = true, withData data: [AnyHashable: Any]?, requestType: RequestType, appendData:Bool = true, completionHandler: @escaping CompletionHandler)
    {
        if let requiredParameterIsNilError = checkRequiredParameters(data)
        {
            completionHandler(requiredParameterIsNilError)
        }
        
        // Create the request
        if let request = makeURLRequest(serviceName, useDefaultUrl: useDefaultUrl, withData: data, requestType: requestType, appendData: appendData) {
            
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
                if let error = error
                {
                    // Deal with your error
                    if (response is HTTPURLResponse)
                    {
                        let httpResponse = response as? HTTPURLResponse
                        print(String(format: "\(httpError) %ld", Int(httpResponse?.statusCode ?? 0)))
                    }
                    
                    print(error)
                    completionHandler([messageTitle: "\(error.localizedDescription)"])
                }
                else
                {
                    do
                    {
                        if let data = data
                        {
                            print("Response(\(serviceName ?? "non service")): \(data.string ?? "")")
                            if let jsonData = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                            {
                                completionHandler(jsonData)
                            }
                        }
                    }
                    catch let error
                    {
                        print("\(jsonParsingError) \(serviceName ?? emptyString): \(error.localizedDescription)")
                        completionHandler([messageTitle: "\(serviceName ?? emptyString): \(error.localizedDescription)"])
                    }
                }
            }).resume()
        }
    }

    func checkRequiredParameters(_ dataDictionary: [AnyHashable: Any]?) -> [AnyHashable: Any]?
    {
        if let dataDictionary = dataDictionary, let errorMessage = dataDictionary[errorMessageTitle]
        {
            return [messageTitle: errorMessage]
        }
        
        return nil
    }
    
    func makeURLRequest(_ serviceName: String?, useDefaultUrl:Bool, withData data: [AnyHashable: Any]?, requestType: RequestType, appendData: Bool) -> URLRequest?
    {
        var parameters = [String:Any]()
        for (key, value) in (data ?? [AnyHashable: Any]())
        {
            parameters[key as! String] = value
            
        }
        
        // Generate url.
        var url:URL?
        
        if useDefaultUrl {
            url = URL(string: "\(self.url?.absoluteString ?? emptyString)/\(appId ?? emptyString)/\(serviceName ?? emptyString)")
        }
        else {
            url = URL(string: "\(serviceName ?? emptyString)")!
        }
        
        guard let requestUrl = url else { return nil}
        
        // Create the request
        var request = URLRequest(url: requestUrl, timeoutInterval: Double.infinity)
        request.httpMethod = requestType.rawValue
        
        if (requestType == .POST && appendData) || requestType == .PUT
        {
            //                    request.httpBody = postData
            let httpData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = httpData
            
        }
        else if requestType == .GET && appendData
        {
            var components = URLComponents(string: requestUrl.absoluteString)!
            components.queryItems = [URLQueryItem]()

            for (key, value) in (data ?? [AnyHashable : Any]())
            {
                let item = URLQueryItem(name: "\(key)", value: "\(value)")
                components.queryItems?.append(item)
            }

            if let componentUrl = components.url
            {
                request.url = componentUrl
            }
        }
        
        request.addValue(acceptHeaderValue, forHTTPHeaderField: acceptHeaderTitle)
        request.addValue(contentTypeValue, forHTTPHeaderField: contentTypeTitle)
        request.addValue(self.authToken ?? emptyString, forHTTPHeaderField: tokenTitle)
        request.log()
        return request
    }
// po request.url = URL(string: "https://api.sportstalk247.com/api/v3/5dcb569438a2830dc0a28e22/user/users/userid_georgew")
}

/// This is basically for debugging purpose. this helps in converting data to string.. making this file private so that this doesn't affect outside of the SDK.
fileprivate extension Data
{
    var string: String?
    {
        return String(data: self, encoding: .utf8)
    }
}

/// This is basically for debugging purpose. This helps in logging each request.  making this file private so that this doesn't affect outside of the SDK.
fileprivate extension URLRequest
{
    func log()
    {
        print("---------Request---------")
        print("\(httpMethod ?? "") \(self)")
        print("BODY \n \(httpBody?.string ?? "")")
        print("HEADERS \n \(allHTTPHeaderFields ?? [:])")
    }
}
