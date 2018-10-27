//
//  MyMenuScreenCell.swift
//  Project
//
//  Created by Pakaporn on 9/25/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MyMenuScreenCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    weak var post: Post?
    
    func set(post: Post) {
        self.post = post
        
        self.profileImageView.image = nil
        ImageService.getImage(withURL: post.author.photoURL) { image, url in
            guard let _post = self.post else { return }
            if _post.author.photoURL.absoluteString == url.absoluteString {
                self.profileImageView.image = image
            } else {
                print("Not the right image")
            }
            
        }
        
        usernameLabel.text = post.author.username
        postTextLabel.text = post.text
        subtitleLabel.text = post.createdAt.calenderTimeSinceNow()
    }
    
}
