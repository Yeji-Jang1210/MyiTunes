//
//  BaseVM.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import Foundation

import RxSwift
import RxCocoa

protocol BaseVMIO {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class BaseVM {
    let disposeBag = DisposeBag()
    
    deinit {
        print("\(self) deinitialize")
    }
    
    func bind(){}
}
