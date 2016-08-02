//: Playground - noun: a place where people can play

import UIKit

//MARK:- Test Optional and Implicitly unwrapping optional.
/**
 Sự khác biệt giữa chấm than và chấm hỏi
 
 
 Optional (?)
    1.Trong khai báo biến, “?” có nghĩa là ta nói rằng biến đó có khả năng bị nil chứ không phải lúc nào cũng có giá trị (hoặc con trỏ gán vào). Ví dụ nếu UIViewController chạy độc lập thì biến navigationController của nó sẽ là nil.
    2.Trong câu lệnh thông thường, dấu “?” xuất hiện báo hiệu rằng nếu biến đó đang là nil thì toàn bộ những gì sau “?” sẽ không được thực thi, app sẽ không crash.
    3.“?” hoạt động như 1 màng mana shield (lá chắn phép trong game :D) bảo vệ cái biến đó. Vì thế sẽ có khái niệm wrapping và unwrapping mà khi tới “!” ta sẽ hiểu hơn.
 
Optional<Wrapped> được hiểu như là một cơ ché bảo vệ là một lớp bên ngoài tồn tại 2 trạng thái hoặc là "Đây là một thuộc tính có kiểu dữ liệu x (không nil)" hoặc là "Đây không phải là một thuộc tính nào cả (nil)"
 Khi một biến được khai báo thuộc kiểu Optinal, trước khi sử dụng biến này (truy cập đến địa chỉ, yêu cầu lấy dữ liệu) thì chương trình mặc định phải chạy qua 1 lệnh kiểm tra biến đấy có nil hay không.
Có 2 cách để khai báo 1 biến thuộc Optional Type là:
 var optionalInteger: Int?
 var optionalInteger: Optional<Int>
 
 

 
Implicitly unwrapped optional type (­!)­

 Về cơ bản ta dùng “!” khi cực kỳ chắc chắn rằng biến có “!” sẽ luôn luôn có giá trị. Biến có “!” trên thực tế ta có thể hiểu nó là biến optional nhưng luôn được unwrap (không được bảo vệ). Tức là nếu để ! thì chương trình sẽ tự hiểu là biến luôn có dữ liệu và bỏ qua bước kiểm tra mỗi khi truy xuất dữ liệu. Việc này sẽ giúp cho chương trình có hiệu năng cao hơn.

 
 **/

struct hument {
    let name: String
    let old: Int
}

var phuc:hument? = hument(name: "Le Phuc", old: 21)

phuc = nil

if phuc?.name == "Le Phuc"{
    print("Nếu không khai báo kiểu optional thì khi chạy tới đây chương trình sẽ bị crash bởi vì ta đã yêu cầu lấy dữ liệu từ 1 biến nil")
}

print("Bằng chứng là đã vượt qua if mà không bị crash.")

//var saoly:hument = hument(name: "Sao Ly", old: 20)
//
//saoly = phuc!
//
//if saoly.name == "Sao Ly"{
//    print("Chạy tới đây là chắc chắn sẽ bị crash do ta đã khai báo mặc định bỏ qua bước wraping")
//}
//
//print("Bằng chứng là không vượt qua.")

//var saoly:hument! = hument(name: "Sao Ly", old: 20)
//
//saoly = nil
//
//if saoly!.name == "Sao Ly"{
//    print("Chạy tới đây là chắc chắn sẽ bị crash do ta đã khai báo mặc định bỏ qua bước wraping")
//}
//
//print("Bằng chứng là không vượt qua.")


func testWithFunc(name: String) -> hument? {
    var phuc:hument? = hument(name: name, old: 21)
    phuc = nil
    return phuc
}

//let phuc2:hument = testWithFunc("Phuc")
// Ở đây sẽ bị báo lỗi bởi vì mặc định khi khao báo biến mà không sử dụng Optional thì sẽ không được phép gán biến = nil
// Thế nếu ta thêm dấu chấm cảm vào sao lời gọi hàm thì sao? (Cố ý nói vs nó là hàm này sẽ luôn trả về khác nil)
//let phuc2:hument = testWithFunc("Phuc")!
// Sẽ sảy ra lỗi run time! Đơn giản vì cháu nó bị nil.
// Thế nếu ta thêm dấu chấm hỏi cho kiểm tra trước khi gán thì sao? Vì trong trường hợp này thực sự nó sẽ trả về nil.
//let phuc2:hument = (testWithFunc("Phuc"))?
// Swift sẽ không cho phép điều này bởi vì nó đã lường trước được trường hợp có thể bị nil. Nên sẽ quy cái này vào sai cú pháp. Nó sẽ gợi ý ta thêm chấm than vào cuối nhưng sẽ vẫn bị lỗi run time như ở ví dụ ngay phía trên bởi vì dù có thêm dấu hỏi chấm vào thì vẫn không thay đổi được phép gán ở phía trước.
// Thế nếu ta thêm dấu chấm than sau biến thì sao? (Nói cho nó là biến này sẽ không bao h bị nil.)

//let phuc2:hument! = testWithFunc("Phuc")
// Tất nhiên là sẽ vượt qua ở bước gán nhưng sẽ gặp phải lỗi run time ngay khi chúng ta truy xuất biến ở dưới.

let phuc2:hument! = testWithFunc("Phuc")
// Và đương nhiên khi chúng ta cho wrapping ở dưới khi truy xuất đến biến chương trình sẽ chạy qua ngon lành.
// Từ ví dụ trên thì ta có thể thấy được rằng. Khai báo ở biến là chấm cảm hay hỏi chấm đều không quan trọng. quan trọng là khi chúng ta truy xuất đến dữ liệu chúng ta sẽ sử dụng dấu nào. Tôi khuyến khích nên chọn wrapping để tăng tính an toàn cho chương trình. (tuy có chậm hơn unwrapping 1 chút)

print("Vượt qua: \(phuc2?.name)")

//MARK:- Test function


// Khi để dấu hỏi chấm trong biến đầu vào như dưới đây thì có ý nghĩa gì?
// Tại sao khi để biến thứ nhất là ! thì chương trình lại bị crash?
// Đơn giản vì khi để ! thì chương trình đã mặc định khác nil và bỏ qua bước wrapping nên dẫn tới bị crash khi truy xuất dữ liệu.
// Để ý nếu ta để dấu hỏi chấm sau giá trị trả về thì biến trả về là Optional(3) chứ k phải là 3 nữa. Khá là thú vị. :D

func findMax(first: Int?, second: Int?) -> Int? {
    if let n1 = first {
        return n1 > second ? n1 : second
    }else{
        return second
    }
}

print("Kết quả: \(findMax(nil, second: 3))")

// Test trường hợp tham số đầu vào là không biết trước số lượng giá trị.

func findMaxInList(list: Int?...) -> Int? {
    var max = list[0]
    for numb in list {
        print("Max = \(max), numb = \(numb)")
        if numb > max {
            print("so sánh")
            max = numb
        }
    }
    return max
}

print("Kết quả: \(findMaxInList(nil,nil,-1000000000000,4,5,6))")

// Qua trường hợp này chúng ta thấy được là swift nó rất là khôn. trường hợp có wrapping thấy bị nil là nó nhảy qua luôn việc truy xuất. Nó coi nil là 1 giá trị cực cực nhỏ. Không tin có thể thay dấu lớn hơn bằng dấu nhỏ hơn. Chúng ta sẽ có 1 kết quả là nil.

// Test một vài trường hợp mở rộng hay ho.
// Khi chúng ta muốn cho một đoạn text gợi nhớ để lời gọi hàm giống 1 câu văn hơn.
func findMax2(Between first: Int?, and second: Int?) -> Int? {
    if let n1 = first {
        return n1 > second ? n1 : second
    }else{
        return second
    }
}

findMax2(Between: 12, and: 13)


// Khi chúng ta chẳng muốn nó gợi nhớ cái quái gì giống C cùi.
//func minWillToWill(first: Int?, _ second: Int?) {
//    if first < second {
//        first = second
//    }
//    else{
//        second = first
//    }
//}
// thông qua ví dụ trên ta thấy rằng swift giống như java tức là khi chúng ta truyền param vào thì thực chất là swift đã copy lại giá trị param đó và mặc định là let (hằng số)
// Thế nếu chúng ta muốn truyền vào con trỏ để tương tác thì cần làm như thế nào?
// Hãy sử dụng từ khóa inout để truyền trực tiếp địa chỉ của tham số vào trong hàm.
func minWillToWill(inout first: Int, inout _ second: Int) {
    if first < second {
        first = second
    }
    else{
        second = first
    }
}

var numb1 = 4
var numb2 = 5

minWillToWill(&numb1, &numb2)
print("Numb1: \(numb1) and Numb2: \(numb2)")





/**
 Khái niệm về tuple. Tuple là phần trả về của 1 hàm trong swift. Đây là giải pháp của swift sử dụng để trả về nhiều kết quả 1 lúc. Khi chúng ta sử dụng Tuple sẽ tương ứng với việc chúng ta tạo 1 struct và dữ liệu trả về sẽ thuộc kiểu struct đó.
 **/
func maxMin(list : Int?...) -> (max:Int?, min:Int?) {
    var max = list[0]
    var min = list[0]
    
    for numb in list{
        if numb > max {
            max = numb
        }
        if numb < min {
            min = numb
        }
    }
    return (max, min)
}

let result = maxMin(nil,nil,1,2,3,4,nil,5,6,7)
print("Max = \(result.max) và Min = \(result.1)")
// Ở đây có 1 cái rất hay đó là ta có thể truy cập dữ liêu trong tuple thông qua việc chỉ ra cụ thể thứ tự của biến trả về trong tuple.
// Ở đây ta thấy giá trị min trả về bằng nil đơn giản bởi vì swift coi nil là giá trị vô cùng bé.



/**
 Khái niệm nested funtion.
 Một funtion có thể được viết trong 1 funtion khác. Kĩ thuật này hay được sử dụng để làm ngắn lại những hàm dài.
 nested function có khả năng sử dụng các biến của func chứa nó. (Kiểu như lúc này func chứa sẽ là chương trình chính, nested func sẽ là 1 hàm của chương trình này.)
 **/
func testNestedFunc() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    if y < 50 {
        add()
    }
    if y == 50 {
        add()
    }
    add()
    return y
}
testNestedFunc()

/**
 Trong swift func cũng được coi như là 1 kiểu biến. Vì thế chúng ta có thể sử dụng func như 1 hàm đầu vào hoặc là tham số trả về. (khá là giống block nhỉ) :D
 **/

func perform(param1 a:Float?, param2 b:Float?, function c:(Float,Float)->Float) -> Float {
    return c(a!,b!)
}

func plus(a: Float, b: Float) -> Float {
    return a+b
}







perform(param1: 14, param2: 15, function: plus)

func howToDoThat() -> ((Float, Float) -> Float) {
    func subtract(a: Float, b: Float) -> Float {
        return a+b
    }
    return plus
//    return subtract
}

print("Đáp án là: \(howToDoThat)")
// Thậm chí chúng ta còn có thể gán nó như 1 biến bình thường.
let funtion:(Float, Float)->Float = howToDoThat()

/**
 Closures:
 Closures giống như là block trong objective-C
 Function là một trường hợp đặc biệt của closures
 Closures có thể sử dụng được tất cả các hằng số và biến được khai báo trong phạm vi chứa closures. Không những có thể sử dụng clusures còn có thể tham chiếu tới cũng như thay đổi nội dung từ trong thân hàm của mình.
 Để tối ưu hóa, thay vì copy và sử dụng một dữ liệu kiểu mutable
 Cú pháp dùng để khai báo 1 closues:
 { (parameters) -> return type in
 statements
 }
 **/


let closures = ({ (a:Int, b:Int)->Int in
    return a+b
})

print("Closures = \(closures(1,2))")

// Closures rất linh động trong cách khai báo. Chúng ta còn có thể khai báo trực tiếp như sau.

let closues2:((Int, Int)->(Int)) = {
    $1
}

// Clusures làm việc với kiểu tham chiếu. tức là các biến được tạo với kiểu closues sẽ có dạng tham chiếu. khi ta làm the

var a = 10
a = a + 1
var b = a

b = 12
print("\(a)")


// Ở đây chúng ta đã gán sum2 là 1 kiểu closures.
var sum2 = ({()->Int in
    var num = 10
    func plus(a:Int) -> Int {
        return a+2
    }
    return plus(num)
    
})

sum2()
sum2()


print("Test địa chỉ")
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    print("\(runningTotal)")
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30

var inc = incrementByTen
inc()
incrementByTen()

// qua đây chúng ta thấy được bản chất biến closues là một kiểu con trỏ (biến lưu lại địa chỉ của vùng nhớ thực hiện chức năng được định nghĩa trong closues). ví dụ như ở trên thì vùng nhớ này có bao gồm cả vùng nhớ chứa biến runningTotal. Vậy nên khi gọi tới biến incrementByTen nó vẫn có runningTotal để cộng mà không cần truyền vào. Quả là rất thú vị. :D


/**
 Nonescaping Closures:
 Đây là cách để swift chắc chắn rằng closures của bạn sẽ được thực hiện đến khi kết thúc mà không bị bất kì một yếu tố nào khiến nó bị ngắt (cái này khó hiểu vc) một trong số các yêu tố có thể khiến closues dừng giữa chừng đó là kĩ thuật asynchronous.
 Để thực hiện điều này chỉ cần thêm từ khóa @noescape trước closues cần sử dụng.
 **/

// Ví dụ như sau:

func someFunctionWithNonescapingClosure(@noescape closure: () -> Void) {
    closure()
}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

/**
    Lazy stored properties: Một thuộc tính được khai báo như là chưa có giá trị khi được khai báo nhưng sẽ được khởi tạo tại lần sử dụng đầu tiên. Sử dụng lazy stored properties khi mà dữ liệu khởi tạo của 1 thuộc tính là không thể biết trước trước khi mà đối tượng được khởi tạo hoặc sử dụng khi thuộc tính cần phải tính toán cụ thể cho mỗi trường hợp.
    Cho một ví dụ như sau: Nếu ta có một lớp Person và một personalizedGreeting properties (lời chào cá nhân) thì properties này có thể là một lazily instant sau khi đối tượng được khởi tạo có thể chứa tên của người đó.
 **/

class Person {
    
    var name: String
    
    lazy var personalizedGreeting: String = {
        [unowned self] in
        return "Hello, \(self.name)!"
        }()
    
    init(name: String) {
        self.name = name
    }
}

let person = Person(name: "Lê Phúc")
print(person.personalizedGreeting)


/// Ở đây chúng ta được làm quen với method class và propeties class trong swift    .
class student: NSObject {
    lazy var name: String = student.initStudent()
    class func initStudent() -> String {
        return "LePhuc"
    }
}


/**
 setter and getter
 Một kiểu dữ liệu tính toán thì không được lưu một cách trực tiếp trong vùng nhớ. Thay vào đó, swift sử dụng từ khóa "get","set" để sử lý kết quả.
 được áp dụng cho mỗi thuộc tính. Thuộc tính trong swift thì được chia thành 2 loại đó là: Thuộc tính lưu trữ (Stored properties) lưu các gí trị hằng số và biến số như là một phần của một instance, và thuộc tính tính toán (computed properties) tính toán một giá trị chứ không phải là lưu giá trị. Thuộc tính tính toán được cung cấp bởi các lớp, cấu trúc và kiểu dữ liệu liệt kê. thuộc tính lưu trữ được cung cấp chỉ bởi các lớp và cấu trúc.
 Setter và getter được áp dụng cho những biến mà chúng ta muốn 2 che giấu, hạn chế truy cập trực tiếp vào biến.
 
 get: Sẽ được gọi tới khi mà thuộc tính được truy cập. Việc người dùng sẽ nhận được gì sẽ là do chúng ta quy định viết trong phương thức này.
 set: Sẽ lưu lại một dữ liệu (dữ liệu đầu vào này sẽ luôn là newValue). 
 newValue: đây là một từ khóa đặc biệt. (tên của một biến) chỉ được sử dụng trong phương thức set của một thuộc tính toán.
 
    Chốt hạ lại: Kiểu setter và getter thực chất là 2 phương thức. 2 phương thức này sẽ được viết chung vào 1 closures. và có 1 biến được gán cho cái closures này.
    
 
 Cách thức khai báo:
    var tên_biến: Kiểu_dữ_liệu{
        get{
        return dữ_liệu (phải dùng Kiểu_dữ_liệu)
        }
        set{
        thực hiện gán dữ liệu, thực hiện các công việc mong muốn.
        }
 }
 **/
class inhumant {
    var nameH: NSString
    
    var name:NSString {
        get{
            return "D.\(self.nameH)"
        }
        set{
            nameH = newValue
        }
    }
    init(){
        self.nameH = ""
    }
}

let data = inhumant()
data.name = "Le Phuc"
print(data.name)



struct AlternativeRect {
    
    var origin = CGPoint()
    
    var size = CGSize()
    
    var center: CGPoint {
        
        get {
            
            let centerX = origin.x + (size.width / 2)
            
            let centerY = origin.y + (size.height / 2)
            
            return CGPoint(x: centerX, y: centerY)
            
        }
        
        set {
            
            origin.x = newValue.x - (size.width / 2)
            
            origin.y = newValue.y - (size.height / 2)
            
        }
        
    }
    
}
