//
//  FABButtonWithText.swift
//  TableViewWithFAB
//
//  Created by Takasur Azeem on 7/26/21.
//

import UIKit

class FABButtonWithText: UIButton {
   
    var fabState: ButtonStates? = .normal
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        if imageView != nil {
//            if fabState == .expanded {
//                titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 90), bottom: 5, right: 5)
//            } else {
//                titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            }
//        }
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.size.width ?? 0) - (titleLabel?.frame.size.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
        imageView?.contentMode = .scaleAspectFit
    }
    
    
    func setImage(_ image: UIImage?, for state: UIControl.State, fabState: ButtonStates? = nil) {
        super.setImage(image, for: state)
        self.fabState = fabState
    }

}
