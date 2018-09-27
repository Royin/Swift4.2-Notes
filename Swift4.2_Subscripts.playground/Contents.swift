//: Playground - noun: a place where people can play

// https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html
// https://www.cnswift.org/subscripts

// ****************** 下标 subscripts **************//


// = =  下标 = = //

/*
 类、结构体、枚举可以定义下标，下标是访问集合、列表或序列中元素的快捷方式。
 可以使用下标索引，设置和获取值，而不需要再调用对应的存取方法。
 someArray[index]  someDictionary[key]
 
 一个类型可以定义多个下标，通过不同索引类型进行重载。
 下标不限于单个唯独，可以定义多个输入参数的下标满足自定义类型的需求。
 
 */



// - - 下标语法

/*
 下标使得可以在实例名称后面的方括号中写入一个或多个值来查询类型的实例。
 它的语法类似于实例方法和计算属性。
 使用关键字 subscript 来定义下标，并且指定一个或多个输入形式参数和返回类型，与实例方法一样。
 与实例方法不同的是，下标可以是读写也可以是只读的。这个行为通过与计算属性中相同的 getter 和 setter 传达：
 
 subscript(index: Int) -> Int {
     get {
         // return an appropriate subscript value here
     }
     set(newValue) {
         // perform a suitable setting action here
     }
 }
 
 与只读计算属性一样， 你可以给只读下标省略 gte 关键字
 subript(index: Int) -> Int {
     // 返回一个属性下标值
 }
 
 */

struct TimeTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTalbe = TimeTable(multiplier: 3)
print("six times three is \(threeTimesTalbe[6])")

/*
 注意
 n倍表是基于固定的数学公式。并不适合对 threeTimesTable[someIndex] 进行赋值操作，所以 TimesTable 的下标定义为只读下标。
 */



// - - 下标用法

/*
 “下标”确切的意思取决于它使用的上下文。通常下标是用来访问集合、列表或序列中元素的快捷方式。你可以在你自己特定的类或结构体中自由实现下标来提供合适的功能。
 
 例如，Swift 的 Dictionary 类型实现了下标来对 Dictionary 实例中存放的值进行设置和读取操作。你可以在下标的方括号中通过提供字典键类型相同的键来设置字典里的值，并且把一个与字典值类型相同的值赋给这个下标：
 */

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/*
 注意
 Swift 的 Dictionary 类型实现它的下标为接收和返回可选类型的下标。对于上例中的 numberOfLegs 字典，键值下标接收和返回一个 Int? 类型的值，或者说“可选的 Int  ”。 Dictionary 类型使用可选的下标类型来建模不是所有键都会有值的事实，并且提供了一种通过给键赋值为 nil 来删除对应键的值的方法。
 */



// - - 下标选项

/*
 下标可以接收任意数量的输入形式参数，并且这些输入形式参数可以是任意类型。下标也可以返回任意类型。
 标可以使用变量形式参数和可变形式参数，但是不能使用输入输出形式参数或提供默认形式参数值。
 
 类或结构体可以根据自身需要提供多个下标实现，合适被使用的下标会基于值类型或者使用下标时下标方括号里包含的值来推断。这个对多下标的定义就是所谓的下标重载。
 */

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

let someValue = matrix[2, 2]











