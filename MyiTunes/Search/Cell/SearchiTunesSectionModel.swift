//
//  SearchiTunesSectionModel.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import Foundation
import RxDataSources

struct SearchiTunesSectionModel {
    var items: [iTunesCollectionViewCellVM]
    
    init(items: [iTunesCollectionViewCellVM]) {
        self.items = items
    }
}

extension SearchiTunesSectionModel: SectionModelType {
    init(original: SearchiTunesSectionModel, items: [iTunesCollectionViewCellVM]) {
        self = original
        self.items = items
    }
}
