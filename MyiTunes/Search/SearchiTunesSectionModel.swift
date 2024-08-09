//
//  SearchiTunesSectionModel.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import Foundation
import RxDataSources

struct SearchiTunesSectionModel {
    var items: [String]
    
    init(items: [String]) {
        self.items = items
    }
}

extension SearchiTunesSectionModel: SectionModelType {
    init(original: SearchiTunesSectionModel, items: [String]) {
        self = original
        self.items = items
    }
}
