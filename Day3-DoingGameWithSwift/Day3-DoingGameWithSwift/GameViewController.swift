//
//  GameViewController.swift
//  Day3-DoingGameWithSwift
//
//  Created by Le Phuc on 6/15/16.
//  Copyright (c) 2016 Lê Phúc. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var level: Level!
    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()

        let vieStart = view as! SKView
        vieStart.multipleTouchEnabled = false
        vieStart.showsFPS = true
        vieStart.showsNodeCount = true
        vieStart.ignoresSiblingOrder = true
        scene = GameScene(size: vieStart.bounds.size)
        scene.scaleMode = .AspectFill

        level = Level(filename: "Level_1")
        scene.level = level
        scene.addTiles()

        vieStart.presentScene(scene)
        beginGame()

    }
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        let newCookies = level.shuffle()

        scene.addSpritesForCookies(newCookies)
    }
}
