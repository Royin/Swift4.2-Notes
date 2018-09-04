//: Playground - noun: a place where people can play

// https://www.cnswift.org/collection-types
// https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html

// ************* 集合类型 ************** //

/*
 Swift 提供了三种主要的集合类型，所谓的数组、合集还有字典，用来储存值的集合。
 数组是有序的值的集合。
 合集是唯一值的无序集合。
 字典是无序的键值对集合。
 
 Swift 中的数组、合集和字典总是明确能储存的值的类型以及它们能储存的键。
 就是说你不会意外地插入一个错误类型的值到集合中去。
 它同样意味着你可以从集合当中取回确定类型的值。
 
 注意
 Swift 的数组、集合和字典是以泛型集合实现的。要了解更多关于泛型类型和集合，参见泛型。
 */



// - - 集合的可变性

/*
 如果你创建一个数组、集合或者一个字典，并且赋值给一个变量，那么创建的集合就是可变的。
 这意味着你随后可以通过添加、移除、或者改变集合中的元素来改变（或者说异变）集合。
 
 如果你把数组、合集或者字典赋值给一个常量，则集合就成了不可变的，它的大小和内容都不能被改变。
 
 注意
 在集合不需要改变的情况下创建不可变集合是个不错的选择。这样做可以允许 Swift 编译器优化你创建的集合的性能。
 */



// - - 数组

/*
 完整写法Array<Element> Element是数组允许存入的值的类型
 简写[Element]
 更推荐简写并且全书涉及到数组类型的时候都会使用简写
 */


// - - 创建一个空数组

var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)

someInts = []
// someInts is now an empty array, but is still of type [Int]



// - - 使用默认值创建数组

/*
 Swift 的 Array类型提供了初始化器来创建确定大小且元素都设定为相同默认值的数组。
 */

var threeDouble = Array(repeating: 0.0, count: 3)
    // [0.0, 0.0, 0.0]



// - - 通过连接两个数组来创建数组

var anotherThreeDouble = Array(repeating: 2.5, count: 3)

var sixDouble = threeDouble + anotherThreeDouble



// - - 使用数组字面量创建数组

/*
  [value1, value2, value3]
 */

var shoppingList: [String] = ["Eggs", "Milk"]

/*
 注意
 数组 shoppingList被声明为变量（用 var提示符）而不是常量（用 let提示符）因为更多的元素会在下边的栗子中添加到数组当中。
 */

var shoppingList2 = ["Eggs", "Milk"]  // 自动类型推断



// - - 访问和修改数组

// .count
print("The shopping list contains \(shoppingList.count)  items.")

// .isEmpty
if shoppingList.isEmpty {
    print("The shopping is empty.")
} else {
    print("The shopping is not empty.")
}

// apend(_:)
shoppingList.append("Flour")

// +=
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

// 下标
var firstItem = shoppingList[0]

/*
 注意
 数组中的第一个元素的索引为 0，不是 1 .Swift 中的数组都是零开头的。
 */

shoppingList[0] =  "Six eggs"

shoppingList[4...6] = ["Bananas", "Apples"] // 用两个值替换三个值

/*
 注意
 你不能用下标脚本语法来追加一个新元素到数组的末尾。
 */

shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)

/*
 注意
 如果你访问或者修改一个超出数组边界索引的值，你将会触发运行时错误。你可以在使用索引前通过对比数组的 count属性来检查它。除非当 count为 0（就是说数组为空），否则最大的合法索引永远都是 count - 1，因为数组的索引从零开始。
 */

firstItem = shoppingList[0]

let apples = shoppingList.removeLast() // 移除最后一个元素



// - - 遍历一个数组

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}





// = = 结合 = = //

/*
 合集将同一类型且不重复的值无序地储存在一个集合当中。
 当元素的顺序不那么重要的时候你就可以使用合集来代替数组，或者你需要确保元素不会重复的时候。
 
 注意
 Swift 的 Set类型桥接到了基础框架的 NSSet类上。
 更多关于与基础框架和 Cocoa 一起使用 Set的信息，见与 Cocoa 和 Objective-C 一起使用 Swift（Swift 3）。
 */



// - - Set 类型的哈希值

/*
 为了能让类型储存在合集当中，它必须是可哈希的——就是说类型必须提供计算它自身哈希值的方法。
 哈希值是Int值且所有的对比起来相等的对象都相同，比如 a == b，它遵循 a.hashValue == b.hashValue。
 
 所有 Swift 的基础类型（比如 String, Int, Double, 和 Bool）默认都是可哈希的，并且可以用于合集或者字典的键。
 没有关联值的枚举成员值（如同枚举当中描述的那样）同样默认可哈希。
 */

/*
 注意
 
 你可以使用你自己自定义的类型作为合集的值类型或者字典的键类型，只要让它们遵循 Swift 基础库的 Hashable协议即可。遵循 Hashable协议的类型必须提供可获取的叫做 hashValue的 Int属性。通过 hashValue属性返回的值不需要在同一个程序的不同的执行当中或者不同程序中都相同。
 
 因为 Hashable协议遵循 Equatable，遵循的类型必须同时一个“等于”运算符 ( ==)的实现。 Equatable协议需要任何遵循 ==的实现都具有等价关系。就是说， ==的实现必须满足以下三个条件，其中 a, b, 和 c是任意值：
 
 a == a  (自反性)
 a == b 意味着 b == a  (对称性)
 a == b && b == c 意味着 a == c  (传递性)
 更多对协议的遵循信息，见协议。
 
 */



// - - 集合类型语法

/*
 Swift 的合集类型写做 Set<Element>，这里的 Element是合集要储存的类型。
 不同与数组，合集没有等价的简写。
 */



// - - 创建并初始化一个空集合

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items")

/*
 注意
 letters变量的类型被推断为 Set<Character>，基于初始化器的类型。
 */

// 另外，如果内容已经提供了类型信息，比如函数的实际参数或者已经分类的变量常量，你就可以用空的数组字面量来创建一个空合集：

letters.insert("a")
letters = []



// - - 使用数组字面量创建集合

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

/*
 注意
 合集 favoriteGenres作为变量（用 var标记）而不是常量（用 let标记）是因为元素会在下边的栗子中添加和移除。
 */

var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"] // 自动类型推断



// - - 访问和修改集合

// count
print("I have \(favoriteGenres.count) favorite misic genres.")

// isEmpty
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

// insert(_:)
favoriteGenres.insert("Jazz")

// remove(_:) removeAll()
if let removedGrenre = favoriteGenres.remove("Rock") {
    print("\(removedGrenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

// contains(_:)
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}



// - - 遍历集合

for genre in favoriteGenres {
    print("\(genre)")
}

// Swift 的 Set类型是无序的。要以特定的顺序遍历集合的值，使用 sorted()方法，它把集合的元素作为使用 < 运算符排序了的数组返回。
for genre in favoriteGenres.sorted() {
    print(genre)
}



// - - 执行合集操作

/*
 你可以高效地执行基本地合集操作，比如合并两个合集，确定两个合集共有哪个值，或者确定两个合集是否包含所有、某些或没有相同的值。
 */



// - - 基本合集操作

/*
 使用 intersection(_:)方法来创建一个只包含两个合集共有值的新合集；
 使用 symmetricDifference(_:)方法来创建一个只包含两个合集各自有的非共有值的新合集；
 使用 union(_:)方法来创建一个包含两个合集所有值的新合集；
 使用 subtracting(_:)方法来创建一个两个合集当中不包含某个合集值的新合集。
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()



// - - 集合成员关系和相等性

/*
 使用“相等”运算符 ( == )来判断两个合集是否包含有相同的值；
 使用 isSubset(of:) 方法来确定一个合集的所有值是被某合集包含；
 使用 isSuperset(of:)方法来确定一个合集是否包含某个合集的所有值；
 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:)方法来确定是个合集是否为某一个合集的子集或者超集，但并不相等；
 使用 isDisjoint(with:)方法来判断两个合集是否拥有完全不同的值。
 */

let houseAnimals: Set = ["?", "?"]
let farmAnimals: Set = ["?", "?", "?", "?", "?"]
let cityAnimals: Set = ["?", "?"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true




//  = = 字典 = =

/*
 字典储存无序的互相关联的同一类型的键和同一类型的值的集合。
 不同于数组中的元素，字典中的元素没有特定的顺序。
 */

/*
 注意
 Swift 的 Dictionary桥接到了基础框架的 NSDictionary类。
 更多关于与基础框架和 Cocoa 一起使用 Dictionary的信息，见与 Cocoa 和 Objective-C 一起使用 Swift（Swift 3）（官方链接）。
 */



// - - 字典类型简写语法

/*
 全写：Dictionary<Key, Value>
 简写：[Key: Value]
 注意
 字典的 Key类型必须遵循 Hashable协议，就像合集的值类型。
 */



// - - 创建一个空字典

var namesOfIntegers = [Int: String]() // 初始化器语法创建

namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]  // 再次变成空字典, 之前的内容已提供了字典中键值类型信息



// - - 用字典字面量创建字典

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

var aiports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] // 可推断类型



// - - 访问和修改字典

// count
print("The airports dictionary contains \(airports.count) items.")

// isEmpty
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

// 下标添加
airports["LHR"] = "London"

// 下标修改
airports["LHR"] = "London Heathrow"

/*
 updateValue(_:forKey:)方法来设置或者更新特点键的值
 updateValue(_:forKey:)方法会在键没有值的时候设置一个值，或者在键已经存在的时候更新它。
 不同于下标脚本， updateValue(_:forKey:)方法在执行更新之后返回旧的值。
 updateValue(_:forKey:)方法返回一个字典值类型的可选项值。
 */

if  let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let airportName = airports["DUB"] {
    print("The name of the airports is \(airportName)")
} else {
    print("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple International"
airports["APL"] = nil // 通过赋值nil移除一个键值对

/*
 使用 removeValue(forKey:)来从字典里移除键值对
 这个方法移除键值对如果他们存在的话，并且返回移除的值，如果值不存在则返回 nil
 */
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)。")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}



// - - 遍历字典

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)

let airportNames = [String](airports.values)

// Swift 的 Dictionary类型是无序的。要以特定的顺序遍历字典的键或值，使用键或值的 sorted()方法。




