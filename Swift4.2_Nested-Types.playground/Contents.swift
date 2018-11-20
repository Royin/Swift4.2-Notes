import UIKit

var str = "Hello, playground"


// https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html
// https://www.cnswift.org/nested-types


// ************* 内嵌类型 Nested-Types ************** //

/*
 枚举通常用于实现特定类或结构体的功能。类似的，它也可以在更加复杂的类型环境中方便的定义通用类和结构体。为实现这种功能，Swift 允许你定义内嵌类型，借此在支持类型的定义中嵌套枚举、类、或结构体。
 */


// 二十一点游戏扑克牌
struct BlackjackCard {
    
    // 花色
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // Ace 代表 一或十一
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case.Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if  let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
    
}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("TheAceOfSpades: \(theAceOfSpades.description)")



// 引用内嵌类型

/*
 要在定义外部使用内嵌类型，只需在其前缀加上内嵌了它的类的类型名即可：
 */

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
