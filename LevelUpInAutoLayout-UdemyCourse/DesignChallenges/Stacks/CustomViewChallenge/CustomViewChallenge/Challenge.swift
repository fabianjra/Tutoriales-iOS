//
//  Challenge.swift
//  CustomViewChallenge
//
//  Created by Jonathan Rasmusson Work Pro on 2019-10-17.
//  Copyright © 2019 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class Challenge: UIViewController {
    
    let margin: CGFloat = 20
    let spacing: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        
        //self.view.backgroundColor = .black
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Playback"
    }
    
    /*
     
     Challenge here is to take the various controls and practice extracting components as subViews (UIViews).
     
     Two good candidates for extraction are the:
     
     - RowView (label and a switch)
     - CrossfadeView (label, progressbar, and max min label)
     
     ┌───────────────┐        ┌───────────────┐
     │               │        │               │
     │               ├────────▶    RowView    │ x4
     │               │        │               │
     │               │        └───────────────┘
     │   Challenge   │ extract
     │               │
     │               │        ┌───────────────┐
     │               │        │               │
     │               ├────────▶ CrossfadeView │ x1
     │               │        │               │
     └───────────────┘        └───────────────┘
     
     See if you can extract those into their own custom UIViews and then lay those out.
     
     */
    
    func setupViews() {
        
        let descriptionText = "When you go offline, you'll only be able to play the music and podcasts you've downloaded."
        
        //Rows:
        let rowOffline = RowView(textLabel: "Offline", isSwitchOn: false)
        let descriptionOffline = makeSubLabel(withText: descriptionText)
        let crossfadeView = CrossfadeView()
        let rowGapless = RowView(textLabel: "Gapless playback", isSwitchOn: true)
        let rowHideUnplayable = RowView(textLabel: "Hide unplayable songs", isSwitchOn: true)
        let rowEnableAudio = RowView(textLabel: "Enalbe audio normalization", isSwitchOn: true)
        
        //Add to view:
        view.addSubview(rowOffline)
        view.addSubview(descriptionOffline)
        view.addSubview(crossfadeView)
        view.addSubview(rowGapless)
        view.addSubview(rowHideUnplayable)
        view.addSubview(rowEnableAudio)
        
        //Constraints:
        descriptionOffline.translatesAutoresizingMaskIntoConstraints = false
        crossfadeView.translatesAutoresizingMaskIntoConstraints = false
        
        //Layout:
        layoutRow(rowView: rowOffline, top: view.safeAreaLayoutGuide.topAnchor, view: view)
        
        descriptionOffline.topAnchor.constraint(equalTo: rowOffline.bottomAnchor, constant: margin).isActive = true
        descriptionOffline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        descriptionOffline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        crossfadeView.topAnchor.constraint(equalTo: descriptionOffline.bottomAnchor, constant: margin).isActive = true
        crossfadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        crossfadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        layoutRow(rowView: rowGapless, top: crossfadeView.bottomAnchor, view: view)
        layoutRow(rowView: rowHideUnplayable, top: rowGapless.bottomAnchor, view: view)
        layoutRow(rowView: rowEnableAudio, top: rowHideUnplayable.bottomAnchor, view: view)
    }
    
    //Generic way to set the layout constraints for Rows.
    func layoutRow(rowView: RowView, top: NSLayoutYAxisAnchor, view: UIView) {
        
        //Befure adjust the layout, we need to set "translatesAutoresizingMaskIntoConstraints" in false.
        rowView.translatesAutoresizingMaskIntoConstraints = false
        
        rowView.topAnchor.constraint(equalTo: top, constant: margin).isActive = true
        rowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        rowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
    }
    
}
