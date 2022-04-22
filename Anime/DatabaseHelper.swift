//
//  DatabaseHelper.swift
//  Anime
//
//  Created by
// Balaji Chandupatla
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
//
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
   static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:[String:String]) {
        guard let context = context else { return }
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as! Users
        user.name = object["name"]
        user.emailAddress = object["emailAddress"]
        user.password = object["password"]
        user.faviouteAnime = object["anime"]
        
        do {
            try? context.save()
        } catch {
          print("Record not saved")
        }
    }
    
    func update(name: String, user: String) {
        guard let context = context else { return }
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let users = try context.fetch(request)
            let user = users.first
            user?.name = name
            try? context.save()
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    func getUser(name: String) -> Users? {
        guard let context = context else { return nil}
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let userList = try context.fetch(request)
            let filterUser = userList.filter { user in
                user.emailAddress == name
            }
            return filterUser.first
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    func getUserName(name: String) -> Users? {
        guard let context = context else { return nil}
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        do {
            let userList = try context.fetch(request)
            let filterUser = userList.filter { user in
                user.name == name
            }
            return filterUser.first
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    func updateTheFavioutie(isSelected: Bool, animeName: String) {
       if let username = UserDefaults.standard.value(forKey: "userName") as? String, isSelected {
            createFaviouties(name: username, animeName: animeName)
       } else {
           deleteFaviourties(animeName: animeName)
       }
    }
    
    
    func createFaviouties(name: String, animeName: String) {
        
        guard let context = context else { return }
        let faviourties = NSEntityDescription.insertNewObject(forEntityName: "Faviourties", into: context) as! Faviourties
        faviourties.userId = name
        faviourties.faviourtieId = animeName
        do {
            try? context.save()
        } catch {
          print("Record not saved")
        }
    }
    
    func getListOfFaviourties(username: String) -> [Faviourties]?  {
        guard let context = context else { return nil}
        
        let request: NSFetchRequest<Faviourties> = Faviourties.fetchRequest()
        do {
            let userList = try context.fetch(request)
            let filterfaviourties = userList.filter { user in
                user.userId == username
            }
            return filterfaviourties
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }

    
    func deleteFaviourties(animeName: String) {
        guard let context = context else { return }
        
        let request: NSFetchRequest<Faviourties> = Faviourties.fetchRequest()
     
        do {
            let faviouteList = try context.fetch(request)
            let filterfaviourties = faviouteList.filter { user in
                user.faviourtieId == animeName
            }
            if let filterfaviourtie = filterfaviourties.first {
                try context.delete(filterfaviourtie)
            }
        } catch {
            fatalError("This was not supposed to happen")
        }
    }
}
