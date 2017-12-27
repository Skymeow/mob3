//
//  FetchHelper.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/8/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import CoreData

enum Route {
    case course
    case session(courseName: String)
    case note(sessionName: String)
    case project(courseName: String)
    
    func setPredicate() -> NSPredicate? {
        switch self {
        case let .note(sessionName):
            let result = NSPredicate(format: "name == %@",sessionName)
            return result
        case let .session(courseName):
            let result = NSPredicate(format: "courseName == %@", courseName)
            return result
        case let .project(courseName):
            let result = NSPredicate(format: "courseName == %@", courseName)
            return result
        default:
            return nil
        }
    }
}

//MARK: fetch one and all entities from viewContext

func fetchOne<T: NSManagedObject>(_ entityName: T.Type, sortDescriptor: [NSSortDescriptor]? = nil, route: Route) -> T {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    
    fetchRequest.predicate = route.setPredicate()
    
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.viewContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return (results?.first)!
}

func fetchAll<T: NSManagedObject>(_ entityName: T.Type, route: Route, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    
    fetchRequest.predicate = route.setPredicate()
    
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.viewContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return results!
}






