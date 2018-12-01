//
//  main.swift
//  test
//
//  Created by Dave DeLong on 12/18/17.
//  Copyright © 2017 Dave DeLong. All rights reserved.
//

extension Year2017 {

class Day19: Day {
    
    init() { super.init() }
    
    func isValid(_ pos: Position) -> Bool {
        guard pos.y >= 0 && pos.y < rawInputLineCharacters.count else { return false }
        let row = rawInputLineCharacters[pos.y]
        return pos.x >= 0 && pos.x < row.count
    }
    
    func character(at pos: Position) -> Character? {
        guard isValid(pos) else { return nil }
        return rawInputLineCharacters[pos.y][pos.x]
    }
    
    func isPathy(_ pos: Position) -> Bool {
        return character(at: pos) != nil && character(at: pos) != " "
    }
    
    func isPath(_ pos: Position) -> Bool {
        return character(at: pos) == "+" || character(at: pos) == "|" || character(at: pos) == "-"
    }
    
    func nextHeading(from pos: Position, current heading: Heading) -> Heading {
        guard isPath(pos) else { return heading }
        // only + can change your heading
        guard character(at: pos) == "+" else { return heading }
        
        if heading == .north || heading == .south {
            // we're pointing up/down; we can go L/R
            if isPathy(pos.move(.west)) { return .west }
            if isPathy(pos.move(.east)) { return .east }
        } else if heading == .west || heading == .east {
            // we're pointing L/R; we can go up/down
            if isPathy(pos.move(.north)) { return .north }
            if isPathy(pos.move(.south)) { return .south }
        }
        return heading
    }
    
    override func run() -> (String, String) {
        let startX = rawInputLineCharacters[0].index(of: "|")!

        var position = Position(x: startX, y: 0)
        var heading = Heading.south

        var seen = Array<Character>()
        var steps = 0
        while isValid(position) && isPathy(position) {
            steps += 1
            if isPath(position) {
                heading = nextHeading(from: position, current: heading)
            } else {
                seen.append(character(at: position)!)
            }
            position = position.move(heading)
        }

        return ("\(seen.reduce("") { $0 + String($1) })", "\(steps)")
    }

}

}
