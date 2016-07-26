//: Playground - noun: a place where people can play

import UIKit


//Khái niệm optional không tồn tại trong C hoặc objective-C. Điều gần nhất trong objective-C là khả năng trả về nil từ một hàm mà kiểu trả về là một object, với giá trị trả về là nil có nghĩa là không tồn tại đối tượng hợp lệ. Tuy nhiên, nó chỉ có đối với object, còn structrures, và các kiểu biến khác thì không. Đối với những kiểu này thì hàm trong objective-C trả về một giá trị đặc biệt (ví dụ như NSNotFound) để thể hiện sự không tồn tại giá trị. Cách tiếp cận này buộc người sử dụng phải biết đến giá trị đặc biệt này để nhớ kiểm tra trường hợp không tồn tại giá trị. Swift cho phép chỉ ra trạng thái không có giá trị ở tất cả các kiểu biến mà không cần đến một giá trị đặc biệt. Khái niệm này chính là optional.

///Khái niệm optional khiến cho việc khai báo và sử dụng biến trở nên rất rõ ràng.
//Đối với kiểu khai báo biến bình thường (không phải kiểu optional) thì biến đó chắc chắn là sẽ luôn có giá trị, tức là chúng ta sẽ không phải lo lắng kiểm tra biến đó = nil hay không trước khi sử dụng. (Trong objective C thì bắt buộc bạn phải nhớ những biến nào sẽ có đặc điểm này.)

//Còn với biến thuộc kiểu optional khiến cho việc kiểm tra trạng thái không tồn tại giá trị của biến trở nên dễ dàng và tự động tức là lập viên sẽ không lo mình đã bỏ qua việc kiểm tra này. Có lẽ vì vậy mà swift được gọi là ngôn ngữ lập trình an toàn.
//Bản chất của việc sử dụng biến thuộc kiểu optional là khi khai báo một biến thuộc kiểu ontional thì bạn bắt buộc phải unwrap ( Forced Unwrapping, Optional Chaining, Optional Binding, Implicitly Unwrapped Optional Type ) nó trước khi bạn có thể lấy được giá trị. Việc unwrap trước khi lấy được giá trị bạn cần sẽ khiến bạn phải suy xét đến trường hợp biến không có giá trị và tất nhiên bạn sẽ ít bỏ sót lỗi không có giá trị hơn.

///Khi nào thì sử dụng biến optional

//Bạn chỉ nên sử dụng với biến mà từ khi nó được khai báo đến khi kết thúc có tồn tại trạng thái không có giá trị. (nil) Tất nhiên bạn hoàn toàn có thể sử dụng optional ở bất kỳ nới nào bạn muốn nhưng điều này là không nên vì nó sẽ khiến bạn phải unwrap ở những nơi hoàn toàn không cần thiết và cũng làm mất đi ý nghĩa của việc optional.


///Khai báo một biến thuộc kiểu optional
// Optional<Kiểu dữ liệu> hoặc kiểu dữ liệu?
/// Khi khai báo một biến thuộc kiểu optional thì mặc định nó có giá trị là nil.
//var a: NSString?
//print(a)




///Một biến bình thường khi được khai báo sẽ không có gì, cũng không phải là nil. Tức là xcode sẽ coi đây là một lỗi ngữ nghĩa và không cho biên dịch chương trình.

//var a: NSString
//print(a) //error: variable 'a' used before being initialized


///Chỉ có kiểu optional mới cho phép gán giá trị bằng nil. Không phải kiểu optional thì không có khả năng được gán giá trị bằng nil.

//var c:NSString! = nil

//print(c) //error: unexpectedly found nil while unwrapping an Optional value
// Lỗi runtime phát hiện ra biến bị nil trong khi unwrapping kiểu optional.

/// Lưu ý là kiểu optional khác với kiểu k phải optional
// ví dụ int? != int
//
//var b:Optional<Int> = 1
//var c:NSString? = nil



//var a:Int? = 1
//var b:Int = 2
//
//a = b
//print(a+b)

//var a:CGPoint? = CGPoint(x: 2, y: 3)
//var b:CGPoint = CGPoint(x:2,y: 3)
//b = a
//(b == a)
//(b == a!)
//var c = a - b
//var d = a.x
//
//
//
//print(a.x)



///Wrap và unwrap

//Những biến thuộc kiểu Optional được gọi là đang được wrap.
//Việc lấy biến kiểu T từ Optional<T> được gọi là unwrap.
///Vậy tại sao lại phải unwrap?
//Chúng ta thường unwrap optional để có thể tương tác, sử dụng trực tiếp với dữ liệu bên trong.
///Vậy có những cách nào để unwrap một dữ liệu kiểu optional.
//Có tất cả 4 phương pháp dùng để unwrap một dữ liệu kiểu optional.

///Cách 1: Forced Unwrapping (Cưỡng chế unwrap)
//Với cách này ta sử dụng dấu chấm than sau biến kiểu optional để unwrap nó.
//Với cách này thì ta vẫn hoàn toàn có thể bị lỗi runtime vì biến optional sau khi bị unwrap thì không khác gì dữ liệu bình thường.
//
//var a:CGPoint? = CGPoint(x: 1, y: 2)
//var b:CGPoint = CGPoint(x: 2, y: 3)
//print(a!.x + b.x)
//
//a = nil
//print(a!) //Lỗi runtime phát hiện ra 1 dữ liệu bị nil khi unwrap
//
//
//




///Cách 2: Optional Chaining ()
//Optional Chaining là một quá trình unwrap để gọi tới các thuộc tính, phương thức, kí hiệu của một optional type mà hiện tại có thể là nil. Dữ liệu sau khi optional chaining sẽ luôn là kiểu optional.
//Nếu dữ liệu optional có chứa một thuộc tính, phương thức, hoặc kí hiệu thì việc truy vấn tới thành công. Nếu optional là nil thì thuộc tính, phương thức, kí hiệu trả về sẽ bằng nil.
//Nhiều truy vấn có thể được thực hiện liên tiếp nhau, và toàn bộ chuỗi thất bại nếu bất kỳ liên kết trong chuỗi là nil.

//Bạn có thể chỉ định optional chaining bằng các đặt một dấu hỏi chấm (?) sau giá trị optional mà bạn mong muốn lấy ra dữ liệu bên trong nếu optional đó không nil. Việc này tương tự như đặt một dấu chấm than (!) sau một giá trị optional để bắt buộc unwrapping giá trị của nó. Sự khác biệt chính là optional chaining đó thực thi mềm dẻo hơn khi optional là nil, trong khi bắt buộc unwrapping gây ra một lỗi runtime khi các optional là nil. Kết quả của việc optional chaining luôn luôn là một giá trị optional, thậm chí nếu thuộc tính, phương thức, hoặc subscript bạn đang truy vấn trả về một giá trị non-optional. Bạn có thể sử dụng giá trị trả về optional này để kiểm tra xem các truy vấn optional chaining đã thành công (optional trả về có chứa một giá trị), hoặc không thành công do giá trị nil trong chuỗi (giá trị optional trả về là nil).

//print(a?)//error: '?' must be followed by a call, member lookup, or subscript
//lỗi: '?' phải được theo sau bởi một truy vấn, gọi , hoặc subscript

//var point:CGPoint? = CGPoint(x: 3,y: 4)
//print(point?.x)
//print(point!.x)
//
//point = nil
//print(point?.x)
//print(point!.x)
//




var point: CGPoint! = CGPoint(x: 1, y: 2)

//point = nil

print(point  )


















//Từ đây thì ta thấy được rằng việc Optional Chaining thật sự là linh động hơn khi ta biết được rằng chương trình của chúng ta vẫn muốn chạy tiếp cho dù dữ liệu trả về kia là nil. Có thể nói đến như là khi chúng ta call api từ server có thể dữ liệu trả về sẽ là nil nhưng chương trình sẽ vẫn chạy tiếp mà k bị crash.
//Nếu Forced Unwrapping chúng ta sẽ dễ dàng theo dõi được vị trí sảy ra bug (bug khi mà dữ liệu bị nil)

///Cách 3: Optional Binding
//Biến được gán bằng kiểu Optional mà được khai báo trong biểu thức điều kiện IF hay WHILE thì trở thành kiểu không phải là Optional.
//Nhiều lập trình viên thì coi việc này như hành động kiểm tra dữ liệu bên trong optional có bị nil hay không.

//var point:CGPoint? = CGPoint(x: 3,y: 4)
//point = nil
//if let point = point{
//    print(point.x)
//}
//else{
//    print("point là nill")
//}
//
//let array:[Int?] = [1,2,3,nil,nil,4,5]
//var i = 0
//
//while let value = array[i]{
//    print(value)
//    i = i + 1
//}
//print(i)
//



///Cách 4: Sử dụng kiểu Implicitly Unwrapped Optional
//Nếu sử dụng kiểu Implicitly Unwrapped Optional chứ không phải kiểu Optional（Optional<T>） thì có thể unwrap ngầm. Khi khai báo biến kiểu Implicitly Unwrapped Optional thì sử dụng ! chứ không phải ?.
var text:NSString! = "Lê Đình Phúc đẹp trai nhất thế giới."
// Nhiều người sẽ dễ hiểu nhầm là ? và ! nó ngang nhau, nhưng thật chất là không phải như thế. ? là cách viết tắt của 1 kiểu dữ liệu Optional. Còn ! là một cách thức để unwrap kiểu dữ liệu optional.
// Nếu 1 biến được khai báo như text ở trên thì ta sẽ hiểu là. Đây là biến kiểu optional nhưng mà nó sẽ được unwrap tại mọi nơi. (chả khác vẹo gì kiểu dữ liệu thường)
text = nil
//print(text)

var a: Int! // Kiểu Implicitly Unwrapped Optional
var b: ImplicitlyUnwrappedOptional<Int> // Tương đương với Int!



