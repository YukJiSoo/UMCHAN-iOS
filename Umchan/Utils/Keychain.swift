//
//  Keychain.swift
//  Umchan
//
//  Created by 육지수 on 9/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import Security

class Keychain {
    
    private static var serviceIdentifier: String {
        if let identifier = Bundle.main.bundleIdentifier {
            return identifier
        }
        return ""
    }
    
    class func saveValue(_ value: String, for key: String) -> Bool {
        
        guard let data = value.data(using: .utf8, allowLossyConversion: false) else {
            debugPrint("fail convert String to NSData")
            return false
        }
        
        let keychainQuery: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrService as String : self.serviceIdentifier,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ]

        SecItemDelete(keychainQuery as CFDictionary)

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)

        return status == noErr
    }

    class func loadValue(for key: String) -> String? {
        
        let keychainQuery: [String: Any]  = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrService as String : self.serviceIdentifier,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ]

        var queryResult: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &queryResult)
        
        switch status {
        case errSecSuccess:

            guard let queriedItem = queryResult as? Data else {
                debugPrint("fail convert AnyObject to NSData")
                return nil
            }
            
            guard let value = String(data: queriedItem, encoding: .utf8) else {
                debugPrint("fail convert Data to String")
                return nil
            }
            
            return value
        case errSecItemNotFound:
            
            debugPrint("not found item")
            return nil
        default:
            
            debugPrint("unhandle error\(status)")
            return nil
        }
    }

    class func deleteValue(for key: String) -> Bool {
        
        let keychainQuery: [String: Any]  = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : self.serviceIdentifier,
            kSecAttrAccount as String : key ]

        let status: OSStatus = SecItemDelete(keychainQuery as CFDictionary)

        return status == noErr
    }


    class func clearAllValue() -> Bool {
        let keychainQuery: [String: Any]  = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : self.serviceIdentifier ]
        
        let status: OSStatus = SecItemDelete(keychainQuery as CFDictionary)

        return status == noErr
    }
}
