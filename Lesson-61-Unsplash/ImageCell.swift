//
//  ImageCell.swift
//  Lesson-61-Unsplash
//
//  Created by Mustafo Asqarov on 19/03/2022.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .systemGray5
    }
    
    
    func updateCell(imgURL: URL) {
        
        self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.large
        self.imgView.sd_setImage(with: imgURL)
        
    }

}
