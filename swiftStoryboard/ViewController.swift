//
//  ViewController.swift
//  swiftStoryboard
//
//  Created by Carolina Castro on 2024-11-16.
//
import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case RING
        case CROSS
    }
    
    @IBOutlet weak var turn: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var playField = [[0,0,0],[0,0,0],[0,0,0]]
    var currentPlayer = Turn.CROSS
    
    let ring = "O"
    let cross = "X"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turn.text = cross
    }
    
    @IBAction func cellTapAction(_ sender: UIButton) {
        let tag = sender.tag
        let row = tag / 3
        let column = tag % 3
        
        if playField[row][column] == 0 {
            if currentPlayer == Turn.RING {
                sender.setTitle(ring, for: .normal)
                playField[row][column] = 2
                currentPlayer = Turn.CROSS
                turn.text = cross
            } else if currentPlayer == Turn.CROSS {
                sender.setTitle(cross, for: .normal)
                playField[row][column] = 1
                currentPlayer = Turn.RING
                turn.text = ring
            }
            checkForWinOrDraw()
        } else {
            print("Cell already taken")
        }
    }
    
    func checkForWinOrDraw() {
        let winningCombinations = [
            // Rows
            [(0, 0), (0, 1), (0, 2)],
            [(1, 0), (1, 1), (1, 2)],
            [(2, 0), (2, 1), (2, 2)],
            // Columns
            [(0, 0), (1, 0), (2, 0)],
            [(0, 1), (1, 1), (2, 1)],
            [(0, 2), (1, 2), (2, 2)],
            // Diagonals
            [(0, 0), (1, 1), (2, 2)],
            [(0, 2), (1, 1), (2, 0)],
        ]
        
        for combination in winningCombinations {
            let (aRow, aColumn) = combination[0]
            let (bRow, bColumn) = combination[1]
            let (cRow, cColumn) = combination[2]
            
            if playField[aRow][aColumn] != 0 &&
                playField[aRow][aColumn] == playField[bRow][bColumn] &&
                playField[aRow][aColumn] == playField[cRow][cColumn] {
                
                let winner = playField[aRow][aColumn] == 1 ? cross : ring
                showAlert(title: "\(winner) Wins!", message: "Congratulations!")
                return
            }
        }
        
        if !playField.flatMap({ $0 }).contains(0) {
            showAlert(title: "It's a Draw!", message: "Play again!")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame()
        }))
        present(alert, animated: true)
    }
    
    func resetGame() {
       
        playField = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
        
       
        currentPlayer = Turn.CROSS
        turn.text = cross
        

        let buttons = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
        for button in buttons {
            button?.setTitle(nil, for: .normal)
        }
    }
}


