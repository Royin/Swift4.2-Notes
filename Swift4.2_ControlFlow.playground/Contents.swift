//: Playground - noun: a place where people can play

// https://www.cnswift.org/control-flow
// https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html

// ******** 控制流 Control Flow ******** //



// - - For-in 循环

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)")
    // 遍历数组元素
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
    // 遍历字典 - (key, value)元组
    // 键分解到了animalName常量中，值分解到了legCount常量中
}

for index in 1...5 {
    print("\(index) tiems 5 is \(index * 5)")
    // 遍历数字区间
    // index是一个常量，值在每次遍历循环开始时候被自动地设置
}

let base = 3
let power = 10
var anser = 1
for _ in 1...power {
    // 不需要序列的每一个值，用下划线取代
    anser *= base
}

let minutes = 60
for tickMark in 0..<minutes {
    // 半开区间(包含最小值但不包含最大值)
}

let minuteInterval = 5
for tickMart in stride(from: 0, to: minutes, by: minuteInterval) {
    // stride(from:to:by:) 函数来跳过不想要的标记
    // (0, 5, 10, 15 ... 45, 50, 55)
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // stride(from:through:by:) 闭区间
    // (3, 6, 9, 12)
}



// - - While 循环

/*
 Swift 提供了两种 while 循环：
 while 在每次循环开始的时候计算它自己的条件；
 repeat-while 在每次循环结束的时候计算它自己的条件。
 */



// - - While

/*
 玩蛇与梯子（滑梯与梯子）
 */

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
}
print("Game over!")



// - - Repeat-While

/*
 repeat {
 statements
 } while condition
 */

let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square2 = 0
var diceRoll2 = 0
repeat {
    // move up or down for a snake or ladder
    square += board[square]
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
} while square < finalSquare
print("Game over!")



// - - 条件语句

/*
 Swift 提供了两种方法来给你的代码添加条件分支，就是所谓的 if 语句和 switch 语句。
 */



// - - If

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// prints "It's very cold. Consider wearing a scarf."

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// prints "It's not that cold. Wear a t-shirt."

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}



// - - Switch

/*
 switch 语句会将一个值与多个可能的模式匹配。然后基于第一个成功匹配的模式来执行合适的代码块。
 */

/*
switch some value to consider {
    case value 1:
    respond to value 1
    case value 2,
    value 3:
    respond to value 2 or 3
    default:
    otherwise, do something else
}
*/

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// Prints "The last letter of the alphabet"


// - - 没有隐式贯穿

/*
 Swift 里的 switch 语句不会默认从每个情况的末尾贯穿到下一个情况里。
 整个 switch 语句会在匹配到第一个 switch 情况执行完毕之后退出，不再需要显式的 break 语句
 */

let anotherCharacter: Character = "a"
switch anotherCharacter {
//case "a":  // 运行错误：每一个情况的函数体必须包含至少一个可执行的语句。
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}

let anotherCharacter2: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// "The letter A"

/*
 注意
 如同在贯穿中描述的那样，要在特定的 switch 情况中使用贯穿行为，使用 fallthrough 关键字。
 */



// - - 区间匹配

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")



// - - 元组

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}



// - - 值绑定

/*
 switch 情况可以将匹配到的值临时绑定为一个常量或者变量，来给情况的函数体使用。
 这就是所谓的值绑定，因为值是在情况的函数体里“绑定”到临时的常量或者变量的。
 */

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}



// - - Where

/*
 switch 情况可以使用 where 分句来检查额外的情况。
 */

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}



// - - 复合情况

let someCharacter2: Character = "e"
switch someCharacter2 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter2) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter2) is a consonant")
default:
    print("\(someCharacter2) is not a vowel or a consonant")
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}



// = = 控制转移语句 = = //

/*
 
 控制转移语句在你代码执行期间改变代码的执行顺序，通过从一段代码转移控制到另一段。
 Swift 拥有五种控制转移语句：
 continue
 break
 fallthrough
 return
 throw
 
 */



// - - Continue

/*
 continue 语句告诉循环停止正在做的事情并且再次从头开始循环的下一次遍历。
 它是说“我不再继续当前的循环遍历了”而不是离开整个的循环。
 
 注意
 在一个包含条件和自增器的 for 循环中，循环的自增器仍然会在调用 continue 语句后评定。循环自身还是会和往常一样工作；只有循环体中的代码被跳过。
 */

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    } else {
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)



// - - Break

/*
 break 语句会立即结束整个控制流语句。
 当你想要提前结束 switch 或者循环语句或者其他情况时可以在 switch 语句或者循环语句中使用 break 语句。
 */

    
    
// - - 循环语句中的 Break

/*
 当在循环语句中使用时， break 会立即结束循环的执行，并且转移控制到循环结束花括号（ } ）后的第一行代码上。
 当前遍历循环里的其他代码都不会被执行，并且余下的遍历循环也不会开始了。
 */



// - - Switch 语句里的 Break

/*
 break 导致 switch 语句立即结束它的执行，并且转移控制到 switch 语句结束花括号（ } ）之后的第一行代码上。
 
 注意
 switch 的情况如果只包含注释的话会导致编译时错误。注释不是语句，并且不会导致 switch 情况被忽略。要使用 break 语句来忽略 switch 情况。
 */

let numberSymbol: Character = "三"  // Simplified Chinese for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break // 须用break来忽略情况
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}



// - - Fallthrough

/*
 Swift 中的 Switch 语句不会从每个情况的末尾贯穿到下一个情况中。
 相反，整个 switch 语句会在第一个匹配到的情况执行完毕之后就直接结束执行。
 如果你确实需要 C 风格的贯穿行为，你可以选择在每个情况末尾使用 fallthrough 关键字。
 */

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

/*
 注意
 fallthrough 关键字不会为switch情况检查贯穿入情况的条件。 fallthrough 关键字只是使代码执行直接移动到下一个情况（或者 default 情况）的代码块中，就像C的标准 switch 语句行为一样。
 */



// - - 给语句打标签

/*
 可以内嵌循环和条件语句到其他循环和条件语句当中
 循环和条件语句都可以使用 break 语句来提前结束它们的执行
 显式地标记那个循环或者条件语句是你想用 break 语句结束的就很有必要
 */

/*
 label name: while condition {
 statements
 }
 */

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")

/*
 注意
 如果上边的 break 语句不使用 gameLoop 标签，它就会中断 switch 语句而不是 while 语句。使用 gameLoop 标签使得要结束那个控制语句变得清晰明了。
 同时注意当调用 continue gameLoop 来跳入下一次循环并不是强制必须使用 gameLoop 标签的。游戏里只有一个循环，所以 continue 对谁生效是不会有歧义的。总之，配合 continue 使用 gameLoop 也无伤大雅。一直在 break 语句里写标签会让游戏的逻辑更加清晰和易读。
 */



// - - 提前退出

/*
 guard 语句，类似于 if 语句，基于布尔值表达式来执行语句。
 使用 guard 语句来要求一个条件必须是真才能执行 guard 之后的语句。
 与 if 语句不同， guard 语句总是有一个 else 分句—— else 分句里的代码会在条件不为真的时候执行。
 */

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."



// - - 检查API的可用性

if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}

/*
if #available(platform name version, ..., *) {
    statements to execute if the APIs are available
} else {
    fallback statements to execute if the APIs are unavailable
}
 */
