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
let bottomScaleHeight:CGFloat = 7.0
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
        carousel.type = iCarouselType.Cylinder
        carousel.pagingEnabled = false
        carousel.scrollSpeed = 0.5
        
        self.traingleLabel.font = UIFont.fontAwesomeOfSize(50)
        self.traingleLabel.text = String.fontAwesomeIconWithName(FontAwesome.CaretUp)
        self.traingleLabel.textColor = UIColor.grayColor()
        
        
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int
    {
        return items.count
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView!
    {
        var label: UILabel! = nil
        var newView = view
        //create new view if no view is available for recycling
        
            newView = UIView()
            newView.frame = CGRectMake(0, 0, viewWidth, viewHeight)
            newView.backgroundColor = UIColor.whiteColor()
            
            var subview:UIView = UIView()
            if index % 5 == 0 {
                subview.frame = CGRectMake((viewWidth - scalewidth) * 0.5, viewHeight - bottomScaleHeight - bottomScaleMargin - bigscaleHeight, scalewidth, bigscaleHeight)
                label = UILabel(frame:CGRectMake((viewWidth - labelWidth) * 0.5, viewHeight - bigscaleHeight - bottomScaleMargin - bottomScaleHeight - labelHeight - labelMargin, labelWidth, labelHeight))
                label.backgroundColor = UIColor.clearColor()
                label.textAlignment = .Center
                
                label.font = label.font.fontWithSize(12)
                label.text = "\(index)"
                newView.addSubview(label)
            }
            else {
                subview.frame = CGRectMake((viewWidth - scalewidth) * 0.5, viewHeight - bottomScaleHeight - bottomScaleMargin - bigscaleHeight * 0.5, scalewidth, bigscaleHeight * 0.5)
            }
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: subview.bounds, byRoundingCorners: .TopLeft | .TopRight, cornerRadii: CGSize(width: 10.0, height: 10.0)).CGPath
            subview.layer.mask = maskLayer
            subview.backgroundColor = UIColor(red: 88.0/255.0, green: 194.0/255.0, blue: 56.0/255.0, alpha: 1.0)
            newView .addSubview(subview)
            
            var horizontalView:UIView = UIView(frame: CGRectMake(0, viewHeight - bottomScaleHeight, viewWidth, bottomScaleHeight))
            horizontalView.backgroundColor = UIColor(red: 88.0/255.0, green: 194.0/255.0, blue: 56.0/255.0, alpha: 1.0)
            
            newView .addSubview(horizontalView)
        
        
        return newView
    }
    
    func carousel(carousel: iCarousel!, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return 1
        }
//        else if (option == .Radius) {
//            return 100
//        }
        else if (option == .Arc) {
            return 3
        }
        else if (option == .Wrap)
        {
            return 0
        }
        return value
    }
    
    func carouselItemWidth(carousel: iCarousel!) -> CGFloat {
        return viewWidth
    }
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        label.text = "\(index)"
    }
    
    func carouselDidScroll(carousel: iCarousel!) {
        label.text = "\(carousel.currentItemIndex) seconds"
    }
}

