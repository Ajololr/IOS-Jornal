//
//  Student.swift
//  lab
//
//  Created by Ilya Androsav on 3/10/21.
//

import Foundation

class Student {
    var id : String
    var firstName : String
    var lastName : String
    var secondName : String
    var imageUrl : String
    var birthday : Date
    var videoUrl : String
    var longitude: String
    var latitude: String
    var images: [String]
    
    init(id: String, firstName:String, lastName:String, secondName:String, imageUrl:String, birthday:Date, videoUrl: String, longitude: String, latitude: String, images: [String]) {
        self.id = id
        self.birthday = birthday
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.latitude = latitude
        self.longitude = longitude
        self.images = images
    }
}
