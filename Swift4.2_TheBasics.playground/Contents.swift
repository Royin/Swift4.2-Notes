//: Playground - noun: a place where people can play

// 中文版翻译https://www.cnswift.org/

// ****《Swift 指南》**** //

// == 基础内容 == //

// - - 常量和变量

// - - 声明常量和变量

// let常量 var变量

let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

var x = 0.0, y = 0.0, z = 0.0  // 一行声明多个变量或常量，用逗号隔开


// - - 类型标注

var welcomeMessage: String  // 名字: 类型

welcomeMessage = "Hello"
var red, green, blue: Double


// - - 命名常量和变量

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow" // 常量变量名字不能再次使用，不能改存其他类型，不能互换

var friendlyWelcome = "Hello"
friendlyWelcome = "Bonjour!"

let languageName = "Swift"
//languageName = "Swift++" // 注：常量值不能改变


// - - 输出常量和变量

print(friendlyWelcome)
print("The current value of friendlyWelcome is \(friendlyWelcome)")


// - - 注释

// 一行

/*多行
 注释*/

/*开头
 /*嵌套注释*/
 结尾*/


// - - 分号

let cat = "🐱"; print(cat) // 一行写多句代码才需要分号


// - - 整数
          // UInt在32位平台相当于UInt32, 在64位平台相当UInt64


// - - 整数范围

let minValue = UInt8.min // 最小值是0， 值的类型是UInt8
let maxValue = UInt8.max // 最大值是255, 值的类型是UInt8


// - - Int
           // 在32位平台，Int的长度与Int32相同
           // 在64位平台，Int的长度与Int64相同


// - - UInt
           // 在32位平台，UInt的长度与UInt32相同
           // 在64位平台，UInt的长度与UInt64相同


// - - 浮点数
           // Double 代表64位的浮点数，有至少15位数字的精度
           // Float 代表32位的浮点数，精度只有6位，两者皆可下推荐使用Double


// - - 类型安全和类型推断

let meaningOfLife = 42  // 会自动推断为Int的类型
let pi = 3.14189  // 推断为Double(推断始终选择Double,不会为Float)

let anotherPi = 3 + 0.14159 // 被推断为Double


// - - 数值型字面量

/*
 一个十进制数，没有前缀
 一个二进制数，前缀是 0b
 一个八进制数，前缀是 0o
 一个十六进制数，前缀是 0x
 */

/*
  整数字面量
 */

let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

/*
   浮点数字面量，可以是十进制或是十六进制
   十进制的浮点字面量可选指数e
   十六进制的浮点字面量必须有指数p
 */

/*
 十进制数与 exp  的指数，结果就等于基数乘以 10exp
 1.25e2 意味着 1.25 x 102, 或者 125.0
 1.25e-2  意味着 1.25 x 10-2, 或者 0.0125
 
 十六进制数与 exp 指数，结果就等于基数乘以2exp
 0xFp2  意味着 15 x 22, 或者 60.0
 0xFp-2  意味着 15 x 2-2, 或者 3.75
 */

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1 // 可以添加额外的0或下划线增加可读性


// == 数值类型转换 == //

// - - 整数转换

//let cannotBeNegative: UInt8 = -1  // 报错，UInt8 0~255
//let tooBig: Int8 = Int8.max + 1

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1  // 两者类型不同，不能直接被相加
let twoThousandAndOne = twoThousand + UInt16(one)


// - - 整数和浮点数转换

let three = 3
let pointOneForOneFiveNine = 0.14159
let the_pi = Double(three) + pointOneForOneFiveNine // 整数浮点数相互转换必须显式指定类型

let integerPi = Int(the_pi) // 被截断，等于3
     // 3 + 0.14159 ok,因为字面量本身没有类型，但变量有类型


// - - 类型别名

//(为已经存在的类型定义一个新的可选名字 typealias)
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min


// - - 布尔值

let orangesAreOrange = true
let turnipsAredelicious = false  // 赋值true/false会被推断为布尔值
if turnipsAredelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible")
}

let i = 1

//if i {
//    编译错误
//}

let j = 1
if j == 1 {
    // 这样就可以， j == 1 的结果是一个布尔值
}



// == 元组 == //

let http404Error = (404, "Not Found") // type(Int, String)

let (statusCode, statusMessage) = http404Error // 将元组内容分解成单独的常量或变量
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error // 不需要的可以使用下划线代替

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)") // 使用从0开始的索引访问元组中的单独元素

let http200Status = (statusCode: 200, description: "OK") // 可以在定义时给元素命名
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")
/*
 注意
 
 元组在临时的值组合中很有用，但是它们不适合创建复杂的数据结构。如果你的数据结构超出了临时使用的范围，那么请建立一个类或结构体来代替元组。更多信息请参考类和结构体。
 */




// == 可选项 === //

//(用来处理值可能缺失的情况)

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // 转换失败的话会返回nil，如Int("hello")
                      // 可能返回Int, 可能返回nil， 不会是其他类型


// - - nil

//(可以通过给可选变量赋值一个nil来将之设置为没有值)

var serverResponseCode: Int? = 404
serverResponseCode = nil

/*
 * 注意
 * nil 不能用于非可选的常量或者变量，如果你的代码中变量或常量需要作用于特定条件下的值缺失，可以给他声明为相应类型的可选项。
 */

var surveyAnswer: String? // 定义可选类型没有提供给一个默认值，会被自动设置成nil

/*
 注意
 
 Swift 中的 nil 和Objective-C 中的 nil 不同，在 Objective-C 中 nil 是一个指向不存在对象的指针。在 Swift中， nil 不是指针，他是值缺失的一种特殊类型，任何类型的可选项都可以设置成 nil 而不仅仅是对象类型。
 */




// - - If语句以及强制展开

if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!)")
    // 可选项后加感叹号(!)来获取值
    // 感叹号的意思就是说“我知道这个可选项里边有值，展开吧。”
    // 这就是所谓的可选值的强制展开
}

/*
 注意
 
 使用 ! 来获取一个不存在的可选值会导致运行错误，在使用!强制展开之前必须确保可选项中包含一个非 nil 的值。
 */



// - - 可选项绑定

//if let constantName = someOptional {
//    statmets // 可选项绑定获取可选项的值
//}

if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
    // 也可以用一个变量var来绑定可选项

if  let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber  && secondNumber < 100 {
    // 多个可选项绑定用逗号隔开
    print("\(firstNumber) < \(secondNumber) < 100")
}

    // 等价以上
if let firstNumber2 = Int("4") {
    if let scondNumber2 = Int("42") {
        if firstNumber2 < scondNumber2 && scondNumber2 < 100 {
            print("\(firstNumber2) < \(scondNumber2) < 100")
        }
    }
}

/*
 注意
 
 如同提前退出中描述的那样，使用 if 语句创建的常量和变量只在if语句的函数体内有效。相反，在 guard 语句中创建的常量和变量在 guard 语句后的代码中也可用。
 */



// - - 隐式展开可选项

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号标识

    // 声明类型加！号 --> 隐式展开可选项
let assumedString: String! = "An implictly unwrapped optional string."
let implicitString: String = assumedString // 不需要感叹号标识（隐式展开、不需要展开、自动展开）

/*
 注意
 
 如果你在隐式展开可选项没有值的时候还尝试获取值，会导致运行错误。结果和在没有值的普通可选项后面加一个叹号一样。
 */

if assumedString != nil {
    // 也可以使用if判断隐式可选项
    print(assumedString)
}

if let definiteString = assumedString {
    // 也可以通过可选项绑定使用隐式展开
    print(definiteString)
}

/*
 注意
 
 不要在一个变量将来会变为 nil 的情况下使用隐式展开可选项。如果你需要检查一个变量在生存期内是否会变为 nil ，就使用普通的可选项。
 */



// - - 错误处理

func canThrowAnError() throws {
    // this function may or may not throw an error
    
}

  // 通过在函数声明中加入throws关键字来表明这个函数会抛出一个错误，调用需要用try

do {
    try canThrowAnError()
    // no error was thrown 没有抛出错误
} catch {
    // an error was thrown 抛出错误
}

func makeASandwich() throws {
    // ...
}

//do {
//    try makeASandwich()
//    eatASandwich()
//} catch Error.outOfCleanDishes {
//    washDishes()
//} catch Error.MissingIngredients(let ingredients) {
//    buyGroceries(ingredients)
//}



// == 断言和先决条件 ==

/*
 断言和先决条件用来检测运行时发生的事情
 可以使用它们来保证在执行后续代码前某必要条件是满足的
 如果布尔条件在断言或先决条件中计算为 true ，代码就正常继续执行。如果条件计算为 false ，那么程序当前的状态就是非法的；代码执行结束，然后你的 app 终止。
 断言只在 debug 构建的时候检查，但先决条件则在 debug 和生产构建中生效
 在生产构建中，断言中的条件不会被计算。
 这就是说你可以在开发的过程当中随便使用断言而无需担心影响生产性能。
 */



// - - 使用断言进行调试

let age = -3
//assert(age >= 0, "A person's age cannot be less than  zero")

//assert(age >= 0) // 删掉断言信息

if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age > 0 {
    print("You can ride teh ferris wheel.")
} else {
//    assertionFailure("A person's age can't be less than zero.")
}
    // 如果代码已经检查了条件，你可以使用 assertionFailure(_:file:line:) 函数来标明断言失败



// - - 强制先决条件


/*
 在你代码中任何条件可能潜在为假但必须可定为真才能继续执行的地方使用先决条件
 */

let index = 1
precondition(index > 0, "Index must be greater than zero.")

    // 你可以调用 preconditionFailure(_:file:line:) 函数来标明错误发生了——比如说，如果 switch 的默认情况被选中，但所有的合法输入数据应该被其他 switch 的情况处理。

/*
 注意
 
 如果你在不检查模式编译（ -Ounchecked ），先决条件不会检查。编译器假定先决条件永远为真，并且它根据你的代码进行优化。总之， fatalError(_:file:line:) 函数一定会终止执行，无论你优化设定如何。
 
 你可以在草拟和早期开发过程中使用 fatalError(_:file:line:) 函数标记那些还没实现的功能，通过使用 fatalError("Unimplemented") 来作为代替。由于致命错误永远不会被优化，不同于断言和先决条件，你可以确定执行遇到这些临时占位永远会停止。
 */





