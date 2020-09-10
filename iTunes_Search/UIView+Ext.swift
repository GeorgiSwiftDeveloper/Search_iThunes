//
//  UIView+Ext.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 9/9/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    func pinWebView(to superView: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalToSystemSpacingBelow: superView.topAnchor, multiplier: 5).isActive = true
        rightAnchor.constraint(equalToSystemSpacingAfter: superView.rightAnchor, multiplier: 0).isActive  = true
        leftAnchor.constraint(equalToSystemSpacingAfter: superView.leftAnchor, multiplier: 0).isActive = true
        heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    func pinTopMusicLabel(to superView: UIView, playerButton: UIButton) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalToSystemSpacingBelow: superview!.topAnchor, multiplier: 1.5).isActive = true
        leadingAnchor.constraint(equalToSystemSpacingAfter: superview!.leadingAnchor, multiplier: 2).isActive = true
        trailingAnchor.constraint(lessThanOrEqualTo: playerButton.leadingAnchor, constant: -30).isActive = true
        
    }
    
    
    func pinMiddleMusicLabel(superView: UIView, webView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalToSystemSpacingBelow: webView.bottomAnchor, multiplier: 5).isActive = true
        leftAnchor.constraint(equalTo: superview!.leftAnchor, constant: 10).isActive = true
        rightAnchor.constraint(equalTo: superview!.rightAnchor, constant: -10).isActive = true
        centerXAnchor.constraint(equalToSystemSpacingAfter: superview!.centerXAnchor, multiplier: 0).isActive = true
        
    }
    
    
    func pinPlayerButton(to superView: UIView,middle ifMiddle :Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        if ifMiddle == false {
            topAnchor.constraint(equalToSystemSpacingBelow: superview!.topAnchor, multiplier: 1).isActive = true
            rightAnchor.constraint(equalTo: superview!.rightAnchor, constant: -10).isActive = true
            widthAnchor.constraint(equalToConstant: 30).isActive = true
            heightAnchor.constraint(equalToConstant: 30).isActive = true
        }else{
            centerXAnchor.constraint(equalToSystemSpacingAfter: superview!.centerXAnchor, multiplier: 0).isActive = true
            centerYAnchor.constraint(lessThanOrEqualTo: superview!.centerYAnchor, constant: 120).isActive = true
        }
    }
    
    
    func pinLeftAndRightButtons(to middlePlayerButtonView: UIButton, ifLeft left: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        if left == true  {
            centerYAnchor.constraint(lessThanOrEqualTo: middlePlayerButtonView.centerYAnchor, constant: 0).isActive = true
            trailingAnchor.constraint(lessThanOrEqualTo: middlePlayerButtonView.leadingAnchor, constant: -50).isActive = true
        }else{
            centerYAnchor.constraint(lessThanOrEqualTo: middlePlayerButtonView.centerYAnchor, constant: 0).isActive = true
            leadingAnchor.constraint(lessThanOrEqualTo: middlePlayerButtonView.trailingAnchor, constant: 50).isActive = true
        }
    }
    
    
    
    func pinMusicVolumeSlider(to superView: UIView, to middleButton: UIButton) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalToSystemSpacingAfter: superview!.centerXAnchor, multiplier: 0).isActive = true
        topAnchor.constraint(lessThanOrEqualTo: middleButton.bottomAnchor, constant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 250).isActive = true
        heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    func pinVolMaxAndVolMin(to volumSliderView: UIView, ifMax max: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        if max == true  {
            centerYAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: volumSliderView.centerYAnchor, multiplier: 0).isActive = true
            leadingAnchor.constraint(lessThanOrEqualTo: volumSliderView.trailingAnchor, constant: 30).isActive = true
        }else{
            centerYAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: volumSliderView.centerYAnchor, multiplier: 0).isActive = true
            trailingAnchor.constraint(lessThanOrEqualTo: volumSliderView.leadingAnchor, constant: -30).isActive = true
        }
    }
    
}
