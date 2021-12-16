//
//  PostItemTableViewCell.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import UIKit

class PostItemTableViewCell: UITableViewCell {
    
    static let identifier = "PostItemTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostItemTableViewCell", bundle: nil)
    }
    
    @IBOutlet private weak var usernameLabel: UILabel?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var bodyLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(post: PostModel) {
        titleLabel?.text = post.title ?? ""
        bodyLabel?.text = post.body ?? ""
        usernameLabel?.text = post.user?.username ?? ""
    }

}
