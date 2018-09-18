//: Playground - noun: a place where people can play

// https://www.cnswift.org/functions
// https://docs.swift.org/swift-book/LanguageGuide/Functions.html


// ************** 函数 Functions ************** //

/*
 函数是一个独立的代码块，用来执行特定的任务。
 */



// - - 定义和调用函数

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
print(greet(person: "Brian"))

/*
 注意
 函数 print(_:separator:terminator:) 的第一个实际参数并没有标签，并且它的其他实际参数是可选的，是因为他们都有默认值。这些函数语法的变化在下边函数实际参数标签和形式参数名以及默认形式参数值小节中讨论。
 */

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))



// = = 函数的形式参数和返回值 = = //

/*
 在 Swift 中，函数的形式参数和返回值非常灵活。你可以定义从一个简单的只有一个未命名形式参数的工具函数到那种具有形象的参数名称和不同的形式参数选项的复杂函数之间的任何函数。
 */



// - - 无形式参数的函数

/*
 函数的定义仍然需要在名字后边加一个圆括号，即使它不接受形式参数也得这样做。当函数被调用的时候也要在函数的名字后边加一个空的圆括号。
 */

func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())



// - - 多形式参数的函数

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))




// - - 无返回值的函数

func greet2(person: String) {
    print("Hello, \(person)!")
}
greet2(person: "Dave") // 同函数名同参数，只是有无返回类型的区别的话，无法区分调用的是哪个

/*
 注意
 严格来讲，函数 greet(person:)还是有一个返回值的，尽管没有定义返回值。没有定义返回类型的函数实际上会返回一个特殊的类型 Void。它其实是一个空的元组，作用相当于没有元素的元组，可以写作 () 。
 */

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
printWithoutCounting(string: "hello, world") // 当函数被调用时，函数的返回值可以被忽略

/*
 注意
 返回值可以被忽略，但是如果一个函数需要返回值的时候就必须返回。如果一个函数有定义的返回类型，没有返回值的话就不会继续运行到函数的末尾，尝试这么做的话会得到编译时错误。
 */



// - - 多返回值的函数

/*
 让函数返回多个值作为一个复合的返回值，可以使用元组类型作为返回类型
 */

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")



// - - 可选元组返回类型

/*
 如果元组在函数的返回类型中有可能“没有值”，你可以用一个可选元组返回类型来说明整个元组的可能是 nil 。例如 (Int, Int)?  或者 (String, Int, Bool)?
 注意
 类似 (Int, Int)?的可选元组类型和包含可选类型的元组 (Int?, Int?)是不同的。对于可选元组类型，整个元组是可选的，而不仅仅是元组里边的单个值。
 */

func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax2(array: [8, -6, 2, 109, 3, 71]) { // 可选项绑定
    print("min is \(bounds.min) and max is \(bounds.max)")
}




// - - 函数实际参数标签和形式参数名

/*
 每一个函数的形式参数都包含实际参数标签和形式参数名。
 实际参数标签用在调用函数的时候；在调用函数的时候每一个实际参数前边都要写实际参数标签。
 形式参数名用在函数的实现当中。默认情况下，形式参数使用它们的形式参数名作为实际参数标签。
 */

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    
}
someFunction(firstParameterName: 1, secondParameterName: 2)



// - - 指定实际参数标签

func someFuntion2(argumentLabel parameterName: Int) {
    // 实际参数标签argumentLabel
}

/*
 注意
 如果你为一个形式参数提供了实际参数标签，那么这个实际参数就必须在调用函数的时候使用标签。
 */

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))



// - - 省略实际参数标签

/*
 默认形式参数名作为实际参数标签。
 如果对于函数的形式参数不想使用实际参数标签的话，可以利用下划线（ _ ）来为这个形式参数代替显式的实际参数标签。
 */

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 为参数值
}
someFunction(1, secondParameterName: 2) // 第一个参数不带实际参数标签



// - - 默认形式参数值

/*
 你可以通过在形式参数类型后给形式参数赋一个值来给函数的任意形式参数定义一个默认值。
 如果定义了默认值，你就可以在调用函数时候省略这个形式参数。(参数有默认值可省略)
 */

func someFunction(parameterWithDefault: Int = 12) {
    // parameterWithDefault 如果 没有参数传递给函数 默认 12.
}
someFunction(parameterWithDefault: 6) // parameterWithDefault is 6
someFunction() // parameterWithDefault is 12



// - - 可变形式参数

/*
 一个可变形式参数可以接受零或者多个特定类型的值。
 可以通过在形式参数的类型名称后边插入三个点符号（ ...）来书写可变形式参数。(参数类型...)
 */

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)

/*
 注意
 一个函数最多只能有一个可变形式参数。
 */



// - - 输入输出形式参数

/*
 可变形式参数只能在函数的内部做改变
 如果你想函数能够修改一个形式参数的值，而且你想这些改变在函数结束之后依然生效，那么就需要将形式参数定义为输入输出形式参数。
 在形式参数定义开始的时候在前边添加一个 inout关键字可以定义一个输入输出形式参数。
 输入输出形式参数有一个能输入给函数的值，函数能对其进行修改，还能输出到函数外边替换原来的值。
 你只能把变量作为输入输出形式参数的实际参数。你不能用常量或者字面量作为实际参数，因为常量和字面量不能修改。
 在将变量作为实际参数传递给输入输出形式参数的时候，直接在它前边添加一个和符号 ( &) 来明确可以被函数修改。
 
 注意
 输入输出形式参数不能有默认值，可变形式参数不能标记为 inout，如果你给一个形式参数标记了 inout，那么它们也不能标记 var和 let了。
 */

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

/*
 注意
 输入输出形式参数与函数的返回值不同。上边的 swapTwoInts没有定义返回类型和返回值，但它仍然能修改 someInt和 anotherInt的值。输入输出形式参数是函数能影响到函数范围外的另一种替代方式。
 */



// - - 函数类型

/*
 每一个函数都有一个特定的函数类型，它由形式参数类型，返回类型组成。
 */

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
} // 这两个函数的类型都是 (Int, Int) -> Int

func printHelloWorld() {
    print("hello, world")
} // 函数的类型是 () -> Void



// - - 使用函数类型

/*
 可以像使用 Swift 中的其他类型一样使用函数类型。例如，你可以给一个常量或变量定义一个函数类型，并且为变量指定一个相应的函数。
 */

var mathFunction: (Int, Int) -> Int = addTwoInts // mathFunction指向addTwoInts
print("Result: \(mathFunction(2, 3))") // 可以利用名字 mathFunction来调用指定的函数

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")

let anotherMathFunction = addTwoInts // 指定一个函数为常量或变量，会类型推断



// - - 函数类型作为形式参数类型

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)



// - - 函数类型作为返回类型

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int { // 函数类型作为返回类型
    return backwards ? stepBackward : stepForward
}


var currentValue = 3
let moveNearerToZero = chooseStepFunction(backwards: currentValue > 0)

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!



// - - 内嵌函数

/*
 本章中遇到的所有函数都是全局函数，都是在全局的范围内进行定义的。
 你也可以在函数的内部定义另外一个函数。这就是内嵌函数。
 
 内嵌函数在默认情况下在外部是被隐藏起来的，但却仍然可以通过包裹它们的函数来调用它们。
 包裹的函数也可以返回它内部的一个内嵌函数来在另外的范围里使用。
 */

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue2 = -4
let moveNearerToZero2 = chooseStepFunction(backward: currentValue2 > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue2 != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
