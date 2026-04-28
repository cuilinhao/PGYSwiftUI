

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
}

// MARK: - Format Picker 上面三个

struct FormatSegmentedPicker: View {
    @Binding var selection: ImageFormat

    var body: some View {
        HStack(spacing: 0) {
            // 第一行 3个胶囊 TIFF
            ForEach(ImageFormat.allCases, id: \.self) { format in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selection = format
                    }
                } label: {
                    Text(format.rawValue)
                        .font(.system(size: 15, weight: selection == format ? .semibold : .medium))
                        .foregroundStyle(selection == format ? .white : .white.opacity(0.85))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(
                            Group {
                                if selection == format {
                                    Capsule()
                                        .stroke(.orange, lineWidth: 1.2)
                                        .padding(1)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 4)
        .background(.black.opacity(0.55))
        .clipShape(Capsule())
    }
}

// MARK: - Resolution Picker 下面2个 12MP | 48MP

struct ResolutionPicker: View {
    @Binding var selection: Resolution
    @Binding var telephotoSelection: Resolution

    var isAutoMode: Bool
    var isTelephotoMode: Bool
    var isPhotoHighResSupported: Bool

    private var isAutoOnlyUnsupported: Bool {
        isAutoMode && !isTelephotoMode
    }

    private var selectedColor: Color {
        .orange
    }

    var body: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if isTelephotoMode {
                        telephotoSelection = .mp12
                    }
                    selection = .mp12
                }
            } label: {
                Text(verbatim: "12MP")
                    .fontWeight(selection == .mp12 ? .semibold : .medium)
                    .foregroundStyle(selection == .mp12 ? selectedColor : .white.opacity(0.65))
                    .padding(.leading, 24)
                    .padding(.trailing, 22)
                    .padding(.vertical, 7)
            }
            .buttonStyle(.plain)

            Rectangle()
                .fill(.white.opacity(0.38))
                .frame(width: 1, height: 15)

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if isTelephotoMode {
                        telephotoSelection = .mp48
                    }
                    selection = .mp48
                }
            } label: {
                HStack(spacing: 2) {
                    Text(verbatim: "48MP")
                        .fontWeight(selection == .mp48 ? .semibold : .medium)
                        .foregroundStyle(
                            selection == .mp48
                            ? selectedColor
                            : .white.opacity(isAutoOnlyUnsupported ? 0.45 : 0.65)
                        )

                    if isAutoOnlyUnsupported {
                        Text("(仅M档支持)")
                            .font(.system(size: 9))
                            .foregroundStyle(.white.opacity(0.45))
                    }
                }
                .padding(.leading, 22)
                .padding(.trailing, isAutoOnlyUnsupported ? 11 : 24)
                .padding(.vertical, 7)
            }
            .buttonStyle(.plain)
        }
        .font(.system(size: 14))
        .background(.black.opacity(0.48))
        .clipShape(Capsule())
    }
}

    // MARK: - Combined View 所有的视图

struct CameraFormatPickerView: View {
    
    @State private var selectedFormat: ImageFormat = .tiff
    @State private var selectedResolution: Resolution = .mp12
    @State private var selectedTelephotoResolution: Resolution = .mp12
    @State private var isAutoMode = true
    @State private var isTelephotoMode = false
    @State private var isPhotoHighResSupported = true

    var body: some View {
        ZStack {
            // Dark camera-like background
            LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.14, blue: 0.10),
                    Color(red: 0.42, green: 0.43, blue: 0.36)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()

            VStack(spacing: 14) {
                FormatSegmentedPicker(selection: $selectedFormat)
                    .frame(width: 360)

                ResolutionPicker(
                    selection: $selectedResolution,
                    telephotoSelection: $selectedTelephotoResolution,
                    isAutoMode: isAutoMode,
                    isTelephotoMode: isTelephotoMode,
                    isPhotoHighResSupported: isPhotoHighResSupported
                )
                Spacer()
            }
            .padding(.top, 18)
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
