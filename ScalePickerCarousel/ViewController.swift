//
//  ViewController.swift
//  ScalePickerCarousel
//
//  Created by Amit kumar Swami on 07/07/15.
//  Copyright (c) 2015 Aks. All rights reserved.
//

import UIKit
import FontAwesome_swift

let viewHeight:CGFloat = 100.0
let viewWidth:CGFloat = 20.0
let bigscaleHeight:CGFloat = 50.0
let scalewidth:CGFloat = 3.0
let bottomScaleHeight:CGFloat = 0.0
let bottomScaleMargin:CGFloat = 5.0
let labelHeight:CGFloat = 10.0
let labelMargin:CGFloat = 5.0
let labelWidth:CGFloat = 30.0

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate
{
    var items: [Int] = []
    @IBOutlet var carousel : iCarousel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var traingleLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        for i in 0...999
        {
            items.append(i)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = iCarouselType.linear
        carousel.isPagingEnabled = false
        carousel.scrollSpeed = 0.5
        
        self.traingleLabel.font = UIFont.fontAwesome(ofSize: 50)
        self.traingleLabel.text = String.fontAwesomeIcon(name: FontAwesome.caretUp)
        self.traingleLabel.textColor = UIColor.gray
        
        
    }
    
    func numberOfItems(in carousel: iCarousel!) -> Int
    {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel!, viewForItemAt index: Int, reusing view: UIView!) -> UIView!
    {
        var label: UILabel! = nil
        var newView = view
        //create new view if no view is available for recycling
        
            newView = UIView()
            newView?.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            newView?.backgroundColor = UIColor.clear
            
            var subview:UIView = UIView()
            if index % 5 == 0 {
                subview.frame = CGRect(x: (viewWidth - scalewidth) * 0.5, y: viewHeight - bottomScaleHeight - bottomScaleMargin - bigscaleHeight, width: scalewidth, height: bigscaleHeight)
                label = UILabel(frame:CGRect(x: (viewWidth - labelWidth) * 0.5, y: viewHeight - bigscaleHeight - bottomScaleMargin - bottomScaleHeight - labelHeight - labelMargin, width: labelWidth, height: labelHeight))
                label.backgroundColor = UIColor.clear
                label.textAlignment = .center
                
                label.font = label.font.withSize(12)
                label.text = "\(index)"
                newView?.addSubview(label)
            }
            else {
                subview.frame = CGRect(x: (viewWidth - scalewidth) * 0.5, y: viewHeight - bottomScaleHeight - bottomScaleMargin - bigscaleHeight * 0.5, width: scalewidth, height: bigscaleHeight * 0.5)
            }
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: subview.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
            subview.layer.mask = maskLayer
            subview.backgroundColor = UIColor(red: 88.0/255.0, green: 194.0/255.0, blue: 56.0/255.0, alpha: 1.0)
            newView? .addSubview(subview)
            
//            var horizontalView:UIView = UIView(frame: CGRectMake(0, viewHeight - bottomScaleHeight, viewWidth, bottomScaleHeight))
//            horizontalView.backgroundColor = UIColor(red: 88.0/255.0, green: 194.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        
            //newView .addSubview(horizontalView)
        
        
        return newView
    }
    
    func carousel(_ carousel: iCarousel!, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .spacing)
        {
            return 1
        }
//        else if (option == .Radius) {
//            return 100
//        }
        else if (option == .arc) {
            return 3
        }
        else if (option == .wrap)
        {
            return 0
        }
//        else if (option == iCarouselOption.VisibleItems)
//        {
//            return 30
//        }
        return value
    }
    
    func carouselItemWidth(_ carousel: iCarousel!) -> CGFloat {
        return viewWidth
    }
    
    func carousel(_ carousel: iCarousel!, didSelectItemAt index: Int) {
        label.text = "\(index)"
    }
    
    func carouselDidScroll(_ carousel: iCarousel!) {
        label.text = "\(carousel.currentItemIndex) seconds"
    }
}

