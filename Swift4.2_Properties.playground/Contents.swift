//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/Properties.html
// https://www.cnswift.org/properties


// ***************** 属性 Properties ******************//

/*
 属性可以将值与特定的类、结构体或者是枚举联系起来。
 存储属性会存储常量或变量作为实例的一部分，反之计算属性会计算（而不是存储）值。
 计算属性可以由类、结构体和枚举定义。存储属性只能由类和结构体定义。
 
 存储属性和计算属性通常和特定类型的实例相关联。
 总之，属性也可以与类型本身相关联。这种属性就是所谓的类型属性。
 
 另外，你也可以定义属性观察器来检查属性中值的变化，这样你就可以用自定义的行为来响应。属性观察器可以被添加到你自己定义的存储属性中，也可以添加到子类从他的父类那里所继承来的属性中。
 */



// - - 存储属性

/*
 在其最简单的形式中，存储属性是一个常量或变量，它存储为特定类或结构的实例的一部分。
 存储的属性可以是变量存储属性（由var关键字引入），也可以是常量存储属性（由let关键字引入）。
 
 如“ 默认属性值”中所述,可以为存储属性提供默认值作为其定义的一部分.
 还可以在初始化期间设置和修改存储属性的初始值。正如在初始化中分配常量属性所述，这一点对于常量存储属性也成立。
 */

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3) // 一个变量属性，一个常量属性
rangeOfThreeItems.firstValue = 6 // length不能被修改



// - - 常量结构体实例的存储属性

/*
 创建一个结构体实例赋给常量，不能修改结构体实例的属性，即使属性是变量属性
 */

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfThreeItems.firstValue = 6 // 报错

/*
 原因是由于结构是值类型。当值类型的实例标记为常量时，其所有属性也都标记为常量。
 
 类是引用类型，类实例的常量，可以修改其变量属性
 */



// - - 延迟存储属性

/*
 延迟存储属性的初始值在其第一次使用时才进行计算。
 声明前标注 lazy 修饰语来表示一个延迟存储属性
 */

/*
 注意
 你必须把延迟存储属性声明为变量（使用 var 关键字），因为它的初始值可能在实例初始化完成之前无法取得。常量属性则必须在初始化完成之前有值，因此不能声明为延迟。
 */

/*
 一个属性的初始值可能依赖于某些外部因素，当这些外部因素的值只有在实例的初始化完成后才能得到时，延迟属性就可以发挥作用了。
 而当属性的初始值需要执行复杂或代价高昂的配置才能获得，你又想要在需要时才执行，延迟属性就能够派上用场了。
 */

class DataImporter {
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some data")

/*
 DataManager可以在不从文件导入数据的情况下管理其数据
 DataImporter可能需要打开文件夹读取数据，不必一开始就创建，
 */
print(manager.importer.filename) // 首次访问时才会创建DataImporter



// - - 存储属性与实例变量

/*
 Objective-C除了属性还有实例变量
 Swift将这些概念统一到一个属性声明中，属性没有相应的实例变量
 */



// - - 计算属性

/*
 除了存储的属性之外，类，结构和枚举还可以定义计算属性，这些属性实际上不存储值。
 相反，它们提供了一个getter和一个可选的setter来间接检索和设置其他属性和值。
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y)")



// - - 简写设置器（setter）声明

/*
 如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么他将被默认命名为 newValue 。
 */

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}



// - - 只读计算属性

/*
 具有getter但是没有sertter的计算属性就是所谓的只读计算属性。只读计算属性返回一个值，也可以通过点语法访问，但是不能被修改为另一个值。
 */

/*
 注意

 您必须将计算属性（包括只读计算属性）声明为var关键字的变量属性，因为它们的值不固定。let关键字仅用于常量属性，以指示一旦将它们设置为实例初始化的一部分，就无法更改它们的值。
 */

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")





// - - 属性观察者

/*
 属性观察者会观察并对属性值的变化做出回应。每当一个属性的值被设置时，属性观察者都会被调用，即使这个值与该属性当前的值相同。
 
 你可以为你定义的任意存储属性添加属性观察者，除了延迟存储属性。
 你也可以通过在子类里重写属性来为任何继承属性（无论是存储属性还是计算属性）添加属性观察者。属性重载将会在重写中详细描述。

 你不需要为非重写的计算属性定义属性观察者，因为你可以在计算属性的setter里直接观察和响应它们值的改变。
 
 可以在属性上定义其中一个或两个观察者：
 willSet在存储值之前调用
 didSet在存储新值后立即调用
 
 如果实现了一个willSet观察者，它会将新属性值作为常量参数传递。您可以在实施过程中指定此参数的名称willSet。如果未在实现中编写参数名称和括号，则该参数的默认参数名称为newValue。
 
 类似地，如果您实现了一个didSet观察者，它会传递一个包含旧属性值的常量参数。您可以命名参数或使用默认参数名称oldValue。如果为其自己的didSet观察者中的属性分配值，则分配的新值将替换刚刚设置的值。
 
 注意
 
 在willSet与didSet当属性在子类中初始化设置超性能的观察家们称为，超类的初始化调用后。在调用超类初始化程序之前，类在设置自己的属性时不会调用它们。
 
 有关初始化委派的详细信息，请参阅初始化函数代表团值类型和初始值设定代表团类的类型。
 
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalStips to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 896

/*
 注意
 如果将具有观察者的属性作为输入输出参数传递给函数，则始终会调用willSet和didSet观察者。这是因为in-out参数的copy-in copy-out内存模型：该值总是写回函数末尾的属性。有关输入输出参数的详细讨论，请参阅输入输出参数。
 */



// - -  全局和局部变量

/*
 
 上面描述的用于计算和观察属性的功能也可用于全局变量和局部变量。

 全局变量是在任何函数，方法，闭包或类型上下文之外定义的变量。
 局部变量是在函数，方法或闭包上下文中定义的变量。
 
 在前面章节中遇到的全局变量和局部变量都是存储变量。
 存储的变量（如存储的属性）为特定类型的值提供存储，并允许设置和检索该值。
 
 但是，您还可以在全局或本地范围内定义计算变量并为存储变量定义观察者。
 计算变量计算它们的值，而不是存储它们，它们的编写方式与计算属性相同。
 
 注意
 全局常量和变量总是懒惰地计算，与Lazy Stored Properties类似。与延迟存储的属性不同，全局常量和变量不需要使用lazy修饰符进行标记。
 局部常量和变量永远不会懒惰地计算。
 
 */



// - - 类型属性

/*
 实例属性是属于特定类型的实例的属性。每次创建该类型的新实例时，它都有自己的一组属性值，与任何其他实例分开。
 
 您还可以定义属于该类型本身的属性，而不是该类型的任何一个实例。
 无论您创建的该类型的实例有多少，这些属性都只会有一个副本。
 这些属性称为类型属性。   ----（类型属性）
 
 类型属性对于定义对特定类型的所有实例通用的值很有用，例如所有实例都可以使用的常量属性（如C中的静态常量），或者存储全局值的变量属性该类型的实例（如C中的静态变量）。
 
 存储的类型属性可以是变量或常量。计算类型属性始终声明为变量属性，与计算实例属性的方式相同。
 
 注意
 
 与存储的实例属性不同，您必须始终为存储的类型属性提供默认值。这是因为类型本身没有初始化程序，可以在初始化时为存储的类型属性赋值。
 
 存储类型属性在首次访问时被初始化。它们只保证初始化一次，即使在同时由多个线程访问时也是如此，并且它们不需要用lazy修饰符标记。
 
 */



// - - 类型属性语法

/*
 在 C 和  Objective-C 中，你使用全局静态变量来定义一个与类型关联的静态常量和变量。在 Swift 中，总之，类型属性是写在类型的定义之中的，在类型的花括号里，并且每一个类型属性都显式地放在它支持的类型范围内。
 
 使用 static 关键字来开一类型属性。对于类类型的计算类型属性，你可以使用 class 关键字来允许子类重写父类的实现。
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

/*
 注意
 上面计算的类型属性示例用于只读计算类型属性，但您也可以使用与计算实例属性相同的语法定义读写计算类型属性。
 */



// - - 查询和设置类型属性

/*
 查询类型属性并使用点语法进行设置，就像实例属性一样。
 类型属性在类里查询和设置，而不是这个类型的实例。
 */

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
    
}

/*
 注意
 在这两个检查的第一个中，didSet观察者设置currentLevel为不同的值。但是，这不会导致再次调用观察者。
 */

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)








