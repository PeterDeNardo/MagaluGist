//
//  accessUserDefault.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import Foundation

class AccessUserDefaultManager {
    
    public static var shared: AccessUserDefaultManager = {
        let manager = AccessUserDefaultManager()
        return manager
    }()
    
    var userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    ///
    func saveDashGistModelArray(_ array: [DashGistModel], forKey: String) throws {
        do {
            let data = try JSONEncoder().encode(array)
            userDefaults.set(data, forKey: forKey)
        } catch {
            throw error
        }
    }
    
    func getDashGistModelArrayWithKey(_ key: String) throws -> [DashGistModel] {
        do {
            let data = userDefaults.object(forKey: key) as? Data ?? Data()
            if data.isEmpty {
                return []
            }
            let array = try JSONDecoder().decode([DashGistModel].self, from: data)
            return array
        } catch {
            throw error
        }
    }
}

enum UserDefaultsKeys: String {
    case favoritesUserDefaultsKey = "favorites"
}
