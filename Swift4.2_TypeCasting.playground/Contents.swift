
// https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html
// https://www.cnswift.org/type-casting

import UIKit


// ************* 类型转换  TypeCasting *************** //

/*
 类型转换可以判断实例的类型，也可以将该实例在其所在的类层次中视为其父类或子类的实例。
 
 Swift 中类型转换的实现为 is 和 as 操作符。这两个操作符使用了一种简单传神的方式来检查一个值的类型或将某个值转换为另一种类型。
 
 如同协议实现的检查（此处应有链接）中描述的那样，你还可以使用类型转换来检查类型是否遵循某个协议。
 */



// - - 为类型转换定义类层次

/*
 你可以在类及其子类层次中使用类型转换来判断特定类实例的类型并且在同一类层次中将该实例类型转换为另一个类。
 */

class MediaItem { // 媒体项
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Conna Give You Up", artist: "Rick Astley")
] // 数组中的类型会被推断为父类 MediaItem



// - - 类型检查

/*
   类型检查操作符 (is)
 */

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")



// - - 向下类型转换

/*
  ( as? 或 as! )
 
 某个类类型的常量或变量可能实际上在后台引用自一个子类的实例。当你遇到这种情况时你可以尝试使用类型转换操作符（ as? 或 as! ）将它向下类型转换至其子类类型。
 
 如果你不确定你向下转换类型是否能够成功，请使用条件形式的类型转换操作符 （ as? ）。使用条件形式的类型转换操作符总是返回一个可选项，如果向下转换失败，可选值为 nil 。这允许你检查向下类型转换是否成功。
 
 当你确信向下转换类型会成功时，使用强制形式的类型转换操作符（ as! ）。当你向下转换至一个错误的类型时，强制形式的类型转换操作符会触发一个运行错误。
 
 */

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir.'\(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}

/*
 注意
 
 类型转换实际上不会改变实例及修改其值。实例不会改变；它只是将它当做要转换的类型来访问。
 */



// - - Any 和 AnyObject 的类型转换

/*
 
 Swift 为不确定的类型提供了两种特殊的类型别名：
 - AnyObject  可以表示任何类类型的实例。
 - Any  可以表示任何类型，包括函数类型。
 
 只有当你确切需要使用它们的功能和行为时再使用 Any 和 AnyObject 。在写代码时使用更加明确的类型表达总要好一些。
 
 */

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

/*
 注意
 
 Any类型表示了任意类型的值，包括可选类型。如果你给显式声明的Any类型使用可选项，Swift 就会发出警告。如果你真心需要在Any值中使用可选项，如下所示，你可以使用as运算符来显式地转换可选项为Any。
 */

let optionalNumber: Int? = 3
things.append(optionalNumber) // 警告
things.append(optionalNumber as Any) // 没有警告
