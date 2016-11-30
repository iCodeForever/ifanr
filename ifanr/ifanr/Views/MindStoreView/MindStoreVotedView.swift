//
//  MindStoreVotedView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/8.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MindStoreVotedView: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    fileprivate lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 20, height: 20)
        var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionviewcellid")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}


extension MindStoreVotedView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath)
        let imageView = UIImageView()
//        imageView.if_setAvatarImage(<#T##url: NSURL!##NSURL!#>)
        cell.contentView.addSubview(imageView)
        return cell
    }
}
