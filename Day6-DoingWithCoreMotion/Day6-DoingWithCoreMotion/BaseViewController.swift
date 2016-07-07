    //
//  BaseViewController.swift
//  Day6-DoingWithCoreMotion
//
//  Created by Le Phuc on 7/7/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class BaseViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var lbMagenticHeaing: UILabel!

    @IBOutlet weak var lbGoc: UILabel!
    @IBOutlet weak var lbAccelaration: UILabel!
    @IBOutlet weak var lbTrueHeading: UILabel!
    
    
    // Cảm biến từ trường.
    let locationManager: CLLocationManager = CLLocationManager()
    
    
    // Con quay hồi chuyển.
    let manager = CMMotionManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMAccelerometerData?, error: NSError?) in
                if let acceleration = data?.acceleration {
                    self!.lbAccelaration.text = "X = \(acceleration.x)\n Y = \(acceleration.y)\n Z = \(acceleration.z)"
                    
                    // Trả về giá trị là góc tính bằng radian giữa trục Ox và vector OA với A có tọa độ là A(x,y)
                    let a = atan2(acceleration.x, acceleration.y)
                    self!.lbGoc.text = "\(a/M_PI * 180)"
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        print(newHeading.magneticHeading)
        
//    magneticHeading: Giá trị của hướng hiện tại. Lấy hướng Bắc là 0 chia trên đường tròn 360 độ.
        
        lbMagenticHeaing.text = "\(newHeading.magneticHeading)"
        lbTrueHeading.text = "\(newHeading.trueHeading)"
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
