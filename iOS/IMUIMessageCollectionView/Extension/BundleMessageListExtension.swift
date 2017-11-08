//
//  BundleMessageListExtension.swift
//  sample
//
//  Created by oshumini on 2017/5/19.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation

extension Bundle {
  class func imuiBundle() -> Bundle {
    return Bundle(for: IMUIMessageCollectionView.self)
  }
}
