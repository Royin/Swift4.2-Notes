//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
// https://www.cnswift.org/classes-and-structures


// ************* 类和结构体 Structures and Classes ************** //


// = =  类和结构体 = = //

/*
 作为程序代码的构建基础，类和结构体是一种多功能且灵活的构造体。
 通过使用与现存常量、变量、函数完全相同的语法来在类和结构体当中定义属性和方法以添加功能。
 
 不像其他的程序语言，Swift不需要你为自定义类和结构体创建独立的接口和实现文件。在 Swift 中，你在一个文件中定义一个类或者结构体， 则系统将会自动生成面向其他代码的外部接口。
 
 注意
 
 一个类的实例通常被称为对象。总之，Swift 的类和结构体在功能上要比其他语言中的更加相近，并且本章节所讨论的大部分功能都可以同时用在类和结构体的实例上。因此，我们使用更加通用的术语实例。
 */



// - - 类与结构体的对比

/*
 
 Swift中类和结构体的共同点：
 定义属性用来存储值；                  （属性）
 定义方法用于提供功能；                 （方法）
 定义下标脚本用来允许使用下标语法访问值；  （下标）
 定义初始化器用于初始化状态；            （初始化）
 可以被扩展来在原来实现之上扩展功能；      （可扩展）
 遵循协议来针对特定类型提供标准功能。      （遵循协议）
 
 类具有的额外功能：
 继承可以让一个类继承另一个类的特征；             （继承）
 类型转换可以在运行时检查解释类实例的类型；        （类型转换）
 反初始化器可以让一个类实例释放任何其所被分配的资源；（反初始化）
 引用计数可以对多个类实例引用。                  （多个引用）
 
 注意：结构体通过复制传递，不会使用引用计数
 
 */



// - - 定义语法

class SomeClass { // class定义类
    // 类的定义...
}

struct SomeStructure { // sturcture 定义
    // 结构体的定义...
}

/*
 注意：
 定义一个类或结构体，就定义了一个全新的Swift类型.要使用UpperCanmelCase命名法。
 对于属性和方法使用lowerCamelCase命名法
 */

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}



// - - 类与结构体实例

let someResolution = Resolution()
let someVideoMode = VideoMode()  // 初始化方法



// - - 访问属性

  // 点语法 .xxx
print("The width of someResolution is \(someResolution.width)")

print("The width of someVideoMode is \(someVideoMode.resolution.width)")

  // 点语法指定一个新值到一个变量属性中
someVideoMode.resolution.width = 1280
print("The width  of someVideoMode is now \(someVideoMode.resolution.width)")

/*
 注意：
 不同于OC，Swift允许直接设置一个结构体属性中的子属性。
 不需要重新设置一个新的resolustion属性到类实例
 */



// - - 结构体类型的成员初始化器

/*
 结构体有一个自动生成的成员初始化器，可以用来初始化新结构体实例的成员属性。
 新实例的初始化值可以通过属性名称传递到成员初始化器中
 */

let vga = Resolution(width: 60, height: 480)

   // * 与结构体不同，类实例不会接收默认的成员初始化器



// - - 结构体和枚举是值类型

/*
 值类型是一种被指定到常量或变量，或被传递到函数时会被拷贝的类型
 
 Swift中所有基本类型(整数，浮点数，布尔量，字符串，数组，字典)都是值类型，都以结构体的形式在后台实现。
 
 Swift中所有的结构体和枚举都是值类型。
 结构体实例、枚举实例、作为属性的任何值类型----传递时始终会被复制
 
 注意
 标准库（如数组，字典和字符串）定义的集合使用优化来降低复制的性能成本。这些集合不是立即复制，而是共享内存，其中元素存储在原始实例和任何副本之间。如果修改了集合的其中一个副本，则在修改之前复制元素。您在代码中看到的行为总是好像立即发生了复制。
 
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide") // hd 1920 并没有被改变

// 适用于枚举
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()
print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)") // 还是west



// - - 类是引用类型

/*
 引用类型被赋值到一个常量，变量或者本身被传递到一个函数的时候它是不会被拷贝的。
 相对于拷贝，这里使用的是同一个对现存实例的引用。
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

/*
 注意 tenEighty和 alsoTenEighty都被声明为常量。然而，你仍然能改变 tenEighty.frameRate和 alsoTenEighty.frameRate因为 tenEighty和 alsoTenEighty常量本身的值不会改变。 tenEighty和 alsoTenEighty本身是并没有存储 VideoMode实例—相反，它们两者都在后台指向了 VideoMode实例。这是 VideoMode的 frameRate参数在改变而不是引用 VideoMode的常量的值在改变。
 */



// - - 特征运算符

/*
 因为类是引用类型，在后台有可能有很多常量和变量都是引用到了同一个类的实例。(相同这词对结构体和枚举来说并不是真的相同，因为它们在赋予给常量，变量或者被传递给一个函数时总是被拷贝过去的。)
 
 有时候找出两个常量或者变量是否引用自同一个类实例非常有用，为了允许这样，Swift提供了两个特点运算符：
 相同于 ( ===)
 不相同于( !==)
 
 */
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

/*
 注意”相同于”(用三个等于号表示，或者说 ===)这与”等于”的意义不同(用两个等于号表示，或者说 ==)。
 
 “相同于”意味着两个类类型常量或者变量引用自相同的实例；
 “等于”意味着两个实例的在值上被视作“相等”或者“等价”，某种意义上的“相等”，就如同类设计者定义的那样。
 
 当你定义了你自己的自定义类和结构体，你有义务来判定两个实例”相等”的标准。在等价运算符中描述了定义自己的“等于”和“不等于”运算符的实现的过程。
 */



// - - 指针

/*
 如果您有使用C，C ++或Objective-C的经验，您可能知道这些语言使用指针来引用内存中的地址。
 引用某个引用类型的实例的Swift常量或变量类似于C中的指针，但它不是指向内存中地址的直接指针，并且不需要您编写星号（*）来明确你建立了一个引用。
 
 相反，这些引用的定义与Swift中的任何其他常量或变量一样。标准库提供指针和缓冲区类型，如果需要直接与指针交互，可以使用它们 - 请参阅手动内存管理。
 */









