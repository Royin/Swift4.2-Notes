
//https://www.cnswift.org/strings-and-characters
// https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html

// ************* 字符串和字符 *******************//

/*
 注意
 Swift 的 String类型桥接到了基础库中的 NSString类。Foundation 同时也扩展了所有 NSString 定义的方法给 String 。也就是说，如果你导入 Foundation ，就可以在 String 中访问所有的 NSString  方法，无需转换格式
 */


// - - 字符串字面量

let someString = "Some string literal value" // Swift会推断该常量类型为String

let quotation = """
这是多行字符串的写法
用三个双引号引起来
"""

let threeDoubleQuotes = """
Escaping the first quote \"""
Escaping all three quote \"\"\"
"""
    // 字符串中要包含“”，使用(\)转义双引号

let singelLineString = "These are the same."
let multilineString = """
These are the same.
"""
    // 连个字符串是一样的

let spaceLine = """

This string starts with a line feed.
It also ends with a line feed.

"""
    // 让字符串字面量开始或结束带有换行，写一个空行

func gererateQuotation() ->String {
    let quotation = """
        这里只是为了对齐
        
        字符串前面并不会有空白开头
            超过结束双引号的空格会被包含
        """
    
    return quotation
}
print(gererateQuotation())



// - - 初始化一个空字符串

var emptyString = ""
var anotherEmptyString = String()
    // 创建一个空String

if emptyString.isEmpty {
    print("Nothing to see here")
}
    // isEmpty属性来queen一个String是否为空



// - - 字符串可变性

var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander"
    // 指定字符串为变量可修改，常量不可修改

/*
 注意
 这个功能与 Objective-C 和 Cocoa 中的字符串改变不同，通过选择不同的类（ NSString和 NSMutableString）来明确字符串是否可被改变。
 */



// - - 字符串是值类型

/*
 Swift 的 String类型是一种值类型。如果你创建了一个新的 String值， String值在传递给方法或者函数的时候会被复制过去，还有赋值给常量或者变量的时候也是一样
 每一次赋值和传递，现存的 String值都会被复制一次，传递走的是拷贝而不是原本
 
 另一方面，Swift 编译器优化了字符串使用的资源，实际上拷贝只会在确实需要的时候才进行
 */



// - - 操作字符串    （for-in循环）

for character in "Dog!?" {
    print(character)
}

let exclamationMark: Character = "!"
    // 通过Character类型创建Character常量或变量

let catCharacters: [Character] = ["C", "a", "t", "!", "?"]
let  catString = String(catCharacters)
print(catString)



// - - 连接字符串和字符   （+）(+=) (append())

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMark2: Character = "!"
welcome.append(exclamationMark2)

/*
 注意
 你不能把 String或者 Character追加到已经存在的 Character变量当中，因为 Character值能且只能包含一个字符。
 */



// - - 字符串插值

var multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) *  2.5)"

/*
 注意
 你作为插值写在圆括号中的表达式不能包含非转义的双引号 ( ")或者反斜杠 ( \)，并且不能包含回车或者换行符。总之，它们可以包含其他字符串字面量。
 */




// = = Unicode = =

/*
 Unicode 是一种在不同书写系统中编码、表示和处理文本的国际标准。它允许你表示几乎标准化格式的任何语言中的任何字符，并且为外部源比如文本文档或者网页读写这些字符。如同这节中描述的那样，Swift 的 String和 Character类型是完全 Unicode 兼容的。
 */



// - - Unicode 标量

/*
 注意
 Unicode 标量码位位于 U+0000到 U+D7FF或者 U+E000到 U+10FFFF之间。Unicode 标量码位不包括从 U+D800到 U+DFFF的16位码元码位。
 
 不是所有的 21 位 Unicode 标量都指定了字符——有些标量是为将来所保留的。
 */



// - - 字符串字面量中的特殊字符

/*
 字符串字面量能包含以下特殊字符：
 转义特殊字符 \0 (空字符)， \\ (反斜杠)， \t (水平制表符)， \n (换行符)， \r(回车符)， \" (双引号) 以及 \' (单引号)；
 任意的 Unicode 标量，写作 \u{n}，里边的 n是一个 1-8 个与合法 Unicode 码位相等的16进制数字。
 */

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackheart = "\u{2665}"
let sparklingHeart = "\u{1F496}"



// - - 扩展字形集群

/*
 每一个 Swift 的 Character类型实例都表示了单一的扩展字形集群
 扩展字形集群是一个或者多个有序的 Unicode 标量（当组合起来时）产生的单个人类可读字符。
 */

let eAcute: Character = "\u{E9}"  // é
let combinedEAcute: Character = "\u{65}\u{301}" // e followed by '

let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"

let enclosedEAcute: Character = "\u{E9}\u{20DD}"

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"



// - - 字符统计  (count)
let unusualMenagerie = "Koala ?, Snail ?, Penguin ?, Dromedary ?"
print("unusualMenagerie has \(unusualMenagerie.count) charecters")

/*
 注意 Swift 为 Character值使用的扩展字形集群意味着字符串的创建和修改可能不会总是影响字符串的字符统计数
 */

var word = "cafe"
print("the number of characters in \(word) is \(word.count)")

word += "\u{301}"
print("the number of characters in \(word) is \(word.count)")

/*
 注意
 扩展字形集群能够组合一个或者多个 Unicode 标量。这意味着不同的字符——以及相同字符的不同表示——能够获得不同大小的内存来储存。因此，Swift 中的字符并不会在字符串中获得相同的内存空间。所以说，字符串中字符的数量如果不遍历它的扩展字形集群边界的话，是不能被计算出来的。如果你在操作特殊的长字符串值，要注意 count属性为了确定字符串中的字符要遍历整个字符串的 Unicode 标量。
 通过 count属性返回的字符统计并不会总是与包含相同字符的 NSString中 length属性相同。 NSString中的长度是基于在字符串的 UTF-16 表示中16位码元的数量来表示的，而不是字符串中 Unicode 扩展字形集群的数量。
 */



// = = 访问和修改字符串 = =

/*
 你可以通过下标脚本语法或者它自身的属性和方法来访问和修改字符串。
 */



// - - 字符串索引    (String.Index)

/*
 不同的字符会获得不同的内存空间来储存，所以为了明确哪个 Character 在哪个特定的位置，你必须从 String的开头或结尾遍历每一个 Unicode 标量。
 因此，Swift 的字符串不能通过整数值索引。
 
 使用 startIndex属性来访问 String中第一个 Character的位置。
 endIndex属性就是 String中最后一个字符后的位置。
 所以说， endIndex属性并不是字符串下标脚本的合法实际参数。
 如果 String为空，则 startIndex与 endIndex相等。
 
 使用 index(before:) 和 index(after:) 方法来访问给定索引的前后。
 要访问给定索引更远的索引，你可以使用 index(_:offsetBy:) 方法而不是多次调用这两个方法。
 */

let greeting = "Guten Tag!"
greeting[greeting.startIndex]

greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

//greeting[greeting.endIndex] // 范围之外，运行错误
//greeting.index(after: endIndex) // error

// 使用 indices属性来访问字符串中每个字符的索引
for index in greeting.indices {
    print("\(greeting[index])", terminator: "")
}

/*
 注意
 你可以在任何遵循了 Indexable 协议的类型中使用 startIndex 和 endIndex 属性以及 index(before:) ， index(after:) 和 index(_:offsetBy:) 方法。这包括这里使用的 String ，还有集合类型比如 Array ， Dictionary 和 Set 。
 */



// - - 插入和删除

/*
 insert(_:at:)
 remove(at:)
 removeSubrange(_:)
 */

var welcome2 = "hello"
welcome2.insert("!", at: welcome2.endIndex)

welcome2.insert(contentsOf: " there", at: welcome2.index(before: welcome2.endIndex))

welcome2.remove(at: welcome2.index(before: welcome2.endIndex))

let range2 = welcome2.index(welcome2.endIndex, offsetBy: -6)..<welcome2.endIndex
welcome2.removeSubrange(range2)

/*
 注意
 你可以在任何遵循了 RangeReplaceableIndexable 协议的类型中使用 insert(_:at:) ， insert(contentsOf:at:) ， remove(at:) 方法。这包括了这里使用的 String ，同样还有集合类型比如 Array ， Dictionary 和 Set 。
 */



// - - 子字符串

/*
 当你获得了一个字符串的子字符串
 比如说，使用下标或者类似 prefix(_:) 的方法——结果是一个 Substring 的实例，不是另外一个字符串
 
 Swift 中的子字符串拥有绝大部分字符串所拥有的方法，也就是说你可以用操作字符串相同的方法来操作子字符串
 
 总之，与字符串不同，在字符串上执行动作的话你应该使用子字符串执行短期处理
 当你想要把结果保存得长久一点时，你需要把子字符串转换为 String 实例
 */

let greeting2 = "Hello, world"
let index2 = greeting2.index(of: ",") ?? greeting2.endIndex
let beginning = greeting2[..<index2]

let newString = String(beginning)

/*
 与字符串类似，每一个子字符串都有一块内存区域用来保存组成子字符串的字符
 字符串与子字符串的不同之处在于，作为性能上的优化，子字符串可以重用一部分用来保存原字符串的内存，或者是用来保存其他子字符串的内存。
 （字符串也拥有类似的优化，但是如果两个字符串使用相同的内存，他们就是等价的。）这个性能优化意味着在你修改字符串或者子字符串之前都不需要花费拷贝内存的代价
 如同上面所说的，子字符串并不适合长期保存——因为它们重用了原字符串的内存，只要这个字符串有子字符串在使用中，那么这个字符串就必须一直保存在内存里。
 */

/*
 注意
 String 和 Substring 都遵循 StringProtocol 协议，也就是说它基本上能很方便地兼容所有接受 StringProtocol 值的字符串操作函数。你可以无差别使用 String 或 Substring 值来调用这些函数。
 */



// - - 字符串比较

/*
 Swift 提供了三种方法来比较文本值：
 字符串和字符相等性，
 前缀相等性以及
 后缀相等性。
 */



// - - 字符串和字符相等性

/*
 两个 String值（或者两个 Character值）如果它们的扩展字形集群是规范化相等，则被认为是相等的。如果扩展字形集群拥有相同的语言意义和外形，我们就说它规范化相等，就算它们实际上是由不同的 Unicode 标量组合而成。
 */
let Quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if  Quotation == sameQuotation {
    print("These two string are considered equal")
}

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}

/*
 注意
 字符串和字符的比较在 Swift 中并不区分区域设置。
 */



// - - 前缀和后缀相等性

/*
 hasPrefix(_:)
 hasSuffix(_:)
 */

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scene in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

/*
 注意
 如同字符串和字符相等性一节所描述的那样， hasPrefix(_:)和 hasSuffix(_:)方法只对字符串当中的每一个扩展字形集群之间进行了一个逐字符的规范化相等比较。
 */



// - - 字符串的 Unicode 表示

/*
 Swift 提供了几种不同的方法来访问字符串的 Unicode 表示。
 你可以使用 for-in语句来遍历整个字符串，来访以 Unicode 扩展字形集群的方式访问单独的 Character值。
 
 或者，你也可以用以下三者之一的其他 Unicode 兼容表示法来访问 String值：
 UTF-8 码元的集合（关联于字符串的 utf8  属性）
 UTF-16 码元的集合（关联于字符串的 utf16  属性）
 21位 Unicode 标量值的集合，等同于字符串的 UTF-32 编码格式（关联于字符串的 unicodeScalars 属性）
 
 */

let dogString = "Dog‼?"



// - - UTF-8 表示法

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")



// - - UTF-16 表示法

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 55357 56374 "



// - - Unicode 标量表示法

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 128054 "


for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}
// D
// o
// g
// ‼
// ?


