//
//  ComicListView.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import SwiftUI
import URLImage

struct ComicListView: View {
    @State private var isGrid: Bool = false
    
    @ObservedObject var viewModel = ComicListViewModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                ComicListContainerView(isGrid:isGrid, comics: viewModel.comics)
            }
            .navigationTitle("Comic books")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("View as \(isGrid ? "List" : "Grid")") {
                        isGrid = !isGrid
                    }
                }
            }
        }.onAppear(perform: getComicList).navigationViewStyle(StackNavigationViewStyle())
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
        GeometryReader { metrics in
            if isGrid {
                ScrollView(.vertical, showsIndicators: true, content: {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 16
                    ) {
                        Section() {
                            ForEach(0..<comics.count, id: \.self) { index in
                                NavigationLink(destination: IssueDetailView(comic: comics[index])) {
                                    VStack(alignment: .center) {
                                    URLImage(url: URL(string: comics[index].image?.originalUrl ?? "")!,
                                         content: { image in
                                             image
                                                 .resizable()
                                                 .scaledToFit()
                                         })
                                        Text(comics[index].issuedName()).lineLimit(1).minimumScaleFactor(0.8)
                                        Text(comics[index].readableDate()).lineLimit(1).minimumScaleFactor(0.5)
                                    }.frame(height: metrics.size.width/3)
                                                }
                            }
                        }
                    }
                })
            } else {
                List(comics) { comic in
                    NavigationLink(destination: IssueDetailView(comic: comic)) {
                        HStack(alignment: .top, spacing: 8, content: {
                            URLImage(url: URL(string: comic.image?.originalUrl ?? "")!,
                                 content: { image in
                                     image
                                         .resizable()
                                         .scaledToFit()
                                        .frame(width: metrics.size.height / 4, height:metrics.size.height/3)
                                 })
                            VStack(alignment: .center) {
                                Text(comic.issuedName())
                                Text(comic.readableDate())
                            }.frame(maxWidth: .infinity)
                        }).frame(height: metrics.size.height/3)
                    }
                }
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
