
// https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html
// https://www.cnswift.org/deinitialization



// ************* 反初始化 Deinitialization *************** //


/*
 在类实例被释放的时候，反初始化器就会立即被调用。你可以是用 deinit 关键字来写反初始化器，就如同写初始化器要用 init 关键字一样。反初始化器只在类类型中有效。
 */



// - - 反初始化器原理

/*
 当实例不再被需要的时候 Swift会自动将其释放掉，以节省资源。如同自动引用计数中描述的那样，Swift 通过自动引用计数（ARC）来处理实例的内存管理。基本上，当你的实例被释放时，你不需要手动清除它们。总之，当你在操作自己的资源时，你可能还是需要在释放实例时执行一些额外的清理工作。比如说，如果你创建了一个自定义类来打开某文件写点数据进去，你就得在实例释放之前关闭这个文件。
 
 每个类当中只能有一个反初始化器。反初始化器不接收任何形式参数，并且不需要写圆括号：
 
 deinit {
     // perform the deinitialization
 }
 
 
 反初始化器会在实例被释放之前自动被调用。你不能自行调用反初始化器。父类的反初始化器可以被子类继承，并且子类的反初始化器实现结束之后父类的反初始化器会被调用。父类的反初始化器总会被调用，就算子类没有反初始化器。
 
 由于实例在反初始化器被调用之前都不会被释放，反初始化器可以访问实例中的所有属性并且可以基于这些属性修改自身行为（比如说查找需要被关闭的那个文件的文件名）。
 
 */



// - - 应用反初始化器

/*
 
 这里有一个应用反初始化器的栗子。这里栗子给一个简单的游戏定义了两个新的类型， Bank和 Player。 Bank类用来管理虚拟货币，它在流通过程中永远都不能拥有超过10000金币。游戏当中只能有一个 Bank，所以 Bank以具有类型属性和方法的类来实现当前状态的储存和管理：
  */
 
 class Bank {
     static var coinsInBank = 10_000
     static func distribute(coins numberOfCoinsRequested: Int) -> Int {
           let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
           coinsInBank -= numberOfCoinsToVend
           return numberOfCoinsToVend
         }
     static func receive(coins: Int) {
           coinsInBank += coins
         }
 }

/*
 Bank会一直用 CoinsInBank属性来追踪当前金币数量。它同样也提供了两个方法—— distribute(coins:)和 receive(coins:)——来处理金币的收集和分发。
 distribute(coins:)在分发金币之前检查银行当中是否有足够的金币。如果金币不足， Bank返回一个比需要的数小一些的数值（并且零如果银行里没有金币的话）。 distribute(coins:)声明了一个 numberOfCoinsToVend的变量形式参数，所以数值可以在方法体内修改而不需要再声明一个新的变量。它返回一个整数值来明确提供的金币的实际数量。
 
 receive(coins:)方法只是添加了接受的金币数量到银行的金币储存里去。
 
 Player类描述了游戏中的一个玩家。每个玩家都有确定数量的金币储存在它们的钱包中。这个以玩家的 coinsInPurse属性表示

 */

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) cooins left")

playerOne = nil
print("PlayerOne has left the game")

print("The bank now has\(Bank.coinsInBank) coins") // nil后，金币都返给银行了


