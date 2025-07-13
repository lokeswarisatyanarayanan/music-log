//
//  SpotifyTokenStore 2.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import Foundation
import Security

final class SpotifyTokenStore {
    private let serviceName = "MusicLog"
    
    private let accessTokenKey = "spotify_access_token"
    private let refreshTokenKey = "spotify_refresh_token"
    private let expiryDateKey = "spotify_expiry_date"
    
    private let tokenExpiryBuffer: TimeInterval = 60
    
    var accessToken: String? {
        guard isAccessTokenValid else { return nil }
        return load(key: accessTokenKey)
    }
    
    var refreshToken: String? {
        load(key: refreshTokenKey)
    }
    
    var isAccessTokenValid: Bool {
        guard let expiry = expiryDate else { return false }
        return Date() < expiry.addingTimeInterval(-tokenExpiryBuffer)
    }
    
    private var expiryDate: Date? {
        guard let timestamp = UserDefaults.standard.object(forKey: expiryDateKey) as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSince1970: timestamp)
    }
    
    func save(accessToken: String, refreshToken: String?, expiresIn: Double) {
        store(key: accessTokenKey, value: accessToken)
        
        if let refreshToken = refreshToken {
            store(key: refreshTokenKey, value: refreshToken)
        }
        
        let expiry = Date().addingTimeInterval(expiresIn)
        UserDefaults.standard.set(expiry.timeIntervalSince1970, forKey: expiryDateKey)
    }
    
    func clear() {
        delete(key: accessTokenKey)
        delete(key: refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: expiryDateKey)
    }
    
    private func store(key: String, value: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to store keychain item: \(status)")
        }
    }
    
    private func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    private func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
