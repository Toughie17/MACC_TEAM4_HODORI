//
//  RealmManager.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private var realm: Realm
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError()
        }
    }
    
    // MARK: Create
    func addObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            
        }
    }
    
    // MARK: Read
    func getAllObjects<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    // MARK: Update
    func updateObject<T: Object>(_ object: T, with dictionary: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            
        }
    }
    
    // MARK: Delete
    func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            
        }
    }
    
}
