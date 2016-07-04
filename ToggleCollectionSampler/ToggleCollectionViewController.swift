//
//  ToggleCollectionViewController.swift
//  ToggleCollectionSampler
//
//  Created by tanaka.takaaki on 2016/06/29.
//  Copyright © 2016年 tanaka.takaaki. All rights reserved.
//

import UIKit

struct Item {
    let id: String
    let name: String
    let description: String
}

enum CellType {
    case List
    case Grid
    
    func layoutFromSuperviewRect(rect: CGRect) -> UICollectionViewFlowLayout {
        switch self {
        case .List:
            let layout = UICollectionViewFlowLayout()
            
            layout.itemSize = CGSize(width: rect.size.width, height: 60)
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            return layout
        case .Grid:
            let layout = UICollectionViewFlowLayout()
            
            layout.itemSize = CGSize(width: (rect.size.width - 30) / 2, height: (rect.size.width - 30) / 2)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
            return layout
        }
    }
    
    var toggleButtonItemTitle: String {
        switch self {
        case .List:
            return "LIST"
        case .Grid:
            return "GRID"
        }
    }
}

class ToggleCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toggleButtonItem: UIBarButtonItem!
    
    private var cellType: CellType = .List
    private var items: [Item] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleButtonItem?.title = cellType.toggleButtonItemTitle
        
        
        let bounds = UIScreen.mainScreen().bounds
        
        collectionView?.collectionViewLayout = cellType.layoutFromSuperviewRect(bounds)
        
        for id in 0..<50 {
            let item = Item(id: "\(id)", name: "name: " + "\(id)", description: "description: " + "\(id)")
            items.append(item)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // MARK: - UI Handler
    @IBAction func didTapToggleButtonItem(sender: AnyObject) {
        
        switch cellType {
        case .List:
            cellType = .Grid
        case .Grid:
            cellType = .List
        }
        
        UIView.animateWithDuration(0.5, animations: { [weak self] in
            guard let `self` = self else { return }
            
            self.collectionView?.collectionViewLayout = self.cellType.layoutFromSuperviewRect(self.collectionView!.frame)
            
            self.collectionView?.visibleCells().forEach { cell in
                guard let _cell = cell as? ToggleCollectionCell else { return }
                
                _cell.updateConstraintsWithCellType(self.cellType)
            }
            
        }, completion: { [weak self] _ in
            guard let `self` = self else { return }
            
            self.toggleButtonItem.title = self.cellType.toggleButtonItemTitle
        })
    }
}

// MARK: - UICollectionViewDataSource
extension ToggleCollectionViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ToggleCollectionCell", forIndexPath: indexPath) as? ToggleCollectionCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.configureWithItem(item, cellType: cellType)
        
        return cell
    }
}
