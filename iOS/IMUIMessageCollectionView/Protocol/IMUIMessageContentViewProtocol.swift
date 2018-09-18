//
//  IMUIMessageContentViewProtocol.swift
//  sample
//
//  Created by oshumini on 2017/6/11.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation
import UIKit

public protocol IMUIMessageContentViewProtocol: NSObjectProtocol {
  func layoutContentView(message: IMUIMessageModelProtocol)
  
  func Activity()
  func inActivity()
}

extension IMUIMessageContentViewProtocol {
    public func Activity() {}
    public func inActivity() {}
}
