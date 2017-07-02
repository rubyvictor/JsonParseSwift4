//
//  ViewController.swift
//  JsonParseSwift4
//
//  Created by Victor Lee on 2/7/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

// Create new model object for complicated json "https://api.letsbuildthatapp.com/jsondecodable/website_description"

// Swift 4, xCode9 STEP 3-4:

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    
    let id: Int? // Swift 4: make Optional to fix serializing json error if missing keys json
    let name: String?
    let link: String?
    let imageUrl: String?
    
    // Swift 2,3,ObjC traditional way of JSON parsing Step 2:
    
    // Swift 4, xCode9 way of JSON parsing STEP 2: REMOVE initializer
//    init(json: [String: Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        link = json["link"] as? String ?? ""
//        imageUrl = json["imageUrl"] as? String ?? ""
//    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // JSON structures:
        // BASIC:  "https://api.letsbuildthatapp.com/jsondecodable/course"
        // INTERMEDIATE: "https://api.letsbuildthatapp.com/jsondecodable/courses"
        // COMPLICATED: "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        // MISSING KEYS IN JSON: "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        
        // Swift 2,3,ObjC traditional way of JSON parsing Step 1:
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check error
            // Perhaps check HTTPResponse status 200 OK
            if error != nil {
                print(error ?? "")
            }
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString ?? "")
            
            do {
                
                // Swift 4, xCode9 way of JSON parsing STEP 1:
                // JSON structures:
                // BASIC: Course.self
                // INTERMEDIATE: [Course].self
                // COMPLICATED: WebsiteDescription.self
                // MISSING KEYS JSON: [Course].self
                
                let courseMissingFields = try JSONDecoder().decode([Course].self, from: data)
                print(courseMissingFields)
                
//                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
//                print(websiteDescription.name, websiteDescription.description)
                
//                let course = try JSONDecoder().decode([Course].self, from: data)
//                print(course)
                
//                let course = try JSONDecoder().decode(Course.self, from: data)
//                print(course.name, course.link)
                
                
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//
//                // parse in the json we just serialized in the line above
//                let course = Course(json: json)
//                print(course.name, course.link)                
//                print(json)
            } catch let jsonError {
                print("Error serializing json,", jsonError)
            }
            
            
        }.resume()
        
//        let myCourse = Course(id: 1, name: "myCourse", link: "some link", imageUrl: "some image url")
//        print(myCourse)
        
    }

    

}

