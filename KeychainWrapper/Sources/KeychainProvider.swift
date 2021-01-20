//
//  KeychainProvider.swift
//  Admin
//
//  Created by Artem Melnyk on 19.01.2021.
//

import Security

internal struct KeychainProvider {
    /// Keychain security class enum.
    enum SecClass {
        case generic
        case internet
        
        /// Returns a security class value
        var value: CFString {
            switch self {
            case .generic:
                return kSecClassGenericPassword
            case .internet:
                return kSecClassInternetPassword
            }
        }
    }
    
    /**
     Generate `[CFString: Any]` query for keychain requests.
     - Parameter secClass: `SecClass` class of security.
     - Parameter service: `String` service name used as kSecAttrService.
     - Parameter account: `String` key to get stored value.
     - Parameter sync: `Bool` whether the data can be synchronized.
     */
    internal static func query(secClass: SecClass, service: String, account: String, sync: Bool = true) -> [CFString: Any] {
        var dict: [CFString: Any] = [
            kSecClass: secClass.value,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        if sync {
            dict[kSecAttrSynchronizable] = kSecAttrSynchronizableAny
        }
        return dict
    }
}
