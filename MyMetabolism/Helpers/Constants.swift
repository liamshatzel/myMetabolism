//
//  Constants.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation

struct Constants {
    struct Storyboard {
        static let homeViewController = "homeVC"
        static let loginViewController = "loginVC"
        static let signUpViewController = "signUpVC"
        static let tabBarController  = "tabC"
        static let homeNavigationController = "homeC"
        static let profileViewController = "profileVC"
        static let statsViewController = "statsVC"
        static let acctViewController  = "acctVC"
    }
    struct time{
        var changeableTime: String
        var dictionary: [String: Any]{
            return[
                "time": changeableTime
            ]
        }
    }
    struct LogTime{
        var time: [Float]
        
        var dictionary: [String: Any] {
            return [
                "time": time
            ]
        }
    }
    struct days{
        var  mon: String
        var tues: String
        var wed: String
        var thurs: String
        var fri: String
        var sat: String
        var sun: String
        var dictionary: [String: Any]{
            return[
                "mon": mon,
                "tues": tues,
                "wed": wed,
                "thurs": thurs,
                "fri": fri,
                "sat": sat,
                "sun": sun
                
            ]
        }
    }
}
