//
//  BaseListViewController.swift
//  SimpleNotes
//
//  Created by João Palma on 20/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import LBTATools
import UIKit
import Foundation

public class BaseListViewController<TViewModel : ViewModel, T: LBTAListCell<U>, U> : BaseCollectionViewController<TViewModel> {
    
    open var items = [U]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    fileprivate let supplementaryViewId = "supplementaryViewId"
    
    /// Return an estimated height for proper indexPath using systemLayoutSizeFitting.
    open func estimatedCellHeight(for indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let cell = T()
        let largeHeight: CGFloat = 1000
        cell.frame = .init(x: 0, y: 0, width: cellWidth, height: largeHeight)
        cell.item = items[indexPath.item]
        cell.layoutIfNeeded()
        
        return cell.systemLayoutSizeFitting(.init(width: cellWidth, height: largeHeight)).height
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(T.self, forCellWithReuseIdentifier: cellId)
    }
    
    /// ListHeaderController automatically dequeues your T cell and sets the correct item object on it.
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! T
        cell.item = items[indexPath.row]
        cell.parentController = self
        return cell
    }
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    /// If you don't provide this, headers and footers for UICollectionViewControllers will be drawn above the scroll bar.
    override open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = -1
    }
    
    /**
     Initializes your ListHeaderController with a plain UICollectionViewFlowLayout.
     
     ## Parameters ##
     scrollDirection: direction that your cells will be rendered
     
     */
    public init(scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        super.init(collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Fatal Error on CollectionView")
    }
    
}
