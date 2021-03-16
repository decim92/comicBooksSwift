//
//  ComicListViewModel.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftUI
import Combine

class ComicListViewModel: ObservableObject, Identifiable {
    
    @Published var comics = [Comic]()
    @Published var isLoading = false
    
    
    private var disposables: Set<AnyCancellable> = []
    
    var comicAPI = ComicAPI()
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        comicAPI.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
    private var comicListPublisher: AnyPublisher<[Comic], Never> {
        comicAPI.$comicList
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return []
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
        
        
        comicListPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.comics, on: self)
            .store(in: &disposables)
    }
    
    func getComicList() {
        comicAPI.getComicList()
    }
    
}
