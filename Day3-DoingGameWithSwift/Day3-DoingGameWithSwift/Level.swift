//
//  Level.swift
//  Day3-DoingGameWithSwift
//
//  Created by Le Phuc on 6/15/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

import Foundation


// Cái này chỉ đơn giản như kiểu define
let NumColumns = 9
let NumRows = 9

class Level {
    private var cookies = Array2D<Cookie>(columns: NumColumns, rows: NumRows)
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)
    
    init(filename: String) {
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename) else { return }
        
        guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
        
        // tilesArray ở đây là mảng một chiều. Hàm enumerate có công dụng trả về 1 bộ giá trị trong array kiểu (index, giá trị)
        
        // Get giá trị từ file
        for (row, rowArray) in tilesArray.enumerate() {
            let tileRow = NumRows - row - 1
            for (column, value) in rowArray.enumerate() {
                if value == 1 {
                    tiles[column, tileRow] = Tile()
                }
            }
        }
    }
    
    
    // assert là một hàm được viết sẵn trong Foundation. Hàm này trả về true nếu điều kiện bên trong là đúng và chương trình sẽ tiếp tục được chạy, trả về false nếu điều kiện là sai và chương trình ngay lập tức sẽ dừng lại trả lại quyền cho hệ điều hành.
    func tileAtColumn(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return tiles[column, row]
    }
    
    func cookieAtColumn(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return cookies[column, row]
    }
    
    func shuffle() -> Set<Cookie> {
        return createInitialCookies()
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        // Set là một kiểu collection (tập hợp) chứa dữ liệu: Khác với array, set không quan tâm đến thứ tự dữ liệu (không có index, không có key) Nhưng set sẽ đảm bảo rằng trong tập hợp dữ liệu không bao giờ có 2 đối tượng trùng nhau.
        
        var set = Set<Cookie>()
        
        
        // 1
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if tiles[column, row] != nil {
                    let cookieType = CookieType.random()
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    
                    // 4
                    set.insert(cookie)
                }
                
            }
        }
        return set
    }
}

/** Mối quan hệ giữa Scene và ViewControler trong lập trình.
 *In many Sprite Kit games, the “scene” is the main object for the game. In Cookie Crunch, however, you’ll make the view controller play that role.
 Why? The game will include UIKit elements, such as labels, and it makes sense for the view controller to manage them. You’ll still have a scene object—GameScene from the template—but this will only be responsible for drawing the sprites; it won’t handle any of the game logic.
 * Đối với việc làm game bằng sprite kit "scene" là đối tượng chính của game. Tuy nhiên trong game này thì view controller sẽ có chức năng như vậy. Tại sao ư? Game sẽ thêm vào các thành phần thuộc UIKIT như là label, và thằng viewController sẽ trực tiếp quản lý những cái này. Bạn sẽ giữ một đối tượng là scene (GameScene) nhưng đối tượng này sẽ chỉ chịu trách nhiệm là vẽ lên các sprite. Nó sẽ không chứa bất kì một logic game nào. (Trong mô hình MVC thì scene chỉ tương ứng với phần V)
 * Mở rộng hơn nữa chúng ta sẽ có: GameScene, SKSpriteNode, SKCropNode, SKLabelNode đề thuộc phần View.
 * Những phần như Level, Cookie, ... thuộc phần M (model).
 * Và phần GameViewController là phần C (Controller) Điều khiển việc hiển thị.
 *
 *
 */





