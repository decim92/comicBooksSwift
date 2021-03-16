//
//  ComicListView.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import SwiftUI

struct ComicListView: View {
    
    @ObservedObject var viewModel = ComicListViewModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                List(viewModel.comics) { comic in
                    VStack(alignment: .leading) {
                        Text(comic.name ?? "No name available")
                    }
                }
            }
        }.onAppear(perform: getComicList)
    }
    
    private func getComicList() {
        viewModel.getComicList()
    }
}
//
//struct ComicListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicListView()
//    }
//}
