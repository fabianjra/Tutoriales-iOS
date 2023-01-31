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
        //setupViews()
        setupViews_StackView()
        
        //self.view.backgroundColor = .black
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Playback"
    }
    
    /*
     #1:
     
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
    
    //*******************************************************************************************//
    
    //35. Solution: Stack View Challenge.
    
    /*
     #2:
     
     Challenge: See if you can embed all these controls in a StackView like this.
 
     ┌────────StackView─────────┐
     │                          │
     │        offlineRow        │
     │                          │
     │      offlineSublabel     │
     │                          │   axis = vertical
     │       crossfadeView      │   distribution = fill
     │                          │   alignment = fill
     │        gaplessRow        │   spacing = 20
     │                          │
     │       hideSongsRow       │
     │                          │
     │     normalizationRow     │
     │                          │
     └──────────────────────────┘
     
     Things of note:
  
     1. No bottom constraint on StackView required.
  
         Because the StackView is fully intrinsically sized, we don't need a button constraint pinning it to the bottom.
         We could add one if we wanted it to fully stretch. But if we want it to retain it's size non is required.
  
     2. Notice the how many fewer constraints are required.
  
         Our original layout for this back in the anchors design challenge required around 30 constraints.
         With the StackView, and all of it's built in spacing we now require ~12. Considerably fewer.
     */
     
    func setupViews_StackView() {
        
        let marginSV: CGFloat = 16.0
        
        //Create controls:
        let stackView = makeStackView(withOrientation: .vertical)
        stackView.spacing = 20 //Override spacing from the function "makeStackView".
        
        let descriptionText = "When you go offline, you'll only be able to play the music and podcasts you've downloaded."
        
        //Rows:
        let rowOffline = RowView(textLabel: "Offline", isSwitchOn: false)
        let descriptionOffline = makeSubLabel(withText: descriptionText)
        let crossfadeView = CrossfadeView()
        let rowGapless = RowView(textLabel: "Gapless playback", isSwitchOn: true)
        let rowHideUnplayable = RowView(textLabel: "Hide unplayable songs", isSwitchOn: true)
        let rowEnableAudio = RowView(textLabel: "Enalbe audio normalization", isSwitchOn: true)
        
        //Add to view:
        stackView.addArrangedSubview(rowOffline)
        stackView.addArrangedSubview(descriptionOffline)
        stackView.addArrangedSubview(crossfadeView)
        stackView.addArrangedSubview(rowGapless)
        stackView.addArrangedSubview(rowHideUnplayable)
        stackView.addArrangedSubview(rowEnableAudio)
        
        //Add subviews:
        view.addSubview(stackView)
        
        //Layout:
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //If we add this, will add extra empty space between Rows:
        //stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // for padding and spacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: marginSV, leading: marginSV, bottom: marginSV, trailing: marginSV)
    }
}
