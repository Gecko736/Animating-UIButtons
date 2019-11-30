/**
 Ani.swift
 Class contains a static function Ani.mate(_:style:) that will animate a button when called.
 
 Created by Ben Rovik on 5/7/19.
 Copyright © 2019 Ben Rovik. All rights reserved.
*/

import UIKit

class Ani {
    
    private static let fill: CABasicAnimation = {
        let fill = CABasicAnimation(keyPath: "transform.scale")
        fill.duration = 0.1
        fill.repeatCount = 1
        fill.autoreverses = true
        fill.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        fill.fromValue = 1 // % size of button at beginning of animation
        fill.toValue = 0.75 // % size of button at end of animation
        return fill
    }()
    private static let shake: CABasicAnimation = {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 3
        shake.autoreverses = true
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return shake
    }()
    private static let flash: CABasicAnimation = {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.repeatCount = 1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        flash.fromValue = 1 // opacity at beggining of aniamtion
        flash.toValue = 0.1 // opacity at end of animation
        return flash
    }()
    private static let curtain: CALayer = {
        // this is the layer that turns white and fades out to produce the flash effect
        let curtain = CALayer()
        curtain.backgroundColor = UIColor.white.cgColor
        return curtain
    }()
    
    public enum Style {
        case fill
        case shake
        case flash
    }
    
    static func mate(_ sender: UIControl, style: Style) {
        switch style {
        case Style.fill:
            sender.layer.add(fill, forKey: nil)
            
        case Style.shake:
            shake.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 5, y: button.center.y)) // left-most postition in the animation
            shake.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 5, y: button.center.y)) // right-most position in the animation
            sender.layer.add(shake, forKey: nil)
            
        default:
            curtain.frame = sender.frame // make the curtain the same size at the button
            curtain.frame.origin = CGPoint(x: 0, y: 0) // set the curtain's origin to 0, because it's placed relative to the button's origin
            
            sender.layer.addSublayer(curtain)
            curtain.add(flash, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + flash.duration - 0.05) {
                curtain.removeFromSuperlayer()
            }
        }
    }
}
