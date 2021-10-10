//
//  Logger.swift
//  Spendings
//
//  Created by Muhammad Adam on 09/10/2021.
//

import Foundation

//struct LogsConfig{
//    static let filesNamesEnabled = true
//}
//
//#if DEBUG
//let file = #file
//#else
//let file = ""
//#endif


// TODO: remove after testing
func infoLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    NSLog("#app #info: \(file.split(separator: "/").last ?? "") \(function) [\(line)] \(message)")
}

func debugLog(_ message:String = "", file:String = #file, function:String = #function, line:Int = #line){
    NSLog("#app #debug: \(file.split(separator: "/").last ?? "") \(function) [\(line)] \(message)")
}

func errorLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    NSLog("#app #error ❌: \(file.split(separator: "/").last ?? "") \(function) [\(line)] \(message)")
}


