//
//  IssueDetailView.swift
//  Comic Books
//
//  Created by Douglas Poveda on 16/03/21.
//

import SwiftUI
import URLImage

struct IssueDetailView: View {
    var comic:Comic
    
    @ObservedObject var viewModel = IssueDetailViewModel()
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                LoadingView(isShowing: .constant(viewModel.isLoading)) {
                    VStack {
                        URLImage(url: URL(string: viewModel.issueDetail?.image?.screenLargeUrl ?? comic.image?.screenLargeUrl ?? "")!,
                             content: { image in
                                 image
                                     .resizable()
                                     .scaledToFit()
                             })
                        Text(comic.issuedName())
                        Spacer()
                        
                    }
                }
            }.onAppear(perform: getIssueDetail)
        }
    }
    
    private func getIssueDetail() {
        viewModel.getIssueDetail(with: comic.apiDetailUrl ?? "")
    }
}

//struct CreditListView: View {
//
//}
