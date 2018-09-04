//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html#
// https://www.cnswift.org/basic-operators


// **** 基本运算符 **** //


// - - 专门用语

/*
 运算符包括一元、二元、三元：
 一元运算符对一个目标进行操作（比如 -a  ）。一元前缀运算符在目标之前直接添加（比如 !b ），同时一元后缀运算符直接在目标末尾添加（比如 c! ）。
 二元运算符对两个目标进行操作（比如 2 + 3  ）同时因为它们出现在两个目标之间，所以是中缀。
 三元运算符操作三个目标。如同 C，Swift语言也仅有一个三元运算符，三元条件运算符（  a ? b : c ）。
 
 受到运算符影响的值叫做操作数。在表达式 1 + 2  中， +  符号是一个二元运算符，其中的两个值 1 和 2 就是操作数
 */



// - - 赋值运算符

let b = 10
var a = 5
a = b      // a的值现在为10  赋值运算符可以初始化或者更新a为b的值

let (x, y) = (1, 2) // 右边是元组，它的元素将会一次性地拆分为常量或者变量
    // x 等于 1，同时 y 等于 2

//if x = y {
//    // 不合法，赋值符号自身不会反悔值，与Objective-C和C不同
//}



// - - 算术运算符

/*
 加 ( + )
 减 ( - )
 乘 ( * )
 除 ( / )
 
 与 C 和 Objective-C 中的算术运算符不同，Swift 算术运算符默认不允许值溢出
 可以选择使用 Swift 的溢出操作符（比如  a &+ b  ）来行使溢出行为
 
 加法运算符同时也支持 String  的拼接：
 "hello, " + "world" // equals "hello, world"
 */



// - - 余数运算符

/*
 余数运算符（ a % b ）可以求出多少个 b  的倍数能够刚好放进 a  中并且返回剩下的值（就是我们所谓的余数）。
 
 注意:
 余数运算符（ % ）同样会在别的语言中称作取模运算符。总之，严格来讲的话这个行为对应着 Swift 中对负数的操作，所以余数要比模取更合适。
 
 当 b为负数时它的正负号被忽略掉了。这意味着 a % b  与 a % -b  能够获得相同的答案。
 
 */



// - - 一元减号运算符

/*
 数字值的正负号可以用前缀 – 来切换，我们称之为 一元减号运算符
 一元减号运算符（ - ）直接在要进行操作的值前边放置，不加任何空格。

 */

let three = 3
let minusThreee = -three
let plusThree = -minusThreee



// - - 一元加号运算符

/*
 一元加号运算符 （ + ）直接返回它操作的值，不会对其进行任何的修改
 
 尽管一元加号运算符实际上什么也不做，你还是可以对正数使用它来让你的代码对一元减号运算符来说显得更加对称。
 */

let minusSix = -6
let alsoMinusSix = +minusSix



// - - 组合赋值符号

var a2 = 1
a2 += 2     // a2 is now equal to 3

/*
 注意
 
 组合运算符不会返回任何值。举例来说，你不能写成这样 let b = a += 2  。这个与前边提到的增量和减量符号的行为不同。
 */



// - - 比较运算符

/*
 Swift 支持所有 C 的标准比较运算符：
 相等 ( a == b )
 不相等 ( a != b )
 大于 ( a > b )
 小于 ( a < b )
 大于等于 ( a >= b )
 小于等于 ( a <= b )
 
 注意:
 Swift 同时也提供两个等价运算符（ ===  和 !== ），你可以使用它们来判断两个对象的引用是否相同。参考 类和结构体 章节来了解更多。
 
 每个比较运算符都会返回一个 Bool  值来表示语句是否为真
 
 */

1 == 1
2 != 1
2 > 1
1 < 2
1 >= 1
2 <= 1

    // 比较运算符通常被用在条件语句当中
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

/*
 可以比较拥有同样数量值的元组，只要元组中的每个值都是可比较的
 Bool 不能比较，这意味着包含布尔值的元组不能用来比较大小
 
 注意:
 Swift 标准库包含的元组比较运算符仅支持小于七个元素的元组。要比较拥有七个或者更多元素的元组，你必须自己实现比较运算符。
 */
(1, "zebra") < (2, "apple")
(3, "apple") < (3, "bird")
(4, "dog") == (4, "dog")



// - - 三元条件运算符

/*
 question ? answer1 : answer2
 */

//if question {
//    answer1
//} else {
//    anser2
//}

let contentHeigt = 40
let hasHeadr = true
let rowHeight = contentHeigt + (hasHeadr ? 50 : 20)



// - - 合并空值运算符

/*
 合并空值运算符 （ a ?? b ）如果可选项 a  有值则展开，如果没有值，是 nil  ，则返回默认值 b
 表达式 a 必须是一个可选类型
 表达式 b  必须与 a  的储存类型相同
 */

let my: String? = "aaa"
let you: String = "bbb"
my != nil ? my! : you  // my ?? you 相当于这行代码的缩写

/*
 注意
 如果 a  的值是非空的， b  的值将不会被考虑。这就是所谓的 短路计算 。
 */

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName




// - - 区间运算符 - -

// - - 闭区间运算符 a...b

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}



// - - 半开区间运算符 a..<b

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}



// - - 单侧区间 [a...] [...a] [..<a]

for name in names[2...] {
    print(name)
}

for name in names[...2] {
   print(name)
}

for name in names[..<2] {
    print(name)
}

let range = ...5
range.contains(7)
range.contains(4)
range.contains(-1)
range.contains(-99)




//  - - 逻辑运算符 - -

/*
 逻辑 非  ( !a )
 逻辑 与  ( a && b )
 逻辑 或  ( a || b )
 */


// - - 逻辑非运算符 !a

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}


// - - 逻辑与运算符 a&&b

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}


// 逻辑或运算符 a||b

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}


// - - 混合逻辑运算

if  enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

/*
 Swift 语言中逻辑运算符 && 和 || 是左相关的，这意味着多个逻辑运算符组合的表达式会首先计算最左边的子表达式
 */



// - - 显示括号
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    // 括号增加可读性
    print("Welcome!")
} else {
    print("ACCESS DENIEDE")
}


