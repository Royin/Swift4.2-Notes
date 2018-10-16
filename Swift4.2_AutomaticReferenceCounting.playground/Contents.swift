//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
// https://www.cnswift.org/automatic-reference-counting



// ****************** 自动引用计数  ****************** //

/*
 Swift 使用自动引用计数(ARC)机制来追踪和管理你的 App 的内存。在大多数情况下，这意味着 Swift 的内存管理机制会一直起作用，你不需要自己考虑内存管理。当这些实例不在需要时，ARC会自动释放类实例所占用的内存。
 总之，在少数情况下，为了能帮助你管理内存，ARC需要更多关于你代码之间的关系信息。本章描述了这些情况并向你展示如何启用ARC来管理你 App 的内存。在 Swift 中使用 ARC 与Transitioning to ARC Release Notes(https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226) 中描述的在 Objective-C 中使用 ARC 十分相似。
 
 注意
 引用计数只应用于类的实例。结构体和枚举是值类型，不是引用类型，没有通过引用存储和传递。
 */



// - - ARC的工作机制

/*
 每创建一个类的实例，ARC会分配一大块内存来存储这个实例的信息。这些内存中保留有实例的类型信息，以及该实例所有存储属性的信息。
 
 此外，当实例不再需要时，ARC会释放该实例所占用的内存，释放的内存用于其他用途。这确保类实例当它不再需要时，不会一直占用内存。
 
 然而，如果ARC释放了正在使用的实例内存，那么它将不会访问实例的属性，或者调用实例的方法。确实，如果你试图访问该实例，你的APP很可能会崩溃。
 
 为了确保使用中的实例不会消失，ARC会跟踪计算当前实例被多少属性，常量和变量所引用。只需要存在对该类实例的引用，ARC不会释放该实例。
 
 为了使这些成为可能，无论你将实例分配给属性，常量或变量，它们都会创建该实例的强引用。之说以称之为“强”引用，是因为它将实例保持住，只要强引用还在，实例时不允许被销毁的。
 */




// - - ARC

class Person {
    let name: String
    init(name: String)  {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being  deinitialized")
    }
}

var refrence1: Person?
var refrence2: Person?
var refrence3: Person?

refrence1 = Person(name: "John Appleseed")

refrence2 = refrence1
refrence3 = refrence1 // 有了3个强引用

refrence1 = nil
refrence2 = nil

refrence3 = nil // 才会销毁



// - - 类实例之间的循环强引用

/*
 如果两个类实例彼此持有对方的强引用，因而每个实例都让对方一直存在，就会发生这种情况。这就是所谓的循环强引用。
 
 解决循环强引用问题，可以通过定义类之间的关系为弱引用(weak)或无主引用(unowned)来代替强引用。这个过程在解决类实例之间的循环强引用中有描述。
 */

class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit}
    var tenant: Person2? // 居民
    deinit { print("Apartment \(unit) is being deinitialized")}
}

var john: Person2?
var unit4A: Apartment?

john = Person2(name: "John Appleseed") // 强引用
unit4A = Apartment(unit: "4A") // 强引用

john!.apartment = unit4A
unit4A?.tenant = john    // 循环强引用

john = nil
unit4A = nil // 没有一个反初始化器被调用，循环强引用一直阻止两者释放，造成内存泄漏




// - - 解决实例之间的循环强引用

/*
 Swift提供了两种方法来解决你在使用类的属性时所遇到的循环强引用问题：弱引用(weak reference)和无主引用（unowned reference）
 
 弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
 
 对于生命周期中会变为nil的实例使用弱引用。相反，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。在实例的生命周期中，当引用可能“没有值”的时候，就使用弱引用来避免循环引用。如果引用始终有值，则可以使用无主引用来代替。（公寓不一定有居民）
 */



// - - 弱引用

/*
 弱引用不会对其引用的实例保持强引用，因而不会阻止ARC释放被引用的实例。这个特征阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
 
 由于弱引用不会强保持对实例的引用，所以说实例被释放了弱引用仍旧引用着这个实例也是有可能的。因此ARC会在被引用的实例被释放时自动设置弱引用为nil。由于弱引用需要允许它们的值为nil，它们一定是可选类型。
 
 注意：
 在ARC给弱引用设置nil时不会调用属性观察值。
 */

class Person3 {
    let name: String
    init(name: String) { self.name = name}
    var apartment: Apartment2?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment2 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person3?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john2: Person3?
var unit4A2: Apartment2?

john2 = Person3(name: "Jhon Appleseed")
unit4A2 = Apartment2(unit: "4A")

john2!.apartment = unit4A2
unit4A2!.tenant = john2   // apartment实例对person实例时若引用

john2 = nil // 会调用反初始化方法，该实例会被释放，apartment的tenant属性被设置为nil

unit4A2 = nil // apartment也被释放了

/*
 注意
 在使用垃圾回收机制的系统中，由于没有强引用的对象会在内存有压力时触发垃圾回收而被释放，弱指针有时用来实现简单的缓存机制。总之，对于 ARC 来说，一旦最后的强引用被移除，值就会被释放，这样的话弱引用就不再适合这类用法了。
 */



// - - 无主引用

/*
 和弱引用类似，无主引用不会牢牢保持住引用的实例。但是不像弱引用，总之，无主引用假定是永远有值的。因此，无主引用总是被定义为非可选类型。在声明属性或变量时，在前面加上unowned表示是一个无主引用。
 
 由于无主引用是非可选类型，不需要在使用时将它展开。无主引用总是可以直接访问。不过ARC无法在实例被释放后将无主引用社会为nil，因为非可选类型不允许被复制为nil。
 
 注意
 如果你试图在实例被释放后访问无主引用，那么你将触发运行时错误。只有在你确保引用会一直引用实例的时候才使用无主引用。
 还要注意的是，如果你试图访问引用的实例已经被释放了的无主引用，Swift 会确保程序直接崩溃。你不会因此而遭遇无法预期的行为。所以你应当避免这样的事情发生。
 
 */

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var Alice: Customer?

Alice = Customer(name: "Alice Appleseed")
Alice!.card = CreditCard(number: 1234_5678_9012_3456, customer: Alice!)
// Customer实例对CreditCard有一个强引用，CrediCard实例对Customer实例有一个无主引用

Alice = nil // 释放了Customer， 也没有指向Card的强引用，CreditCard实例随之也被释放

/*
 注意
 上边的例子展示了如何使用安全无主引用。Swift 还为你需要关闭运行时安全检查的情况提供了不安全无主引用——举例来说，性能优化的时候。对于所有的不安全操作，你要自己负责检查代码安全性。
 使用 unowned(unsafe) 来明确使用了一个不安全无主引用。如果你在实例的引用被释放后访问这个不安全无主引用，你的程序就会尝试访问这个实例曾今存在过的内存地址，这就是不安全操作。
 */




// - - 无主引用和隐式展开的可选属性

/*
 上面弱引用和无主引用例子涵盖了两种常用的需要打破循环强引用的场景。
 
 Person 和 Apartment 的例子展示了两个属性的值都允许为 nil ，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
 
 Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil ，而另一个属性的值不允许为 nil ，这也可能导致循环强引用。这种场景最好使用无主引用来解决。
 
 总之， 还有第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil 。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式展开的可选属性。
 
 一旦初始化完成，这两个属性能被直接访问(不需要可选展开)，同时避免了循环引用。这一节将为你展示如何建立这种关系。
 
 */

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, catitalName: String) {
        self.name = name
        self.capitalCity = City(name: catitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/*
 总之，如同在两段式初始化中描述的那样，只有 Country 的实例完全初始化完后， Country 的初始化器才能把 self 传给 City 的初始化器。
 为了满足这种需求，通过在类型结尾处加上感叹号（ City! ）的方式，以声明 Country 的 capitalCity 属性为一个隐式展开的可选属性。如同在隐式展开可选项中描述的那样，这意味着像其他可选项一样， capitalCity 属性有一个默认值 nil ，但是不需要展开它的值就能访问它。
 由于 capitalCity 默认值为 nil ，一旦 Country 的实例在初始化器中给 name 属性赋值后，整个初始化过程就完成了。这意味着一旦 name 属性被赋值后， Country 的初始化器就能引用并传递隐式的 self 。 Country 的初始化器在赋值 capitalCity 时，就能将 self 作为参数传递给 City 的初始化器。
 
 以上的意义在于你可以通过一条语句同时创建 Country 和 City 的实例，而不产生循环强引用，并且 capitalCity 的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
 */

var country = Country(name: "Canada", catitalName: "Ottawa")
print("\(country.name)'s capital city is callde \(country.capitalCity.name)")

/*
 例子中，使用隐式展开的可选属性的意义在于满足了两段式类初始化器的需求。 capitalCity 属性在初始化完成后，就能像非可选项一样使用和存取同时还避免了循环强引用。
 */





// = = 闭包的循环强引用

/*
 循环强引用还会出现在你把一个闭包分配给类实例属性的时候，并且这个闭包中又捕获了这个实例。捕获可能发生于这个闭包函数体中访问了实例的某个属性，比如self.someProperty，或者这个闭包调用了一个实例的方法，例如self.someMethod()。这两种情况都导致了闭包“捕获”了self，从而产生了循环强引用。
 
 循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把闭包赋值给一个属性，你实际上是把一个引用赋值给了这个闭包。实际上，这跟之前上面的问题一样的————两个强引用让彼此一直有效。总之，和两个类实例不同，这次是一个实例和一个闭包互相引用。
 
 Swift提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表(closuer capture list)。
 
 */

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)\(text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
} // 取代了属性的默认值闭包
print(heading.asHTML())
/*
 注意:
 asHTML 声明为 lazy 属性，因为只有当元素确实需要处理为 HTML 输出的字符串时，才需要使用 asHTML 。实际上 asHTML 是延迟加载属性意味着你在默认的闭包中可以使用 self ，因为只有当初始化完成以及 self 确实存在后，才能访问延迟加载属性。
 */

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

/*
 注意:
 上面的 paragraph 变量定义为可选 HTMLElement ，因此我们接下来可以赋值 nil 给它来演示循环强引用。
 
 不幸的是，上面写的 HTMLElement 类产生了类实例和 asHTML 默认值的闭包之间的循环强引用。
 实例的 asHTML 属性持有闭包的强引用。但是，闭包在其闭包体内使用了 self （引用了 self.name 和 self.text ），因此闭包捕获了 self ，这意味着闭包又反过来持有了 HTMLElement 实例的强引用。这样两个对象就产生了循环强引用。（更多关于闭包捕获值的信息，请参考值捕获）。
 
 注意
 尽管闭包多次引用了 self ，它只捕获 HTMLElement 实例的一个强引用。

 如果设置 paragraph 变量为 nil ，打破它持有的 HTMLElement 实例的强引用， HTMLElement 实例和它的闭包都不会被释放，也是因为循环强引用：
 */

paragraph = nil // HEMLElement的反初始化器的消息并没有被打印，证明该实例没有被销毁




// - - 解决闭包的循环强引用

/*
 可以通过定义捕获列表作为闭包的定义来解决在闭包和类实例之间的循环强引用。捕获列表定义了当在闭包体里捕获一个或多个引用类型的规则。正如在两个类实例之间的循环强引用，声明每个不过的引用为弱引用或无主引用而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
 
 注意
 Swift要求你在闭包中引用self成员时使用self.someProperty或者self.someMethod（而不是someProperty或someMethod）。这有助于提醒你可能会一步消息捕获了self。
 */



// - - 定义捕获列表

/*
 捕获列表中的每一项都由weak或unowned关键字与实例的引用(如self)或初始化过的变量(如delegate = self.delegate!) 成对组成。这些项卸载方括号中用逗号分开。

 把捕获列表放在形式参数和返回类型前边，如果它们存在的话：
 
 lazy var someClosure: (Int, String) -> String = {
     [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 // closure body goes here
 }
 
 
 如果闭包没有指明形式参数列表或者返回类型，是因为它们会通过上下文推断，那么就把捕获列表放在关键字 in 前边，闭包最开始的地方：
 
 lazy var someClosure: () -> String = {
     [unowned self, weak delegate = self.delegate!] in
     // closure body goes here
 }
 
 */




// - - 弱引用和无主引用

/*
 在闭包和捕获的实例总是互相引用并且总是同时释放时，将不报内的捕获定义为无主引用。
 
 相反，在被捕获的引用可能会变为 nil 时，定义一个弱引用的捕获。弱引用总是可选项，当实例的引用释放时会自动变为 nil 。这使我们可以在闭包体内检查它们是否存在。
 
 注意
 如果被捕获的引用永远不会变为 nil ，应该用无主引用而不是弱引用。
 */

class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML:() -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(self.text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

/*
 上面的 HTMLElement 实现和之前的实现一致，除了在 asHTML 闭包中多了一个捕获列表。这里，捕获列表是 [unowned self] ，表示“用无主引用而不是强引用来捕获 self ”。
 */

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
print(paragraph2!.asHTML())

/*
 闭包以无主引用的形式捕获self，并不会持有HTMLElement实例的强引用。如果将paragraph复制为nil, HTMLElement实例将会被释放，并能看到它的反初始化器打印出消息
 */

paragraph2 = nil




