//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html
// https://www.cnswift.org/optional-chaining


// ************** 可选链 OptionalChaining ************** //

/*
 可选链是一个调用和查询可选属性、方法和下标的过程，它可能为nil。如果可选项包含值，属性、方法或者下标则调用成功；如果可选项是nil，属性、方法或者下标的调用会返回nil。多个查询可以链接在一起，如果链中任何一个节点是nil，那么整个链就会得体地失败。
 
 注意
 Swift 中的可选链与 Objective-C 中的 nil 信息类似，但是它却工作在任意类型上，而且它能检测成功还是失败。
 */



// - - 可选链代替强制展开

/*
 你希望在如果可选项为非nil的情况下调用一个属性，方法或下标，可以通过在可选值之后用一个问号(?)来指定可选链。这和在可选值后加叹号(!)来强制展开它的值非常类似。主要的区别在于可选链会在可选项为nil时得体地失败，而强制展开则在可选项为nil时触发运行时错误。
 
 可选链可以在nil值上调用，可选链的结果是一个可选值，即使最后查询的属性、方法或下标返回的是非可选值。你可以使用这个可选项返回值来检查可选链是成功（返回的可选项包含值），还是由于链中出现了nil而导致没有成功（返回的可选值是nil）。
 
 可选链的调用结果与期望的返回值类型相同，只是包装成了可选项。通常返回Int的属性通过可选链会返回一个Int?

 */

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
// 通过强制展开，触发一个运行错误，residence 默认初始化为nil

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}
/* 可选链提供另一种方式，使用？号而不是！号
   这将告诉Swift把可选 residence 属性“链接”起来并且取回numberOfRooms的值，如果residence存在的话。由于可能没有值，返回一个Int?
*/

john.residence = Residence() // 有值了

if let roomCount = john.residence?.numberOfRooms {
    print("Jhon's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}



// - - 为可选链定义模型

/*
 可以使用可选链多层级地调用属性、方法和下标。这允许你在相关类型的复杂模型中深入到紫属性，并检查是否可以在这些紫属性里方法属性、方法和下标。
 */

class Person2 {
    var residence: Residence2?
}

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}



// - - 通过可选链访问属性

/*
 如同可选链代替强制展开中展示的那样，你可以使用可选链来访问可选值里的属性，并且检查这个属性的访问是否成功。
 */

let Bob = Person2()
if let roomCount = Bob.residence?.numberOfRooms {
    print("Bob's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.") // -residence nil
}

var someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
Bob.residence?.address = someAddress  // 赋值失败，因为residence为nil

func createAddress() -> Address {
    print("Function was callde.")
    
    var someAddress = Address()
    someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

Bob.residence?.address = createAddress() // 函数并没有调用



// - - 通过可选链调用方法

/*
 调用无返回类型的方法，得到一个void?
 */

if Bob.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

/*
 任何通过可选链设置属性的尝试都会返回一个 Void? 类型值，它允许你与 nil 比较来检查属性是否设置成功：
 */
if (Bob.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}



// - - 通过可选链访问下标

/*
 你可以使用可选链来给可选项下标取回或设置值，并且检查下标的调用是否成功。
 注意
 当你通过可选链访问一个可选项的下标时，你需要把问号放在下标括号的前边，而不是后边。可选链的问号一定是紧跟在可选项表达式的后边的。
 */

if let firstRoomName = Bob.residence?[0].name { // ?号紧跟可选项后
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

Bob.residence?[0] = Room(name: "Bathroom") // 设置一个新值，但设置失败，因为residence还是nil

let bobsHouse = Residence2()
bobsHouse.rooms.append(Room(name: "Living Room"))
bobsHouse.rooms.append(Room(name: "Kitchen"))
Bob.residence = bobsHouse

if let firstRoomName = Bob.residence?[0].name {
    print("The first room name is \(firstRoomName).") // 打印了，因为有值
} else {
    print("Unable to retrieve the first room name.")
}



// - - 访问可选类型的下标

/*
 如果下标返回一个可选类型的值，放一个问号在下标的方括号后边来链接它的可选返回值
 */

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72 // 最后一个调用失败




// - - 链的多层连接

/*
 
 可以通过连接多个可选链来在模型中深入访问属性、方法以及下标。总之，多层可选链不会给返回的值添加多层的可选性。
 
 如果你访问的值不是可选项，它会因为可选链而变成可选项；
 如果你访问的值已经是可选的，它不会因为可选链而变得更加可选。
 
 如果你尝试通过可选链取回一个 Int 值，就一定会返回 Int? ，不论通过了多少层的可选链；
 类似地，如果你尝试通过可选链访问 Int? 值， Int? 一定就是返回的类型，无论通过了多少层的可选链。
 
 */

if let bobsStreet = Bob.residence?.address?.street {
    print("Bob's street name is \(bobsStreet)")
} else {
    print("Unable to retrieve the address.")
}
// address为nil 失败， 返回的值是 String?

var bobsAddress = Address()
bobsAddress.buildingName = "The Larches"
bobsAddress.street = "Laurel Street"
Bob.residence?.address = bobsAddress

if let bobsStreet = Bob.residence?.address?.street {
    print("Bob's street name is \(bobsStreet)") // 可选链都有值
} else {
    print("Unable to retrieve the address.")
}



// - - 用可选返回值链接方法

if let buildingIdentifier = Bob.residence?.address?.buildingIdentifier() {
    print("Bob's building identifier is \(buildingIdentifier).")
}

// 进一步对方法返回值进行可选链

if let beginsWithThe = Bob.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}

/*
 注意
 在上面的例子中，在方法的圆括号后面加上可选链问号，是因为链中的可选项是 buildingIdentifier() 的返回值，而不是 buildingIdentifier() 方法本身。
 */
