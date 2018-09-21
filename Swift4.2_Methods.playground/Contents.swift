//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/Methods.html
// https://www.cnswift.org/Methods


// **************** 方法 Methods **************** //

/*
 方法是与特定类型相关联的函数。
 类，结构和枚举都可以定义实例方法，这些方法封装了用于处理给定类型实例的特定任务和功能。
 类，结构和枚举也可以定义类型方法，它们与类型本身相关联。类型方法类似于Objective-C中的类方法。
 
 事实上在 结构体和枚举中定义方法是 Swift 语言与 C 语言和 Objective-C 的主要区别。
 在 Objective-C 中，类是唯一能定义方法的类型。
 但是在 Swift ，你可以选择无论类，结构体还是方法，它们都拥有强大的灵活性来在你创建的类型中定义方法。
 */



// - - 实例方法

/*
 实例方法 是属于特定类实例、结构体实例或者枚举实例的函数。
 他们为这些实例提供功能性，要么通过提供访问和修改实例属性的方法，要么通过提供与实例目的相关的功能。
 实例方法与函数的语法完全相同，就如同函数章节里描述的那样。
 
 要写一个实例方法，你需要把它放在对应类的花括号之间。
 实例方法默认可以访问同类下所有其他实例方法和属性。
 实例方法只能在类型的具体实例里被调用。它不能在独立于实例而被调用。
 */

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

/*
 如同函数实际参数标签和形式参数名中描述的那样，函数的形式参数可以同时拥有一个局部名称（用于函数体）和一个实际参数标签（用于调用函数的时候）。同样的，对于方法的形式参数来说也可以，因为方法就是与类型关联的函数。

 */



// - - self 属性

/*
 每一个类型实例都隐含一个叫做slef的属性，它完完全全与实例本身相等。
 可以使用self属性来在当前实例当中调用它自身的方法。
 */

//func increment() {
//    self.count += 1
//}

/*
 不需要经常在代码中写 self。如果你没有显式地写出 self，Swift会在你于方法中使用已知属性或者方法的时候假定你是调用了当前实例中的属性或者方法。
 
 重要例外就是当一个实例方法的形式参数名与实例中某个属性拥有相同的名字的时候。
 在这种情况下，形式参数名具有优先权，并且调用属性的时候使用更加严谨的方式就很有必要了。
 你可以使用 self属性来区分形式参数名和属性名。
 */

struct Point1 {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint1 = Point1(x: 4.0, y: 5.0)
if somePoint1.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}



// - - 在实例方法中修改值类型

/*
 结构体和枚举是值类型。默认情况下，值类型属性不能被自身的实例方法修改。
 
 总之，如果你需要在特定的方法中修改结构体或者枚举的属性，你可以选择将这个方法异变。
 然后这个方法就可以在方法中改变它的属性了，并且任何改变在方法结束的时候都会写入到原始的结构体中。
 方法同样可以指定一个全新的实例给它隐含的 self属性，并且这个新的实例将会在方法结束的时候替换掉现存的这个实例。
 */

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) { // (mutating)
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))") // (3.0, 4.0)

/*
 mutating关键字修饰moveBy(x:y:)方法，使之能够修改其属性。
 不能在结构类型的常量上调用变异方法，因为它的属性不能更改，即使它们是变量属性
 */

//let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
//// this will report an error



// - - 在异变方法里指定自身

/*
 异变方法可以指定整个实例给隐含的 self属性。
 */

struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}

/*
 枚举的异变方法可以设置隐含的 self属性为相同枚举里的不同成员：
 */

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case.high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()



// - - 类型方法

/*
 如上文描述的那样，实例方法是特定类型实例中调用的方法。
 你同样可以定义在类型本身调用的方法。
 这类方法被称作类型方法。
 
 你可以通过在 func关键字之前使用 static关键字来明确一个类型方法。类同样可以使用 class关键字来允许子类重写父类对类型方法的实现。
 
 注意
 在 Objective-C 中，你只能在 Objective-C 的类中定义类级别的方法。但是在 Swift 里，你可以在所有的类里定义类级别的方法，还有结构体和枚举。每一个类方法都能够对它自身的类范围显式生效。
 
 类型方法和实例方法一样使用点语法调用。不过，你得在类上调用类型方法，而不是这个类的实例。
 
 
 class SomeClass {
 class func someTypeMethod() {
 // type method implementation goes here
 }
 }
 SomeClass.someTypeMethod()
 
 在类型方法的主体内，隐式self属性引用类型本身，而不是该类型的实例。这意味着您可以使用self消除类型属性和类型方法参数之间的歧义，就像您对实例属性和实例方法参数一样。
 
 在类型方法的主体内，隐式self属性引用类型本身，而不是该类型的实例。这意味着您可以使用self消除类型属性和类型方法参数之间的歧义，就像您对实例属性和实例方法参数一样。
 
 更一般地，您在类型方法的主体中使用的任何非限定方法和属性名称将引用其他类型级别的方法和属性。类型方法可以使用另一个方法的名称调用另一个类型方法，而无需使用类型名称作为前缀。类似地，结构和枚举上的类型方法可以通过使用不带类型名称前缀的type属性的名称来访问类型属性。
 
 */

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

/*
 该LevelTracker结构跟踪任何玩家解锁的最高级别。此值存储在名为的类型属性中highestUnlockedLevel。
 
 LevelTracker还定义了两个类型函数来处理highestUnlockedLevel属性。第一个是调用的类型函数unlock(_:)，它会更新highestUnlockedLevel解锁新级别时的值。第二个是调用的便捷类型函数isUnlocked(_:)，true如果已经解锁了特定的级别编号，则返回该函数。（请注意，这些类型方法可以访问highestUnlockedLeveltype属性而无需将其写为LevelTracker.highestUnlockedLevel。）
 
 除了类型属性和类型方法之外，还可以LevelTracker跟踪单个玩家在游戏中的进度。它使用一个名为的实例属性currentLevel来跟踪玩家当前正在玩的等级。
 
 要帮助管理currentLevel属性，请LevelTracker定义一个名为的实例方法advance(to:)。在更新之前currentLevel，此方法检查所请求的新级别是否已解锁。该advance(to:)方法返回一个布尔值，以指示它是否实际上能够设置currentLevel。因为调用advance(to:)方法忽略返回值的代码不一定是错误，所以此函数用@discardableResult属性标记。有关此属性的更多信息，请参阅属性。
 */


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

/*
 在Player类创建的新实例LevelTracker来跟踪玩家的进展。它还提供了一个名为的方法complete(level:)，只要玩家完成特定级别就会调用该方法。此方法为所有玩家解锁下一关，并更新玩家的进度以将其移至下一关。（advance(to:)忽略布尔返回值，因为已知通过LevelTracker.unlock(_:)上一行的调用解锁了该级别。）
 */

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// Prints "level 6 has not yet been unlocked"











