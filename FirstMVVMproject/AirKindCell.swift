//
//  AirKindCell.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/08/17.
//  Copyright © 2020 김동준. All rights reserved.
//

import UIKit
import SnapKit
class AirKindCell: UITableViewCell {
    
    private let cellView = UIView()
    private let nameLabel = UILabel()
    private let emotionIcon = UIImage()
    private let stateLabel = UILabel()
    private let valLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(cellView)
        cellView.backgroundColor = .black
        cellView.snp.makeConstraints { (make) in
            make.width.equalTo(121 * self.contentView.frame.width / 121)
            make.height.equalTo(180)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func setNameLabelText(name: String){
        self.nameLabel.text = name
    }

}
