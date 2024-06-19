//
//  HomeVC.swift
//  Lesson-61-Unsplash
//
//  Created by Mustafo Asqarov on 19/03/2022.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    @IBOutlet weak var randomImgView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var images: [URL] = []
    
    var currentPage: Int = 1
    let perPage = 15
    var isPageRefreshing:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        API.shared.getRandomImages { imgURL in
            self.randomImgView.sd_imageIndicator = SDWebImageActivityIndicator.large
            self.randomImgView.sd_setImage(with: imgURL)
            
            API.shared.getLatestImages(type: .small, page: self.currentPage, perPage: self.perPage) { imgs in
                self.images = imgs
                self.collectionView.reloadData()
            }
        }

    }


}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.updateCell(imgURL: images[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
                if !isPageRefreshing {
                    isPageRefreshing = true
                    currentPage += 1
                    API.shared.getLatestImages(type: .small, page: self.currentPage, perPage: perPage) { imgs in
                        self.images = self.images + imgs
                        self.collectionView.reloadData()
                        self.isPageRefreshing = false
                    }
                }
            }
    }
    
    
}
