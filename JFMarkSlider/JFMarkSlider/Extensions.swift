//
//  Extensions.swift
//  JFMarkSlider
//
//  Created by HongXiangWen on 2020/9/8.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    
    var uniqued: [Element] {
        return Array(Set(self))
    }
}

extension UIView {
    
    func getSubviews<T: UIView>(_ type: T.Type) -> [T] {
        return subviews.filter { $0.isMember(of: type) } as? [T] ?? []
    }
}
