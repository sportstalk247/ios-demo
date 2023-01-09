import UIKit

enum Error {
    case messsage
}

open class ParametersBase<T,S> {
    
    var dictionary = [AnyHashable: Any]()
    var toDictionary = [AnyHashable: Any]()
    
    public init() {}
    
    func from(dictionary: [AnyHashable: Any]) -> S {
        preconditionFailure("Override function in child class otherwise it will give error")
    }
    
    func add(key: T, value: Any?) {
        toDictionary[toString(key: key)] = value
    }
    
    func add(key: T, value: Bool?) {
        toDictionary[toString(key: key)] = toNumber(value: value)
    }
    
    func toNumber(value: Bool?) -> NSNumber? {
        if let value = value {
            return NSNumber(value: value)
        } else {
            return nil
        }
    }

    func addRequired(key: T, value: String?) {
        if let value = value, value != emptyString {
            toDictionary[toString(key: key)] = value
        } else {
            toDictionary[errorMessageTitle] = returnError(parameterString: toString(key: key))
        }
    }
    
    func addRequired(key: T, value: Bool?) {
        if let value = value {
            add(key: key, value: value)
        } else {
            toDictionary[errorMessageTitle] = returnError(parameterString: toString(key: key))
        }
    }
    
    func addRequired(key: T, value: [String]?) {
        if let value = value, value.count > 0 {
            toDictionary[toString(key: key)] = value
        } else {
            toDictionary[errorMessageTitle] = returnError(parameterString: toString(key: key))
        }
    }

    func set(dictionary: [AnyHashable: Any]) {
        self.dictionary = dictionary
    }

    func value(forKey key: T) -> Int? {
        return (dictionary[toString(key: key)] as? NSNumber)?.intValue
    }
    
    func value(forKey key: T) -> Int64? {
        return (dictionary[toString(key: key)] as? NSNumber)?.int64Value
    }
    
    func value(forKey key: T) -> Bool? {
        return (dictionary[toString(key: key)] as? NSNumber)?.boolValue
    }
    
    func value(forKey key: T) -> Int {
        return (dictionary[toString(key: key)] as? NSNumber)?.intValue ?? 0
    }
    
    func value(forKey key: T) -> Double {
        return (dictionary[toString(key: key)] as? NSNumber)?.doubleValue ?? 0
    }

    func value(forKey key: T) -> String? {
        return (dictionary[toString(key: key)] as? String)
    }
    
    func value(forKey key: T) -> [String]? {
        return (dictionary[toString(key: key)] as? [String])
    }
    
    func value(forKey key: T) -> URL? {
        guard let urlString = (dictionary[toString(key: key)] as? String) else { return nil }
        return URL(string: urlString)
    }
    
    func value(forKey key: T) -> EventType? {
        guard
            let id = dictionary[toString(key: key)] as? String,
            let event = EventType.init(rawValue: id)
        else {
            return nil
        }
        
        return event
    }
    
    func value(forKey key: T) -> [EventType]? {
        guard let id = dictionary[toString(key: key)] as? [String] else { return nil }
        
        var events: [EventType]?
        
        id.forEach { item in
            if let event = EventType.init(rawValue: item) {
                if events == nil {
                    events = [EventType]()
                }
                events!.append(event)
            }
        }
        return events
    }

    
    func value(forKey key: T) -> Ordering? {
        guard
            let id = dictionary[toString(key: key)] as? String,
            let event = Ordering.init(rawValue: id)
        else {
            return nil
        }
        
        return event
    }
    
    func value(forKey key: T) -> ReportType? {
        guard
            let id = dictionary[toString(key: key)] as? String,
            let event = ReportType.init(rawValue: id)
        else {
            return nil
        }
        
        return event
    }
    
    func value(forKey key: T) -> RoomEntityType? {
        guard
            let id = dictionary[toString(key: key)] as? String,
            let event = RoomEntityType.init(rawValue: id)
        else {
            return nil
        }
        
        return event
    }
    
    func value(forKey key: T) -> [RoomEntityType]? {
        guard let id = dictionary[toString(key: key)] as? [String] else { return nil }
        
        var entities: [RoomEntityType]?
        
        id.forEach { item in
            if let event = RoomEntityType.init(rawValue: item) {
                if entities == nil {
                    entities = [RoomEntityType]()
                }
                entities!.append(event)
            }
        }
        return entities
    }

 
    func toString(key: T) -> String {
        return "\(key)"
    }
    
    func returnError(parameterString:String) -> String {
        return "\(errorMessageString) \(parameterString)"
    }
}
