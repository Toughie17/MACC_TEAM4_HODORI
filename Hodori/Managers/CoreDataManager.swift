//
//  CoreDataManager.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import CoreData
import Foundation

final class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MeetingModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: CRATE
    func save<T: Codable>(meeting: T) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(meeting)
            let meetingEntity = MeetingModel(context: viewContext)
            meetingEntity.meetingData = data
            try viewContext.save()
        } catch {
            
        }
    }
    
    // MARK: READ
    func fetchAllMeeting() -> [Meeting] {
        let decoder = JSONDecoder()
        
        do {
            let fetchRequest: NSFetchRequest<MeetingModel> = MeetingModel.fetchRequest()
            let meetingModels = try viewContext.fetch(fetchRequest)
            let meetings = meetingModels.compactMap { meetingModel -> Meeting? in
                if let meetingData = meetingModel.meetingData {
                    do {
                        let decodedMeeting = try decoder.decode(Meeting.self, from: meetingData)
                        return decodedMeeting
                    } catch {
                        return nil
                    }
                }
                return nil
            }
            let sortedMeetings = meetings.sorted(by: { $0.startDate > $1.startDate })
            return sortedMeetings
        } catch {
            return []
        }
    }
    
    // MARK: UPDATE
    
    
    // MARK: DELETE
    
    
}
