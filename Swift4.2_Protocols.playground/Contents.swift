import UIKit

// https://docs.swift.org/swift-book/LanguageGuide/Protocols.html
// https://www.cnswift.org/protocols


// ************* 协议 Protocols ************** //

/*
 协议为方法、属性、以及其他特定的任务需求或功能定义蓝图。
 协议可被类、结构体、或枚举类型采纳以提供所需功能的具体实现。
 满足了协议中需求的任意类型都叫做遵循了该协议。
 
 除了指定遵循类型必须实现的要求外，你可以扩展一个协议以实现其中的一些需求或实现一个符合类型的可以利用的附加功能。
 */



// - - 协议的语法

/*
 
 protocol SomeProtocol {
     // protocol definition goes here
 }
 
 struct SomeStructure: FirstProtocol, AnotherProtocol {
     // structure definition goes here
 }
 
 class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
     // class definition goes here
 }
 
 */



// - - 属性要求

/*
 协议可以要求所有遵循该协议的类型提供特定名字和类型的实例属性或类型属性。协议并不会具体说明属性是储存型属性还是计算型属性——它只具体要求属性有特定的名称和类型。协议同时要求一个属性必须明确是可读的或可读的和可写的。
 
 若协议要求一个属性为可读和可写的，那么该属性要求不能用常量存储属性或只读计算属性来满足。若协议只要求属性为可读的，那么任何种类的属性都能满足这个要求，而且如果你的代码需要的话，该属性也可以是可写的。
 
 属性要求定义为变量属性，在名称前面使用 var 关键字。可读写的属性使用 { get set } 来写在声明后面来明确，使用 { get } 来明确可读的属性。
 */

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

/*
 在协议中定义类型属性时在前面添加 static 关键字。当类的实现使用 class 或 static 关键字前缀声明类型属性要求时，这个规则仍然适用：
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

// 只有一个实例属性要求
protocol FullyNamed {
    var fullName: String { get }
}


struct Person1: FullyNamed {
    var fullName: String
}
let john = Person1(fullName: "John Appleseed")


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")




// - - 方法要求

/*
 
 协议可以要求采纳的类型实现指定的实例方法和类方法。
 这些方法作为协议定义的一部分，书写方式与正常实例和类方法的方式完全相同，但是不需要大括号和方法的主体。
 允许变量拥有参数，与正常的方法使用同样的规则。
 但在协议的定义中，方法参数不能定义默认值。
 
 正如类型属性要求的那样，当协议中定义类型方法时，你总要在其之前添加 static 关键字。即使在类实现时，类型方法要求使用 class 或 static 作为关键字前缀，前面的规则仍然适用：
 
 protocol SomeProtocol {
     static func someTypeMethod()
 }
 
 

// 下面的例子定义了一个只有一个实例方法要求的协议：

 protocol RandomNumberGenerator {
     func random() -> Double
 }
 
 */

protocol RandomNumberGenerator {
    func random() -> Double
}

// 遵循RandomNumberGenerator协议
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's random number：\(generator.random())")
print("And another random one: \(generator.random())")




// - - 异变方法要求

/*
 
 有时一个方法需要改变（或异变）其所属的实例。例如值类型的实例方法（即结构体或枚举），在方法的 func 关键字之前使用 mutating 关键字，来表示在该方法可以改变其所属的实例，以及该实例的所有属性。这一过程写在了在实例方法中修改值类型中。
 
 若你定义了一个协议的实例方法需求，想要异变任何采用了该协议的类型实例，只需在协议里方法的定义当中使用 mutating 关键字。这允许结构体和枚举类型能采用相应协议并满足方法要求。
 
 注意
 如果你在协议中标记实例方法需求为 mutating ，在为类实现该方法的时候不需要写 mutating 关键字。 mutating 关键字只在结构体和枚举类型中需要书写。
 
 */

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}



// - - 初始化器要求

/*
 
 协议可以要求遵循协议的类型实现指定的初始化器。和一般的初始化器一样，只用将初始化器写在协议的定义当中，只是不用写大括号也就是初始化器的实体：
 
 protocol SomeProtocol {
     init(someParameter: Int)
 }
 
 */



// - - 协议初始化器要求的类实现

/*
 
 你可以通过实现指定初始化器或便捷初始化器来使遵循该协议的类满足协议的初始化器要求。在这两种情况下，你都必须使用 required 关键字修饰初始化器的实现
 
 class SomeClass: SomeProtocol {
     required init(someParameter: Int) {
         // initializer implementation goes here
     }
 }
 
 在遵循协议的类的所有子类中， required 修饰的使用保证了你为协议初始化器要求提供了一个明确的继承实现。
 
 详见必要初始化器。
 
 注意
 由于 final 的类不会有子类，如果协议初始化器实现的类使用了 final 标记，你就不需要使用 required 来修饰了。因为这样的类不能被继承子类。详见阻止重写了解更多 final 修饰符的信息。
 
 如果一个子类重写了父类指定的初始化器，并且遵循协议实现了初始化器要求，那么就要为这个初始化器的实现添加 required 和 override 两个修饰符：
 
 protocol SomeProtocol {
     init()
 }
 
 class SomeSuperClass {
     init() {
         // initializer implementation goes here
     }
 }
 
 class SomeSubClass: SomeSuperClass, SomeProtocol {
     // "required" from SomeProtocol conformance; "override" from SomeSuperClass
 required override init() {
         // initializer implementation goes here
     }
 }
 
 */



// - - 可失败的初始化器要求

/*
 如同可失败初始化器定义的一样，协议可以为遵循该协议的类型定义可失败的初始化器。
 
 遵循协议的类型可以使用一个可失败的或不可失败的初始化器满足一个可失败的初始化器要求。不可失败初始化器要求可以使用一个不可失败初始化器或隐式展开的可失败初始化器满足。
 */



// - - 将协议作为类型

/*
 实际上协议自身并不实现功能。不过你创建的任意协议都可以变为一个功能完备的类型在代码中使用。
 
 由于它是一个类型，你可以在很多其他类型可以使用的地方使用协议，包括：
 
 在函数、方法或者初始化器里作为形式参数类型或者返回类型；
 作为常量、变量或者属性的类型；
 作为数组、字典或者其他存储器的元素的类型。

 注意
 由于协议是类型，要开头大写（比如说 FullyNamed 和 RandomNumberGenerator ）来匹配 Swift 里其他类型名称格式（比如说 Int 、 String 还有 Double ）。
 
 */



class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}



// - - 委托

/*
 委托是一个允许类或者结构体放手（或者说委托）它们自身的某些责任给另外类型实例的设计模式。这个设计模式通过定义一个封装了委托责任的协议来实现，比如遵循了协议的类型（所谓的委托）来保证提供被委托的功能。委托可以用来响应一个特定的行为，或者从外部资源取回数据而不需要了解资源具体的类型。
 
 Delegation 委托，可能也以“代理”而为人熟知，这里我们选择译为“委托”是为了更好的理解避免混淆。
 */

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

// 蛇与梯子游戏
class SnakesAndLadders: DiceGame { // 遵守了协议
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare: // 必须落在最后一格才算胜利
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snames and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()




// - - 在扩展里添加协议遵循

/*
 你可以扩展一个已经存在的类型来采纳和遵循一个新的协议，就算是你无法访问现有类型的源代码也行。扩展可以添加新的属性、方法和下标到已经存在的类型，并且因此允许你添加协议需要的任何需要。要了解更多关于扩展的信息，见扩展。
 
 注意
 类型已经存在的实例会在给它的类型扩展中添加遵循协议时自动地采纳和遵循这个协议。
 */

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable { // 扩展的时候让类遵循某个协议
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)


extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)




// - - 有条件地遵循协议

/*
 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在你采纳协议的名字后面写泛型 where 分句。更多关于泛型 where 分句，见泛型Where分句。
 */

// 让Array在存储遵循该协议的元素时遵循该协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)



// - - 使用扩展声明采纳协议

/*
 如果一个类型已经遵循了协议的所有需求，但是还没有声明它采纳了这个协议，你可以让通过一个空的扩展来让它采纳这个协议：
 */

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

// Hamster 实例现在可以用在任何 TextRepresentable 类型可用的地方了：
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

// 注意类型不会因为满足需要就自动采纳协议。它们必须显式地声明采纳了哪个协议。



// - - 协议类型的集合

/*
 协议可以用作存储在集合比如数组或者字典中的类型，如同在协议作为类型中所说。
 */

let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}

/*
 注意 thing 常量是 TextRepresentable 类型。它不是 Dice 类型，抑或 DiceGame 还是 Hamster ，就算后台实际类型是它们之一。总之，由于它是 TextRepresentable ，并且 TextRepresentable 唯一已知的信息就是包含了 textualDescription 属性，所以每次循环来访问 thing.textualDescription 是安全的。
 */




// - - 协议继承

/*
 协议可以继承一个或者多个其他协议并且可以在它继承的基础之上添加更多要求。
 协议继承的语法与类继承的语法相似，只不过可以选择列出多个继承的协议，使用逗号分隔
 
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
     // protocol definition goes here
 }
 
 */

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/*
 任何采用了 PrettyTextRepresentable 的类型都必须满足所有 TextRepresentable 强制的需要，另外还有 PrettyTextRepresentable 强制的要求。
 */

// 通过扩展来采纳和遵循该协议
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare  {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲"
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)



// - - 类专用的协议

/*
 
 通过添加 AnyObject 关键字到协议的继承列表，你就可以限制协议只能被类类型采纳（并且不是结构体或者枚举）。
 
 protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
     // class-only protocol definition goes here
 }

 注意在协议的要求假定或需要遵循的类型拥有引用语意的时候使用类专用的协议而不是值语意。要了解更多关于引用和值语意，见结构体和枚举是值类型和类是引用类型。

*/



// - - 协议组合

/*
 要求一个类型一次遵循多个协议是很有用的。你可以使用协议组合来复合多个协议到一个要求里。协议组合行为就和你定义的临时局部协议一样拥有构成中所有协议的需求。协议组合不定义任何新的协议类型。
 
 协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号连接（ & ），使用逗号分隔。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类。
 
 */

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) { // 同时遵守两个协议的类型
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)


class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)




// - - 协议遵循的检查

/*
 
 可以使用类型转换中描述的 is 和 as 运算符来检查协议遵循，还能转换为特定的协议。检查和转换协议的语法与检查和转换类型是完全一样的：
 
  如果实例遵循协议is运算符返回 true 否则返回 false ；
  as? 版本的向下转换运算符返回协议的可选项，如果实例不遵循这个协议的话值就是 nil ；
  as! 版本的向下转换运算符强制转换协议类型并且在失败是触发运行时错误。

 */

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius} // 用计算属性遵循了协议
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
    var area: Double // 用存储属性遵循了协议
    init(area: Double) {
        self.area = area;
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    // 使用AnyObject存储类型 不同的类实例
    Circle(radius: 2.0),
    Country(area: 243-910),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = objects as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that ddoesn't have an area")
    }
}
/*
 注意使用的对象并没有通过转换过程而改变。他们仍然是 Circle 、 Country 和 Animal 。总之，在储存在 objectWithArea 常量中的那一刻，他们仅被所知为 HasArea ，所以只有 area 属性可以访问。
 */



// - - 可选协议要求

/*
 你可以给协议定义可选要求，这些要求不需要强制遵循协议的类型实现。
 可选要求使用 optional 修饰符作为前缀放在协议的定义中。
 可选要求允许你的代码与 Objective-C 操作。
 协议和可选要求必须使用 @objc 标志标记。注意 @objc 协议只能被继承自 Objective-C 类或其他 @objc 类采纳。它们不能被结构体或者枚举采纳。
 
 当你在可选要求中使用方法或属性是，它的类型自动变成可选项。
 比如说，一个 (Int) -> String 类型的方法会变成 ((Int) -> String)? 。注意是这个函数类型变成可选项，不是方法的返回值。
 
 可选协议要求可以在可选链中调用，来说明要求没有被遵循协议的类型实现的概率。
 你可以通过在调用方法的时候在方法名后边写一个问号来检查它是否被实现，比如 someOptionalMethod?(someArgument) 。
 */

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

/*
 注意
 严格来讲，你可以写一个遵循 CounterDataSource 的自定义类而不实现任何协议要求。反正它们都是可选的。尽管技术上来讲是可以的，但这样的话就不能做一个好的数据源了。
 */

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if  let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}



// - - 协议扩展

/*
 协议可以通过扩展来提供方法和属性的实现以遵循类型。
 这就允许在协议自身定义行为，而不是在每一个遵循或者在全局函数里定义。
 
 比如说，RandomNumberGenerator协议可以扩展来提供 random()方法，它使用要求的 random()方法来返回随机的 Bool值：
 */

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
print("And here's a random Boolean:\(generator2.randomBool())")




// - - 提供默认实现

/*
 你可以使用协议扩展来给协议的任意方法或者计算属性要求提供默认实现。如果遵循类型给这个协议的要求提供了它自己的实现，那么它就会替代扩展中的默认实现。
 
 注意
 通过扩展给协议要求提供默认实现与可选协议要求的区别是明确的。尽管遵循协议都不需要提供它们自己的实现。有默认实现的要求不需要使用可选链就能调用。
 */

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}


// - - 给协议扩展添加限制

/*
 当你定义一个协议扩展，你可以明确遵循类型必须在扩展的方法和属性可用之前满足的限制。
 如Where分句中描述那样，在扩展协议名字后边使用where分句来写这些限制。
 比如说，你可以给 Collection 定义一个扩展来应用于任意元素遵循上面 TextRepresentable 协议的集合。
 */

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

/*
 由于 Array 遵循 Collection 并且数组的元素遵循 TextRepresentable 协议，数组可以使用 textualDescription 属性来获取它内容的文本化表示：
 */

print(hamsters.textualDescription)


/*
 注意

 如果遵循类型满足了为相同方法或者属性提供实现的多限制扩展的要求，Swift 会使用最匹配限制的实现。
 */

