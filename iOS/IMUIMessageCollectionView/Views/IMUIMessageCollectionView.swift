//
//  IMUIMessageCollectionView.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/2.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit


open class IMUIMessageCollectionView: UIView {

  open lazy var messageCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .vertical
    layout.headerReferenceSize = CGSize.zero
    layout.footerReferenceSize = CGSize.zero
    layout.sectionInset = UIEdgeInsets.zero

    let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    view.backgroundColor = UIColor.clear
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    view.delegate = self
    view.dataSource = self
    view.register(IMUIBaseMessageCell.self, forCellWithReuseIdentifier: IMUIBaseMessageCell.self.description())
    view.isScrollEnabled = true
    return view
  }()

  var viewCache = IMUIReuseViewCache()
  
  var chatDataManager = IMUIChatDataManager()
  open weak var delegate: IMUIMessageMessageCollectionViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(messageCollectionView)
    self.chatDataManager = IMUIChatDataManager()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.addSubview(messageCollectionView)
    self.chatDataManager = IMUIChatDataManager()
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    IMUIMessageCellLayout.cellWidth = self.imui_width
  }
  
  open func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    self.messageCollectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
  }
  
  open subscript(index: Int) -> IMUIMessageProtocol {
    return chatDataManager[index]
  }
  
  open subscript(msgId: String) -> IMUIMessageProtocol? {
    return chatDataManager[msgId]
  }
  
  open var messageCount: Int {
    return chatDataManager.count
  }
  
  open func scrollToBottom(with animated: Bool) {
    if chatDataManager.count == 0 { return }
    let endIndex = IndexPath(item: chatDataManager.endIndex - 1, section: 0)
    self.messageCollectionView.scrollToItem(at: endIndex, at: .bottom, animated: animated)
  }
  
  open func appendMessage(with message: IMUIMessageProtocol) {
    self.chatDataManager.appendMessage(with: message)
    self.messageCollectionView.reloadData()
    self.scrollToBottom(with: true)
  }
    
  open func appendMessages(with messages: [IMUIMessageProtocol]) {
    self.chatDataManager.appendMessages(with: messages)
    self.messageCollectionView.reloadData()
    self.scrollToBottom(with: true)
  }

  open func insertMessage(with message: IMUIMessageProtocol) {
    self.chatDataManager.insertMessage(with: message)
    self.messageCollectionView.reloadDataNoScroll()
  }
  
  open func insertMessages(with messages:[IMUIMessageProtocol]) {
    self.chatDataManager.insertMessages(with: messages)
    self.messageCollectionView.reloadDataNoScroll()
  }
  
  open func updateMessage(with message:IMUIMessageProtocol) {
    self.chatDataManager.updateMessage(with: message)
    if let index = chatDataManager.index(of: message) {
      let indexPath = IndexPath(item: index, section: 0)
      self.messageCollectionView.reloadItems(at: [indexPath])
    }
  }
  
  open func removeMessage(with messageId: String) {
    self.chatDataManager.removeMessage(with: messageId)
    self.messageCollectionView.reloadDataNoScroll()
  }
  
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension IMUIMessageCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.chatDataManager.count
  }
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    collectionView.collectionViewLayout.invalidateLayout()
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = self.delegate?.messageCollectionView?(messageCollectionView: collectionView, heightForItemAtIndexPath: indexPath, messageModel: chatDataManager[indexPath.item])
    if let _ = height {
      return CGSize(width: collectionView.superview!.imui_width, height: CGFloat(height!.floatValue))
    }
    
    let messageModel = chatDataManager[indexPath.item]
    if messageModel is IMUIMessageModelProtocol {
      let message = messageModel as! IMUIMessageModelProtocol
      return CGSize(width: collectionView.superview!.imui_width, height: message.layout.cellHeight)
    }
    
    return CGSize.zero
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var cellIdentify = ""
    let messageModel = self.chatDataManager[indexPath.item]
    cellIdentify = IMUIBaseMessageCell.self.description()

    let customCell = self.delegate?.messageCollectionView?(messageCollectionView: collectionView, forItemAt: indexPath, messageModel: messageModel)
    if let _ = customCell {
      return customCell!
    }
    
    let cell: IMUIMessageCellProtocol = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify, for: indexPath) as! IMUIMessageCellProtocol
    
    cell.presentCell(with: messageModel as! IMUIMessageModelProtocol, viewCache: viewCache, delegate: delegate)
    self.delegate?.messageCollectionView?(collectionView,
                                         willDisplayMessageCell: cell as! UICollectionViewCell,
                                         forItemAt: indexPath,
                                         model: messageModel)
    
    return cell as! UICollectionViewCell
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    let messageModel = self.chatDataManager[indexPath.item]
    
    self.delegate?.messageCollectionView?(collectionView, forItemAt: indexPath, model: messageModel)
  }


  public func collectionView(_ collectionView: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath) {
    if forItemAt.item >= self.chatDataManager.count {
      return
    }
    
    let messageModel = self.chatDataManager[forItemAt.item]
    
    if messageModel is IMUIMessageModelProtocol {
      (didEndDisplaying as! IMUIMessageCellProtocol).didDisAppearCell()
      self.delegate?.messageCollectionView?(collectionView, didEndDisplaying: didEndDisplaying, forItemAt: forItemAt, model: messageModel)
    }
    
  }
}


extension IMUIMessageCollectionView: UIScrollViewDelegate {
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.delegate?.messageCollectionView?(self.messageCollectionView)
  }
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.delegate?.messageCollectionViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    self.delegate?.messageCollectionViewDidEndDecelerating?(scrollView)
  }
}

public extension UICollectionView {
  func reloadDataNoScroll() {
    var currentOffset = self.contentOffset
    let contentSizeBeforeInsert = self.collectionViewLayout.collectionViewContentSize
    
    self.reloadData();
    
    let contentSizeAfterInsert = self.collectionViewLayout.collectionViewContentSize
    
    let deltaHeight = contentSizeAfterInsert.height - contentSizeBeforeInsert.height
    currentOffset.y += (deltaHeight > 0 ? deltaHeight : 0)
    self.setContentOffset(currentOffset, animated: false)
  }
}
