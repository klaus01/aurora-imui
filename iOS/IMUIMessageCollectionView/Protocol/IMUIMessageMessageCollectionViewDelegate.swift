//
//  IMUIMessageMessageCollectionViewDelegate.swift
//  IMUIChat
//
//  Created by oshumini on 2017/4/13.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation
import UIKit

/**
 *  The `IMUIMessageMessageCollectionViewDelegate` protocol defines the even callback delegate
 */
public protocol IMUIMessageMessageCollectionViewDelegate: NSObjectProtocol {
  /**
   *  Tells the delegate that user tap message cell
   */
  func messageCollectionView(_: UICollectionView, forItemAt: IndexPath, model: IMUIMessageProtocol)
  
  /**
   *  Tells the delegate that user tap message bubble
   */
  func messageCollectionView(didTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol)

  /**
   *  Tells the delegate that user long press message bubble
   */
  func messageCollectionView(beganLongTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol)
  /**
   *  Tells the delegate that user tap header image in message cell
   */
  func messageCollectionView(didTapHeaderImageInCell: UICollectionViewCell, model: IMUIMessageProtocol)
  
  /**
   *  Tells the delegate that user tap statusView in message cell
   */
  func messageCollectionView(didTapStatusViewInCell: UICollectionViewCell, model: IMUIMessageProtocol)
  
  /**
   *  Tells the delegate that the message cell will show in screen
   */
  func messageCollectionView(_: UICollectionView, willDisplayMessageCell: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol)
  
  /**
   *  Tells the delegate that message cell end displaying
   */
  func messageCollectionView(_: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol)
  
  /**
   *  Tells the delegate when messageCollection beginDragging
   */
  func messageCollectionView(_ willBeginDragging: UICollectionView)
  
  func messageCollectionViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
  func messageCollectionViewDidEndDecelerating(_ scrollView: UIScrollView)
    
  /**
   *  return a messageCell, it will show in messageList. Can use it to show message event or anything.
   *  @optional function 
   *  (NOTE:  1. You need append a model in IMUIMessageMessageCollectionView frist.
   *          2. If it is not a custom message, you should return nil)
   */
  func messageCollectionView(messageCollectionView: UICollectionView, forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> UICollectionViewCell?
  
  /**
   *  return a messageCell‘s height,
   *  @return messageCell height
   *  @optional function (NOTE: when you need custom message cell, you should implement this function and return the custom message cell's height, If it is not a custom message，you need return nil)
   */
  func messageCollectionView(messageCollectionView: UICollectionView, heightForItemAtIndexPath forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> NSNumber?

}

extension IMUIMessageMessageCollectionViewDelegate {
    public func messageCollectionView(_: UICollectionView, forItemAt: IndexPath, model: IMUIMessageProtocol) {}
    public func messageCollectionView(didTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol) {}
    public func messageCollectionView(beganLongTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol) {}
    public func messageCollectionView(didTapHeaderImageInCell: UICollectionViewCell, model: IMUIMessageProtocol) {}
    public func messageCollectionView(didTapStatusViewInCell: UICollectionViewCell, model: IMUIMessageProtocol) {}
    public func messageCollectionView(_: UICollectionView, willDisplayMessageCell: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol) {}
    public func messageCollectionView(_: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol) {}
    public func messageCollectionView(_ willBeginDragging: UICollectionView) {}
    public func messageCollectionViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    public func messageCollectionViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    public func messageCollectionView(messageCollectionView: UICollectionView, forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> UICollectionViewCell? { return nil }
    public func messageCollectionView(messageCollectionView: UICollectionView, heightForItemAtIndexPath forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> NSNumber? { return nil }
}
