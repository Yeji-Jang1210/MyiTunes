//
//  ScreenshotSectionModel.swift
//  MyiTunes
//
//  Created by 장예지 on 8/11/24.
//

import Foundation
import RxDataSources

struct ScreenshotSectionModel {
    var items: [URL]
    
    init(items: [URL]) {
        self.items = items
    }
}

extension ScreenshotSectionModel: SectionModelType {
    init(original: ScreenshotSectionModel, items: [URL]) {
        self = original
        self.items = items
    }
}
