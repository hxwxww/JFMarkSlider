//
//  ViewController.swift
//  JFMarkSliderExample
//
//  Created by HongXiangWen on 2020/9/8.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit
import JFMarkSlider
 
class ViewController: UIViewController {

    @IBOutlet weak var slider1: MarkSlider!
    @IBOutlet weak var slider2: MarkSlider!
    @IBOutlet weak var slider3: MarkSlider!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        slider1.minimumTrackTintColor = .red
        slider1.minimumMarkTintColor = .red
        slider1.markValues = [0.2, 0.4, 0.6, 0.8]
        slider1.addTarget(self, action: #selector(slider1DidChange), for: .valueChanged)
        slider1.addTarget(self, action: #selector(slider1DidEndDrag), for: .touchUpInside)
        slider1.addTarget(self, action: #selector(slider1DidEndDrag), for: .touchUpOutside)
        label1.text = "\(slider1.value)"

        slider2.minimumTrackTintColor = .black
        slider2.minimumMarkTintColor = .black
        slider2.isStayToMark = false
        slider2.markStyle = .image(image: UIImage(named: "bullet")!.withRenderingMode(.alwaysTemplate))
        slider2.markValues = [0.2, 0.4, 0.6, 0.8]
        slider2.addTarget(self, action: #selector(slider2DidChange), for: .valueChanged)
        slider2.addTarget(self, action: #selector(slider2DidEndDrag), for: .touchUpInside)
        slider2.addTarget(self, action: #selector(slider2DidEndDrag), for: .touchUpOutside)
        label2.text = "\(slider2.value)"

        slider3.maximumTrackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        slider3.minimumTrackTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        slider3.maximumMarkTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        slider3.minimumMarkTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        slider3.setThumbImage(UIImage(named: "slider"), for: .normal)
        slider3.minimumValue = 100
        slider3.maximumValue = 700
        slider3.markValues = [200, 300, 400, 500, 600]
        slider3.value = 200
        slider3.addTarget(self, action: #selector(slider3DidChange), for: .valueChanged)
        slider3.addTarget(self, action: #selector(slider3DidEndDrag), for: .touchUpInside)
        slider3.addTarget(self, action: #selector(slider3DidEndDrag), for: .touchUpOutside)
        label3.text = "\(slider3.value)"
    }

    @objc func slider1DidChange() {
        print("slider1DidChange: \(slider1.value)")
        label1.text = "\(slider1.value)"
    }
    
    @objc func slider1DidEndDrag() {
        print("slider1DidEndDrag: \(slider1.value)")
    }
    
    @objc func slider2DidChange() {
        print("slider2DidChange: \(slider2.value)")
        label2.text = "\(slider2.value)"
    }
    
    @objc func slider2DidEndDrag() {
        print("slider2DidEndDrag: \(slider2.value)")
    }
    
    @objc func slider3DidChange() {
        print("slider3DidChange: \(slider3.value)")
        label3.text = "\(slider3.value)"
    }
    
    @objc func slider3DidEndDrag() {
        print("slider3DidEndDrag: \(slider3.value)")
    }
}

