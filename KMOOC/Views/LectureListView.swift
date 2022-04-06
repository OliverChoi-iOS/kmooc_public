//
//  LectureListView.swift
//  KMOOC
//
//  Created by MacBook on 2022/04/06.
//

import SwiftUI

struct LectureListView: View {
    @ObservedObject var viewModel = KmoocListViewModel()
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(0..<viewModel.lecturesCount(), id: \.self) { i in
                    NavigationLink {
                        LectureDetailView(lectureId: viewModel.lecture(at: i).id)
                    } label: {
                        LectureListItemView(lecture: viewModel.lecture(at: i))
                            .listRowInsets(.init(top: 1, leading: 0, bottom: 1, trailing: 0))
                            .task {
                                if i == viewModel.lecturesCount() - 1 {
                                    viewModel.next()
                                }
                            }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("K-MOOC")
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            .refreshable {
                viewModel.list()
            }
            .task {
                if viewModel.lecturesCount() == 0 {
                    viewModel.list()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct LectureListView_Previews: PreviewProvider {
    static var previews: some View {
        LectureListView()
    }
}
