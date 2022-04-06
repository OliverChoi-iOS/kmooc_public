//
//  LectureDetailView.swift
//  KMOOC
//
//  Created by MacBook on 2022/04/06.
//

import SwiftUI

struct LectureDetailView: View {
    @ObservedObject var viewModel = KmoocDetailViewModel()
    @State var courseImageLarge: UIImage?
    @State var webViewHeight = CGFloat.zero
    
    init(lectureId: String) {
        viewModel.lectureId = lectureId
    }
    
    var body: some View {
        ZStack {
            List {
                Group {
                    if courseImageLarge != nil {
                        Image(uiImage: courseImageLarge!)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text("• 강좌번호 : \(viewModel.lecture.number)")
                        .padding()
                    
                    Text("• 강좌분류 : \(viewModel.lecture.classfyName)")
                        .padding()
                    
                    Text("• 운영기관 : \(viewModel.lecture.orgName)")
                        .padding()
                    
                    Text("• 교수정보 : \(viewModel.lecture.teachers ?? "")")
                        .padding()
                    
                    Text("• 운영기간 : \(DateUtil.formatDate(viewModel.lecture.start)) ~ \(DateUtil.formatDate(viewModel.lecture.end))")
                        .padding()
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(red: 0.8901960784313725, green: 0.8901960784313725, blue: 0.8901960784313725))
                    
                    if viewModel.lecture.overview != nil {
                        LectureDetailWebView(htmlStringToLoad: viewModel.lecture.overview!, webViewHeight: $webViewHeight)
                            .frame(height: webViewHeight)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            } //List
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.detail {
                    ImageLoader.loadImage(url: viewModel.lecture.courseImageLarge) { image in
                        courseImageLarge = image
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        } //ZStack
    } //body
}

struct LectureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LectureDetailView(lectureId: "")
    }
}
