//
//  ComicListView.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import SwiftUI
import URLImage

struct ComicListView: View {
    @State private var isGrid: Bool = true
    
    @ObservedObject var viewModel = ComicListViewModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                ComicListContainerView(isGrid:isGrid, comics: viewModel.comics)
            }
        }.onAppear(perform: getComicList)
    }
    
    private func getComicList() {
        viewModel.getComicList()
    }
}

struct ComicListContainerView: View {
    var isGrid: Bool
    var comics:[Comic]
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public init(isGrid: Bool, comics: [Comic]) {
        self.isGrid = isGrid
        self.comics = comics
    }
    
    @ViewBuilder
    var body: some View {
        if isGrid {
            ScrollView(.vertical, showsIndicators: true, content: {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 16
                ) {
                    Section() {
                        ForEach(0..<comics.count, id: \.self) { index in
                            VStack(alignment: .center) {
                            URLImage(url: URL(string: comics[index].image?.originalUrl ?? "")!,
                                 content: { image in
                                     image
                                         .resizable()
                                         .scaledToFit()
                                        .frame(height:160)
                                 })
                                Text(comics[index].issuedName()).lineLimit(1).minimumScaleFactor(0.8)
                                Text(comics[index].readableDate()).lineLimit(1).minimumScaleFactor(0.5)
                            }.frame(maxWidth: .infinity)
                        }
                    }
                }
            })
        } else {
            List(comics) { comic in
                HStack(alignment: .top, spacing: 8, content: {
                    URLImage(url: URL(string: comic.image?.originalUrl ?? "")!,
                         content: { image in
                             image
                                 .resizable()
                                 .scaledToFit()
                                .frame(width: 120, height:160)
                         })
                    VStack(alignment: .center) {
                        Text(comic.issuedName())
                        Text(comic.readableDate())
                    }.frame(maxWidth: .infinity)
                })
            }
        }
    }
}
//
//struct ComicListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicListView()
//    }
//}
