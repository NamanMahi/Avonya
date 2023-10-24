//
//  ViewController.swift
//  Avonya
//
//  Created by Rajshree Jaiswal on 23/10/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var mandelbrotImageView: SDAnimatedImageView?
    @IBOutlet weak var slider: UISlider?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mandelbrotImage = SDAnimatedImage(named: "Mandelbrot_sequence_new.gif")
        mandelbrotImageView?.image = mandelbrotImage
        
        scrollView?.maximumZoomScale = 5
        scrollView?.minimumZoomScale = 1
        scrollView?.delegate = self
        
    }
    
    
    @IBAction func sliderChange() {
        scrollView?.setZoomScale(CGFloat(slider?.value ?? 1), animated: true)

    }


}

extension ViewController: UIScrollViewDelegate {
   
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mandelbrotImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = mandelbrotImageView?.image {
                let ratioW = (mandelbrotImageView?.frame.size.width ?? 0) / image.size.width
                let ratioH = (mandelbrotImageView?.frame.size.height ?? 0) / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth * scrollView.zoomScale > mandelbrotImageView?.frame.size.width ?? 0
                let left = 0.5 * (conditionLeft ? newWidth - (mandelbrotImageView?.frame.size.width ?? 0) : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight * scrollView.zoomScale > mandelbrotImageView?.frame.size.height ?? 0
                
                let top = 0.5 * (conditioTop ? newHeight - (mandelbrotImageView?.frame.size.height ?? 0) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
