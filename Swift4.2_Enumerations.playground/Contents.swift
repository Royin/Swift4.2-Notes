//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
// https://www.cnswift.org/enumerations

// ***************** 枚举 *****************//


// = =  枚举  = = //

/*
 枚举为一组相关值定义了一个通用类型，从而可以让你在代码中类型安全地操作这些值。
 Swift 中的枚举则更加灵活，并且不需给枚举中的每一个成员都提供值。如果一个值（所谓“原始”值）要被提供给每一个枚举成员，那么这个值可以是字符串、字符、任意的整数值，或者是浮点类型。
 */



// - - 枚举语法

enum SomeEnumeration {
    // 枚举定义
}

enum CompassPoint {
    // 指南针四个方向枚举
    case north
    case south
    case east
    case west
}

/*
 注意
 不像 C 和 Objective-C 那样，Swift 的枚举成员在被创建时不会分配一个默认的整数值。在上文的 CompassPoint例子中， north， south， east和 west并不代表 0， 1， 2和 3。而相反，不同的枚举成员在它们自己的权限中都是完全合格的值，并且是一个在 CompassPoint中被显式定义的类型。
 */

enum Planet {
    // 多个成员值可以在同一行，用逗号隔开
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/*
 每个枚举都定义了一个全新的类型。正如 Swift 中其它的类型那样，它们的名称（例如： CompassPoint和 Planet）需要首字母大写。
 */

var directionToHead = CompassPoint.west
directionToHead = .east // directionToHead类型在初始化时已被推断



// - - 使用Switch 语句来匹配枚举值

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out ofr penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
} // swich判断一个枚举要全覆盖，或者提供一个default

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}



// - - 遍历枚举情况 (case)

/*
 可以通过在枚举名字后面写:CaseIterable 来允许枚举被遍历.
 Swift 会暴露一个包含对应枚举类型所有情况的集合名为 allCases
 */

enum Beverage: CaseIterable { // 4.2 新增特性
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}



// - - 关联值

enum Barcode {
    case upc(Int, Int, Int, Int) // 关联类型元组 (条形码)
    case qrCode(String) // 关联了一个字符串       (二维码)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// 关联值可以提取作常量或变量
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

// 枚举成员相关值都被提取成常量或变量，用一个let或var
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}



// - - 原始值

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/*
 注意
 原始值与关联值不同。原始值是当你第一次定义枚举的时候，它们用来预先填充的值，正如上面的三个 ASCII 码。特定枚举成员的原始值是始终相同的。关联值在你基于枚举成员的其中之一创建新的常量或变量时设定，并且在你每次这么做的时候这些关联值可以是不同的。
 */



// - - 隐式指定的原始值

/*
整数或字符串原始值枚举，Swift会自动分配一个枚举值
*/

// 整数枚举递增加1，如果没有指定，第一个成员值是0
enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// 字符串隐式制定的原始值是成员本身名称
enum CompassPoint2: String {
    case north, south, east, west
}

let earthsOrder = Planet2.earth.rawValue

let sunsetDirection = CompassPoint2.west.rawValue



// - - 从原始值初始化

let possiblePlanet = Planet2(rawValue: 7) // 使用原始值初始化了一个枚举

let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    // 得到了一个可选项，并没有位置11的行星
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}



// - - 递归枚举

/*
 枚举在对序号考虑固定数量可能性的数据建模时表现良好，比如用来做简单整数运算的运算符。
 这些运算符允许你组合简单的整数数学运算表达式比如5到更复杂的比如5+4.
 
 数学表达式的一大特征就是它们可以内嵌。比如说表达式(5 + 4) * 2 在乘法右手侧有一个数但其他表达式在乘法的左手侧。因为数据被内嵌了，用来储存数据的枚举同样需要支持内嵌——这意味着枚举需要被递归。
 
 递归枚举是拥有另一个枚举作为枚举成员关联值的枚举。当编译器操作递归枚举时必须插入间接寻址层。你可以在声明枚举成员之前使用 indirect关键字来明确它是递归的。
 */

enum ArithmeticExpression1 {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression) // 内嵌枚举 indirect
}

// 或者在枚举之前 写 indirect 让整个枚举成员在需要时可以递归
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
// 该枚举可存储三种数学运算表达式：单一数字，加法，乘法

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// 运算递归
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}




