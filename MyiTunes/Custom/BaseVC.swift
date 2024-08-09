//
//  BaseVC.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    deinit {
        print("\(self) deinitialize")
    }
    
    func configureHierarchy(){}
    
    func configureLayout(){}
    
    func configureUI(){}
    
    func bind(){}
}
