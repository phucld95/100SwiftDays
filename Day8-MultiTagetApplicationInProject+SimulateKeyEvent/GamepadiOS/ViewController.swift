//
//  ViewController.swift
//  GamepadiOS
//
//  Created by Le Phuc on 7/11/16.
//
//

import UIKit
import CoreLocation
import CoreMotion


class ViewController: UIViewController,CLLocationManagerDelegate {


    //MARK:- Property
    @IBOutlet weak var btnAKeysrtocks: UIButton!
    @IBOutlet weak var btnSendMouse: UIButton!
    @IBOutlet weak var btnHoleOnButton: UIButton!
    private let multipeerClient = MultipeerClient()

    
    private var oldAngle: CGFloat?
    private var oldMagneticHeading: CGFloat?
    
    // Cảm biến từ trường.
    let locationManager: CLLocationManager = CLLocationManager()
    
    
    // Con quay hồi chuyển + cảm biến trọng lực.
    let manager = CMMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAKeysrtocks.addTarget(self, action: #selector(self.btnAKeysrtocksTouchUpInside), forControlEvents: .TouchUpInside)
//        btnSendMouse.addTarget(self, action: #selector(self.btnSendMouseTouchUpInside), forControlEvents: .TouchUpInside)
        
        
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
        
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.1
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMAccelerometerData?, error: NSError?) in
                if let acceleration = data?.acceleration {
                    //self!.lbAccelaration.text = "X = \(acceleration.x)\n Y = \(acceleration.y)\n Z = \(acceleration.z)"
                    
                    // Trả về giá trị là góc tính bằng radian giữa trục Ox và vector OA với A có tọa độ là A(x,y)
                    let a = atan2(acceleration.x, acceleration.y)
                    var b = CGFloat(a/M_PI * 180)
//                    print("Lệch 1 góc so với Oz: ",b)
                    if let oldAngle = self!.oldAngle {
                        b = b - oldAngle
                        if b > 180 {
                            b = b - 180
                        }
                        else if b < -180 {
                            b = b + 180
                        }
                        b = b / 10
                        self!.sendMouse(width: b, height: b)
                        self!.oldAngle = CGFloat(a/M_PI * 180)
                    }
                        
                    else{
                        self!.oldAngle = b
                    }
                }
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        var a = CGFloat(newHeading.magneticHeading)
        
        if let oldMagneticHeading = oldMagneticHeading {
            a = a - oldMagneticHeading
            if a > 180 {
                a = a - 360
            }
            else if a < -180 {
                a = a + 360
            }
            self.sendMouse(width: a, height: 0)
//            print("Gửi đi width: \(a)")
            self.oldMagneticHeading = CGFloat(newHeading.magneticHeading)
        }
        
        else{
            oldMagneticHeading = CGFloat(newHeading.magneticHeading)
        }
        
        //    magneticHeading: Giá trị của hướng hiện tại. Lấy hướng Bắc là 0 chia trên đường tròn 360 độ.
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: Send
    func send(dataSend: NSMutableDictionary) {
        guard let session = multipeerClient.session else { return }
        do {
            let data = NSKeyedArchiver.archivedDataWithRootObject(dataSend)
            try session.sendData(data, toPeers: session.connectedPeers, withMode: .Reliable)
        } catch {}
    }
    
    func sendString(string: NSString?) {
        let dicSend = NSMutableDictionary()
        dicSend.setValue("press", forKey: "command")
        dicSend.setValue(string, forKey: "key")
        self.send(dicSend)
    }
    
    
    // MARK:- Action
    func btnAKeysrtocksTouchUpInside() {
        self.sendString("a")
    }
    func sendMouse(width a: CGFloat, height b:CGFloat) {
//        if a == 0 {
            print("\(a) | \(b)")

//        }
        let dicSend = NSMutableDictionary()
        dicSend.setValue("moveMouse", forKey: "command")
        dicSend.setValue(a, forKey: "width")
        dicSend.setValue(b, forKey: "height")
        self.send(dicSend)
    }
}

