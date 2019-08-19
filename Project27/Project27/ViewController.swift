//
//  ViewController.swift
//  Project27
//
//  Created by Yury Popov on 19/08/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawTWIN()
    }

    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        case 1:
            drawCircle()
            
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmogi()
        case 7:
            drawTWIN()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                print(rotations)
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            // 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            // 3
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            // 4
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            // 5
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            // 5
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        // 6
        imageView.image = img
    }
    
    func drawEmogi() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let face = CGRect(x: -100, y: -100, width: 200, height: 200).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
            ctx.cgContext.setLineWidth(7)
            ctx.cgContext.addEllipse(in: face)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            let mouth = CGRect(x: -20, y: 25, width: 40, height: 40)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: mouth)
            ctx.cgContext.drawPath(using: .fill)
            
            let leftEye = CGRect(x: -45, y: -35, width: 25, height: 30)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: leftEye)
            ctx.cgContext.drawPath(using: .fill)
            
            let rightEye = CGRect(x: 20, y: -35, width: 25, height: 30)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: rightEye)
            ctx.cgContext.drawPath(using: .fill)
        }
        
        // 6
        imageView.image = img
    }
    
    func drawTWIN() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 0, y: 256)
        
            let cx = ctx.cgContext
            cx.setStrokeColor(UIColor.black.cgColor)
            cx.setLineWidth(1)
            
            // T
            cx.move(to: CGPoint(x: 30, y: 40))
            cx.addLine(to: CGPoint(x: 106, y: 40))
            cx.move(to: CGPoint(x: 70, y: 40))
            cx.addLine(to: CGPoint(x: 70, y: 158))
            
            // W
            cx.move(to: CGPoint(x: 121, y: 40))
            cx.addLine(to: CGPoint(x: 146, y: 158))
            cx.move(to: CGPoint(x: 146, y: 158))
            cx.addLine(to: CGPoint(x: 174, y: 40))
            cx.move(to: CGPoint(x: 174, y: 40))
            cx.addLine(to: CGPoint(x: 199, y: 158))
            cx.move(to: CGPoint(x: 199, y: 158))
            cx.addLine(to: CGPoint(x: 227, y: 40))
            
            // I
            cx.move(to: CGPoint(x: 251, y: 40))
            cx.addLine(to: CGPoint(x: 251, y: 158))
            
            // N
            cx.move(to: CGPoint(x: 286, y: 40))
            cx.addLine(to: CGPoint(x: 286, y: 158))
            cx.move(to: CGPoint(x: 286, y: 40))
            cx.addLine(to: CGPoint(x: 347, y: 158))
            cx.move(to: CGPoint(x: 347, y: 40))
            cx.addLine(to: CGPoint(x: 347, y: 158))
            
            cx.drawPath(using: .fillStroke)
        }
        imageView.image = img
    }
}

