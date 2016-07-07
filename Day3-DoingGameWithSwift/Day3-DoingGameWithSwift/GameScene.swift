//
//  GameScene.swift
//  Day3-DoingGameWithSwift
//
//  Created by Le Phuc on 6/15/16.
//  Copyright (c) 2016 Lê Phúc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let tilesLayer = SKNode()

    override func didMoveToView(view: SKView) {
        
    }
    
    var level: Level!
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0
    
    let gameLayer = SKNode()
    let cookiesLayer = SKNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Put an image on the background. Because the scene's anchorPoint is
        // (0.5, 0.5), the background image will always be centered on the screen.
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
        
        // Add a new node that is the container for all other layers on the playing
        // field. This gameLayer is also centered in the screen.
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        
        // The tiles layer represents the shape of the level. It contains a sprite
        // node for each square that is filled in.
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        
        // This layer holds the Cookie sprites. The positions of these sprites
        // are relative to the cookiesLayer's bottom-left corner.
        cookiesLayer.position = layerPosition
        gameLayer.addChild(cookiesLayer)
    }
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                // If there is a tile at this position, then create a new tile
                // sprite and add it to the mask layer.
                if level.tileAtColumn(column, row: row) != nil {
                    let tileNode = SKSpriteNode(imageNamed: "Tile")
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointForColumn(column, row: row)
                    tilesLayer.addChild(tileNode)
                }
            }
        }
    }
    
    
    func addSpritesForCookies(cookies: Set<Cookie>) {
        for cookie in cookies {
            // Create a new sprite for the cookie and add it to the cookiesLayer.
            let sprite = SKSpriteNode(imageNamed: cookie.cookieType.spriteName)
            sprite.size = CGSize(width: TileWidth, height: TileHeight)
            sprite.position = pointForColumn(cookie.column, row: cookie.row)
            cookiesLayer.addChild(sprite)
            cookie.sprite = sprite
        }
    }
    
    
    // MARK: Point conversion
    
    // Converts a column,row pair into a CGPoint that is relative to the cookieLayer.
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
}



// Enum là một cách để định nghĩa dữ liệu. Khác với struct chỉ định nghĩa ra cấu trúc của kiểu dữ liệu, enum định nghĩa ra bộ các giá trị thuộc kiểu dữ liệu đó. Như ví dụ ở dưới tức là ta thông báo với chương trình ta định nghĩa 1 kiểu dữ liệu mới là CookieType bao gồm các giá trị là: Unknown, ...
// Bản chất của enum thực ra nó tạo ra 1 list các giá trị, khi ta khai báo 1 biến thuộc list này thì biến đó sẽ chỉ được gán các giá trị nằm trong list mà thôi.
enum CookieType: Int {
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie
    // trong ngoon ngữ swift bạn có thể thêm một hàm hoặc 1 biểu thức tính toán vào trong 1 enum
    
    // Khi khai báo như dưới đây tức là biến spriteName sẽ có dạng String nhận giá trị trả về từ closures.
    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]
        // Vì enum là 1 list nên nó cũng có chỉ số tương ứng với mỗi phần tử. Để lấy được chỉ số này ta dùng biến rowValue. Thực chất biến rowValue sẽ chỉ ra giá trị này được khai báo thứ mấy trong list.
        return spriteNames[rawValue - 1]
    }
    // Trong game này, chúng ta sẽ nối tên của đồ ăn với cụm từ Highlighted để lấy được tên của ảnh đã được làm highlight trong asset.
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    static func random() -> CookieType {
        //arc4random_uniform(n) giá trị trả về sẽ nằm trong khoảng [0,n]
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}


// CustomStringConvertible: Protocol giúp convert chuyển đối tượng sang dạng thông tin muốn in ra màn hình. Ví dụ đối tượng Vecter thì sẽ in ra thành (x,y)
// The Equal to (a == b) function we are writing is a comparison operator and must be declared in the global scope.
// Func == là một loại toán tử nên nó phải được viết bên ngoài với phạm vi là toàn bộ project. (Cái này cần tìm hiểu thêm. Lằng nhằng vc.)
func ==(lhs: Cookie, rhs: Cookie) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}

class Cookie: CustomStringConvertible, Hashable {
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
    
    var hashValue : Int {
        get {
            return row*10 + column
        }
    }
    
    
    
    //Custom String Convertible protocol
    var description: String {
        return "type:\(cookieType) square:(\(column),\(row))"
    }
    
}

/**
 *  Ở đây chúng ta sẽ được làm quen với khái niệm mới: Lập trình tổng quát trong swift <Generic Programming>
 * Lập trình tổng quát nghĩa là với cùng một chức năng, chúng ta có thể tương tác với nhiều loại dữ liệu tùy thuộc vào sự khai báo của người dùng khi sử dụng thì chức năng này mới được cài đặt cụ thể.
 * Lập trình tổng quát có thể được sử dụng trong function, struct, khai báo các kiểu dữ liệu list, closued,
 * Để khai báo lập trình tổng quát chúng ta sử dụng cú pháp <NameType> trong tên của chức năng. Ví dụ như struct dưới đây. NameType lúc này sẽ là một kiểu dữ liệu cụ thể mà người dùng sẽ khai báo cụ thể khi sử dụng struct: ví dụ: let a: Array2D<Int>?
 */


struct Array2D<T> {
    let columns: Int
    let rows: Int
    private var array: Array<T?>
    
    // Phương thức khởi tạo của struct: Đây là kiểu Designated.
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: nil)
    }
    
    /**
     * Subscripts: Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].
     * Class, struct và enum có thể được định nghĩa một kịch bản bên trong, được hiểu như là một cách thức để truy cập vào các thành tử có trong một list dữ liệu. Bạn có thể sử dụng subscripts để set hoặc truy xuất tới các dữ liệu dựa vào chỉ số mà không cần cài đặt thêm các phương thức đặc biệt. Một ví dụ cho việc này đó là truy cập tới dữ liệu trong một mảng hoạc dictionary. array[3] hoặc dict[key]
     * Cú pháp:
     subscript(index: Int) -> T {
        get {
        // return an appropriate subscript value here
        }
        set(newValue) {
        // perform a suitable setting action here
        }
     }
     */
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}



