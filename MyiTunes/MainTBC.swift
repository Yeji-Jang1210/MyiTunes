//
//  MainTBC.swift
//  MyiTunes
//
//  Created by 장예지 on 8/8/24.
//

import UIKit

class MainTBC: UITabBarController {
    
    private enum Tab: Int, CaseIterable {
        case search
        
        var title: String {
            switch self {
            case .search:
                return "검색"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .search:
                return UIImage(systemName: "magnifyingglass")
            }
        }
        
        var vc: UIViewController {
            switch self {
            case .search:
                return UINavigationController(rootViewController: SearchiTunesVC(title: self.title))
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = UIColor.darkGray
        
        let viewControllers = Tab.allCases.map { tab -> UIViewController in
            let vc = tab.vc
            vc.tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, tag: tab.rawValue)
            
            return vc
        }
        
        self.viewControllers = viewControllers
    }
}
