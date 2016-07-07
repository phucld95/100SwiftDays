//
//  CAAnimationVC.swift
//  Day1-ActionAndAnimation
//
//  Created by Le Phuc on 5/27/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import UIKit

/**
 * Keyframe animations là một công cụ rất mạnh cho lập trình viên bởi vì bạn có thể set rất nhiều dữ liệu đồng thời chỉ định hiệu ứng giữa các khoảng thời gian. Nó bao gồm 3 thành phần: "a key path": thuộc tính của chuyển động, "array value": list dữ liệu bạn muốn sử dụng cho thuộc tính này (Mỗi giai đoạn sẽ ứng với 1 giá trị trong list), "array keytime": khi nào thì sẽ sử dụng những thuộc tính này. (hay được hiểu như khoảng thời gian chuyển tiếp giữa các giá trị trong array value ở trên.)
 
 keyPath có thể tra cứu trên apple doc, nhưng cũng không đầy đủ.
 1 số keyPath hay được sử dụng:
 position.x: đi theo phương x
 position.y: đi theo phương y
 
 
 duration: Animation sẽ được thực hiện trong khoảng thời gian bao nhiêu.
 addAnimation: copy animation cho view với key là "abc"
 key ở đây giống như là 1 định danh của animation. key này thì có thể tự do lựa chọn. Key này sẽ được sử dụng trong các trường hợp cần truy cập lại animation này. Cụ thể như delete.
 chú ý là khi thực hiện việc gán thì chỉ là copy lại animation này cho view. tức là ta có thể tái sử dụng lại biến animation ở trên hoặc gán cho nhiều view khác nhau mà không sợ bị ảnh hưởng.
 
 
 keyTimes: chương trình sẽ dịch theo công thức: Thời gian thực hiện animation = giá trị/ tổng giá trị của mảng * duration. Lập trình viên thường để keyTimes là một dạng tỉ lệ phân số để dễ tưởng tượng: Ví dụ: [0,(1/6),(3/6),(2/6)]
 
 
 
 let animation = CAKeyframeAnimation()
 animation.keyPath = "position.y"
 animation.values = [0, 300, 0]
 animation.keyTimes = [0, 0.5, 1]
 animation.duration = 2
 animation.additive = true
 animation.repeatCount = HUGE_VALF // Lặp lại vĩnh viễn.
 animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay) // Thời gian bắt đầu thực hiện animation.
 
 view.layer.addAnimation(animation, forKey: "move")
 
 
 */

// timingFunction đây là là một kiểu set chuyển động cho animation để nó có cảm giác có gia tốc: EaseIn, EaseOut, EaseInEaseOut,

/**
 * Animaton Group: Nhóm các animation lại với nhau.
 */

// Cam thảo thêm tại đây https://www.objc.io/issues/12-animations/animations-explained/


class CAAnimationVC: UIViewController {

    @IBOutlet weak var lbWecome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let transformAnim            = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values         = [
            NSValue(CATransform3D: CATransform3DMakeRotation(60 * CGFloat(M_PI/180), 0, 0, -1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(60 * CGFloat(M_PI/180), 0, 0, 1))),
            NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1.9), CATransform3DMakeRotation(-8 * CGFloat(M_PI/180), 0, 0, 1)))]
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        transformAnim.duration       = 3
        self.lbWecome.layer.addAnimation(transformAnim, forKey: "transform")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
