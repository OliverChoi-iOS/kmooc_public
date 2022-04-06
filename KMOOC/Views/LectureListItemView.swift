//
//  LectureListItemView.swift
//  KMOOC
//
//  Created by MacBook on 2022/04/06.
//

import SwiftUI

struct LectureListItemView: View {
    var lecture: Lecture
    @State var courseImage: UIImage?
    
    var body: some View {
        HStack(spacing: 20) {
                if courseImage != nil {
                    Image(uiImage: courseImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3 / 16 * 9)
                        .clipped()
                }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(lecture.name)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .padding(.bottom, 10)
                
                Text(lecture.orgName)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                
                Text("\(DateUtil.formatDate(lecture.start)) ~ \(DateUtil.formatDate(lecture.end))")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .task {
            ImageLoader.loadImage(url: lecture.courseImage) { image in
                courseImage = image
            }
        }
    }
}

struct LectureListItemView_Previews: PreviewProvider {
    static var previews: some View {
        LectureListItemView(lecture: Lecture(id: "0000", number: "test-0000", name: "test", classfyName: "test", middleClassfyName: "test", courseImage: "", courseImageLarge: "", shortDescription: "this is test", orgName: "testorg", start: Date(), end: Date(), teachers: "test1 test2 test3", overview: nil))
    }
}
