//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true


func printPrettyBox(message: String) {
    let length = message.characters.count
    print("\n┌", terminator: "")
    (1...length+2).forEach { _ in print("─", terminator: "") }
    print("┐", terminator: "")
    print("\n│ \(message) │", terminator: "")
    print("\n└", terminator: "")
    (1...length+2).forEach { _ in print("─", terminator: "") }
    print("┘\n")
}

delay(0) {
    printPrettyBox(message: "Playground has finished the execution.")
    PlaygroundPage.current.finishExecution()
}

func delay(_ seconds: TimeInterval, task: @escaping ()->() ) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: task)
    
}

let a = Variable(1)
let b = Variable(2)


let c = Observable.combineLatest(a.asObservable(), b.asObservable()) { $0 + $1 }
    .filter { $0 > 0 }
    .map { "\($0) is positive." }

c.subscribe(onNext: { (result) in
    print(result)
}, onError: { (error) in
    print(error)
}, onCompleted: { 
    print("Gata")
}, onDisposed: {
    print("On dispose")
})

a.value = 2

