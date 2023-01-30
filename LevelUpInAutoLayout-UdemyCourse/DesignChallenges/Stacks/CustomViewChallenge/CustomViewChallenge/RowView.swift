//
//  RowView.swift
//  CustomViewChallenge
//
//  Created by Fabian Josue Rodriguez Alvarez on 29/1/23.
//  Copyright © 2023 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class RowView: UIView {
    
    private let textLabel: String
    private let isSwitchOn: Bool
    
    init (textLabel: String, isSwitchOn: Bool) {
        self.textLabel = textLabel
        self.isSwitchOn = isSwitchOn
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Note how all controls are layed out completely flush with edges of view.
     Not a hard and fast rule, but generally good to follow as it clarifies that it is the parent
     who will be responsible for outside layout and spacing.
     */
    func setupView() {
        let titleLabel = makeLabel(withText: textLabel)
        let rightSwitch = makeSwitch(isOn: true)
        
        addSubview(titleLabel)
        addSubview(rightSwitch)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        rightSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        rightSwitch.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    //The row size
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 31)
    }
}
