#!/usr/bin/env xcrun swift

/*
 * <bitbar.title>Battery Dot</bitbar.title>
 * <bitbar.version>v1.0</bitbar.version>
 * <bitbar.author>alex_rockt</bitbar.author>
 * <bitbar.author.github>alex_rockt</bitbar.author.github>
 * <bitbar.desc>Displays a coloured dot for trackpad, keyboard and laptop battery in the menu bar that changes from green to yellow to red the lower the power gets - based on the trackpad-dot plugin by Manu Wallner (https://getbitbar.com/plugins/System/trackpad-dot.1h.swift).
 The plugin uses ANSI colors to display all three battery levels next to each other - the downside is that it's limited to the ANSI colors - so no orange available</bitbar.desc>
 * <bitbar.image>http://i.imgur.com/3EimpGH.png</bitbar.image>
 * <bitbar.dependencies>Xcode,swift</bitbar.dependencies>
 */

import Foundation


var numberOfUKCases:String = "408 ERROR"
var numberOfWorldCases:String = "408 ERROR"
var numberOfNewCases:String = "408 ERROR"
var deathRate:String = "408 ERROR"
var numberOfDeaths:String = "404 ERROR"
var numberOfWorldCasesInt = "DAVDIDDIDIID"
var numberOfDeathsInt = "DAVDIDDIDIID"
var dataString2 = "Dave"
//var numberOfWorldCasesArray:Array = ["1","2","3"]
//var numberOfDeathsCasesArray:Array = ["1","2","3"]
//var numberOfWorldCasesInt:Int = 123
//var numberOfDeathsCasesInt:Int = 123

let url = NSURL(string: "https://www.worldometers.info/coronavirus/")!
let request = NSMutableURLRequest(url:url as URL)
let task = URLSession.shared.dataTask(with: request as URLRequest) {
    data, response, error in
    
    if error != nil{
        print(error.debugDescription)
        print("404")
    }
    else {
        if let unwrappedData = data{
            
            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)!
            
            dataString2 = String(dataString)
            
            if let index = (dataString2.range(of: "00;\">")?.upperBound) {
                
                let afterEqualsTo = String(dataString2.suffix(from: index))
                
                if let index2 = (afterEqualsTo.range(of: "</td>")?.lowerBound) {
                    
                    numberOfNewCases = String(afterEqualsTo.prefix(upTo: index2))
                    
                    
                }
            }
            
            if let index = (dataString2.range(of: "color:#aaa\">")?.upperBound) {
                
                let afterEqualsTo = String(dataString2.suffix(from: index))
                
                if let index2 = (afterEqualsTo.range(of: " </span>")?.lowerBound) {
                    
                    numberOfWorldCases = String(afterEqualsTo.prefix(upTo: index2))
                    
                    //numberOfWorldCasesArray = numberOfWorldCases.components(separatedBy: ",")
                    
                    // numberOfWorldCasesInt = Int(numberOfWorldCasesArray.joined(separator:""))
                    
                    let numberOfWorldCasesArray = numberOfWorldCases.components(separatedBy: ",")
                    
                    numberOfWorldCasesInt = numberOfWorldCasesArray.joined(separator:"")
                    
                    
                    
                }
            }
            
            if let index = (dataString2.range(of: "UK</a> </td> <td style=\"font-weight: bold; text-align:right\">")?.upperBound) {
                
                let afterEqualsTo = String(dataString2.suffix(from: index))
                
                if let index2 = (afterEqualsTo.range(of: "</td>")?.lowerBound) {
                    
                    numberOfUKCases = String(afterEqualsTo.prefix(upTo: index2))
                    
                }
            }
            
            if let index = (dataString2.range(of: "le\"> ")?.upperBound) {
                
                let afterEqualsTo = String(dataString2.suffix(from: index))
                
                if let index2 = (afterEqualsTo.range(of: "<")?.lowerBound) {
                    
                    numberOfDeaths = String(afterEqualsTo.prefix(upTo: index2))
                    
                    let numberOfDeathsArray = numberOfDeaths.components(separatedBy: ",")
                    
                    numberOfDeathsInt = numberOfDeathsArray.joined(separator:"")
                    
                    
                }
            }
        }
    }
    
    
    
}

task.resume()



do {
    sleep(3)
}

if dataString2.contains("COVID-19") == false {
    
    print("⬆")
    
} else {
    
    
    
    
    let test = Int(numberOfWorldCasesInt)!
    let test2 = Int(numberOfDeathsInt)!

    let test3 = ((Double(test2) / Double(test)) * 100)

    let test4 = Double(round(100*test3)/100)



    print(String(numberOfNewCases) + " ⬆")
    print("---")
    print("🇬🇧 " + String(numberOfUKCases))
    print("🌍 " + String(numberOfWorldCases))
    print("☠️ " + String(test4) + "%")
    print("---")
    print("COVID-19 Statistics | href=\"https://www.worldometers.info/coronavirus/\"")
    
    
}

