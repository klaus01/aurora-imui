//
//  IMUIMessageProtocol.swift
//  sample
//
//  Created by oshumini on 2017/6/16.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation

public protocol IMUIMessageProtocol {
  /**
   *  @required function
   *
   *  @return message id to identifies this message
   */
  var msgId: String { get }
}
