//
//  IssueDetailViewModel.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftUI
import Combine

class IssueDetailViewModel: ObservableObject, Identifiable {
    
    @Published var issueDetail:IssueDetail?
    @Published var isLoading = false
    
    
    private var disposables: Set<AnyCancellable> = []
    
    var issueDetailAPI = IssueDetailAPI()
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        issueDetailAPI.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
    private var issueDetailPublisher: AnyPublisher<IssueDetail?, Never> {
        issueDetailAPI.$issueDetail
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return nil
                }
                
                return response 
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        
        issueDetailPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.issueDetail, on: self)
            .store(in: &disposables)
    }
    
    func getIssueDetail(with url:String) {
        issueDetailAPI.getIssueDetail(with: url)
    }
    
}
