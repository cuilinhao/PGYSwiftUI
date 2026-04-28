

import SwiftUI

// MARK: - Models

enum ImageFormat: String, CaseIterable {
    case heif = "HEIF"
    case tiff = "TIFF"
    case proRAW = "ProRAW"
}

enum Resolution: String, CaseIterable {
    case mp12 = "12MP"
    case mp48 = "48MP"

    var subtitle: String? {
        switch self {
        case .mp48: return "仅M档支持"
        default: return nil
        }
    }
}

// MARK: - Format Picker 上面三个

struct FormatSegmentedPicker: View {
    @Binding var selection: ImageFormat

    var body: some View {
        HStack(spacing: 0) {
            ForEach(ImageFormat.allCases, id: \.self) { format in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selection = format
                    }
                } label: {
                    Text(format.rawValue)
                        .font(.system(size: 15, weight: selection == format ? .semibold : .regular))
                        .foregroundColor(selection == format ? .white : Color.white.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            Group {
                                if selection == format {
                                    Capsule()
                                        .stroke(Color.orange, lineWidth: 2)
                                        .padding(1)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 4)
        .background(Color(.systemPurple))
        .clipShape(Capsule())
    }
}

// MARK: - Resolution Picker 下面2个

struct ResolutionPicker: View {
    @Binding var selection: Resolution

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Resolution.allCases.indices, id: \.self) { index in
                let res = Resolution.allCases[index]

                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selection = res
                    }
                } label: {
                    HStack(spacing: 3) {
                        Text(res.rawValue)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(selection == res ? .orange : Color.white.opacity(0.5))

                        if let sub = res.subtitle {
                            Text(sub)
                                .font(.system(size: 10))
                                .foregroundColor(Color.white.opacity(0.45))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)

                // Divider between items
                if index < Resolution.allCases.count - 1 {
                    Rectangle()
                        .fill(Color.white.opacity(0.25))
                        .frame(width: 1, height: 16)
                }
            }
        }
        .background(Color(white: 0.15).opacity(0.6))
        .clipShape(Capsule())
    }
}

    // MARK: - Combined View 所有的视图

struct CameraFormatPickerView: View {
    @State private var selectedFormat: ImageFormat = .tiff
    @State private var selectedResolution: Resolution = .mp12

    var body: some View {
        ZStack {
            // Dark camera-like background
            Color(.systemGreen)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                FormatSegmentedPicker(selection: $selectedFormat)
                    .frame(width: 280)

                ResolutionPicker(selection: $selectedResolution)
                Spacer()
            }
            .padding(.top, 90)
            
            
            // TODO: - TODO
            Color.blue
                .frame(width: 200, height: 200)
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .center) {
//                        Capsule()//胶囊
//                            .frame(width: 100, height: 100)
                        Ellipse() //椭圆
                            .frame(width: 100, height: 120, alignment: .top)
                        
                    }
                }
        }
        
        
    }
}

// MARK: - Preview

#Preview {
    CameraFormatPickerView()
}


////
////  ContentView.swift
////  TestDemo
////
////  Created by PGY on 2026/4/7.
////
//
//import SwiftUI
//
//
//struct ImgModel {
//    
//    var ss: pngName = .longExposure
//    
//    enum pngName {
//        case photo, video, timeLapse, longExposure
//        
//        var icon: String {
//            switch self {
//            case .photo:
//                "camera.fill"
//            case .video:
//                "video.fill"
//            case .timeLapse:
//                "timelapse"
//            case .longExposure:
//                "slowmo"
//            }
//        }
//        
//        
//    }
//    
//    
//}
//
////struct ContentView: View {
////    @State var  model: ImgModel
////    
////    var body: some View {
////        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Hello, world!")
////            
////            Image(systemName: "f.cursive")
////                .font(.caption.weight(.semibold))
////                .foregroundStyle(.white)
////            
////            Image(systemName: self.model.ss.icon)
////                .font(.caption.weight(.bold))
////                .foregroundStyle(.green)
////                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
////            
////        }
////        .background(Color.red)
////        .background(Color.green)
////        .padding()
////    }
////}
//
//
//// 主视图（完全基于你的代码修改）
//struct ContentView: View {
//    @State var model: ImgModel
//    
//    var body: some View {
//        // 外层用 ZStack，让按钮可以全屏定位
//        ZStack {
//            // 你原来的所有 UI 代码 100% 保留
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//                
//                Image(systemName: "f.cursive")
//                    .font(.caption.weight(.semibold))
//                    .foregroundStyle(.white)
//                
//                Image(systemName: self.model.ss.icon)
//                    .font(.caption.weight(.bold))
//                    .foregroundStyle(.green)
//                    .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
//            }
//            .background(Color.red)
//            .background(Color.green)
//            .padding()
//            
//            
//            // 👇 按钮：距离屏幕上边 100 / 左边 60
//            Button(action: {
//                print("点我干嘛")
//            }) {
//                Text("登录")
//                    .font(.title)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 20)
//                    .background(Color(red: 1.0, green: 0.2, blue: 0.3))
//                    .cornerRadius(40)
//            }
//            // 定位：左60、上100
//            .padding(.leading, 60)
//            .padding(.top, 100)
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        }
//    }
//}
//
//#Preview {
//    ContentView(model: ImgModel.init(ss: .timeLapse))
//}
