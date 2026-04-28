//
//  TestDemoApp.swift
//  TestDemo
//
//  Created by PGY on 2026/4/7.
//

import SwiftUI

@main
struct TestDemoApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView(model: ImgModel.init(ss: .timeLapse))
            CameraFormatPickerView()
            
        }
    }
}
