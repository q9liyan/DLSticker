//
//  DLLabelView.swift
//  DLLetteringLabel
//
//  Created by mac1012 on 2017/7/28.
//  Copyright © 2017年 DianlE. All rights reserved.
//

import UIKit

class DLLabelView: UIView {

    fileprivate var textView: UITextView?
    fileprivate var texOrginSize: CGFloat?
    fileprivate var borderLayer: CAShapeLayer?
    fileprivate var superView:UIView?
    
    fileprivate var beginPoint:CGPoint?
    fileprivate var beginCenter:CGPoint?
    fileprivate var touchPoint:CGPoint?
    init(frame: CGRect , superView:UIView) {
        super.init(frame: frame)
        self.superView = superView
        self.setupView()
        self.setupBorder()
        self.setupGestureRecognizer()
    }
    
    func setupView(){
        let textView = UITextView(frame: self.bounds)
        textView.textColor = UIColor.black
        
        self.bringSubview(toFront: textView)
        textView.text = "123456789"
        textView.delegate = self
        textView.isScrollEnabled = false
        texOrginSize = textView.sizeThatFits(self.bounds.size).height
        self.addSubview(textView)
        self.textView = textView
        
        
        let cancelTap = UITapGestureRecognizer(target: self, action: #selector(cancelGestureRecognizer(tapGesture:)))
        let cancelImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        cancelImg.image = UIImage(named: "贴纸－关闭")
        cancelImg.addGestureRecognizer(cancelTap)
        cancelImg.center = CGPoint(x: 0, y: 0)
        self.addSubview(cancelImg)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureRecognizer(rotateGesture:)))
        let rotateImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        rotateImage.image = UIImage(named: "贴纸－旋转")
        rotateImage.addGestureRecognizer(rotateGesture)
        rotateImage.center = CGPoint(x: self.frame.width, y: 0)
        self.addSubview(rotateImage)
        
        let moveGesture = UIPanGestureRecognizer(target: self, action: #selector(strtchGestureRecognizer(strtchGesture:)))
        let stretchImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        stretchImg.image = UIImage(named: "贴纸－镜像")
        stretchImg.addGestureRecognizer(moveGesture)
        stretchImg.center = CGPoint(x: self.frame.width, y: self.frame.height)
        self.addSubview(stretchImg)
    }
    
    func setupBorder(){
        borderLayer = CAShapeLayer()
        borderLayer?.fillColor = nil
        borderLayer?.strokeColor = UIColor.black.cgColor
        borderLayer?.lineDashPattern = [NSNumber.init(value: 3),NSNumber.init(value: 5)]
        self.textView?.layer.addSublayer(borderLayer!)
    }
    
    
    
    
    override func layoutSubviews() {
        borderLayer?.path = UIBezierPath.init(rect: (textView?.bounds)!).cgPath
        borderLayer?.frame = (textView?.frame)!
    }
    
    
    func setupGestureRecognizer(){
        let moveGesture = UIPanGestureRecognizer(target: self, action: #selector(moveGestureRecognizer(penGesture:)))
        self.addGestureRecognizer(moveGesture)
    }
    
    func strtchGestureRecognizer(strtchGesture:UIGestureRecognizer) {
        
    }
    
    func rotateGestureRecognizer(rotateGesture:UIGestureRecognizer){
        
    }
    
    func cancelGestureRecognizer(tapGesture:UIGestureRecognizer){
        
    }
    
    func moveGestureRecognizer(penGesture:UIGestureRecognizer){
        touchPoint = penGesture.location(in: superView)
        
        switch penGesture.state {
            case .began:
                beginPoint = touchPoint
                beginCenter = self.center
                self.center = self.estimatedCenter()
                break
            case .cancelled:
                self.center = self.estimatedCenter()
                break
            case .changed:
                self.center = self.estimatedCenter()
                break
            case .ended:
                self.center = self.estimatedCenter()
                break
            default:
                break
        }
    }
  
    func estimatedCenter() -> CGPoint{
        let centerX = (beginCenter?.x)! + ((touchPoint?.x)! - (beginPoint?.x)!)
        let centerY = (beginCenter?.y)! + ((touchPoint?.y)! - (beginPoint?.y)!)
        var center = CGPoint(x: centerX, y: centerY)
        
        if !(center.x + self.frame.width * 0.5 < (superView?.frame.width)! && center.x - self.frame.width * 0.5 > 0){
            center.x = self.center.x
        }
        if !(center.y + self.frame.height * 0.5 < (superView?.frame.height)! && center.y - self.frame.height * 0.5 > 0) {
            center.y = self.center.y
        }
        
        return center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DLLabelView:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let size = textView.sizeThatFits(self.bounds.size)
        if size.height  > (self.frame.height) {
            return false
        }
        return true
    }
  
}
