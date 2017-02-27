//: Please build the scheme 'RxSwiftPlayground' first
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

func delay(_ seconds: TimeInterval, task: @escaping ()->() ) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: task)
}

func printPrettyBox(message: String) {
    let length = message.characters.count
    
    print("\n┌", terminator: "")
    
    for _ in 1...length + 2 {
        print("─", terminator: "")
    }
    
    print("┐\n│ \(message) │\n└", terminator: "")
    
    for _ in 1...length + 2 {
        print("─", terminator: "")
    }
    
    print("┘\n")
}

/* Stop playground execution after delay [seconds] */

delay(2) {
    printPrettyBox(message: "Playground has finished the execution.")
    PlaygroundPage.current.finishExecution()
}

let a = Variable(1)
let b = Variable(2)

let c = Observable.combineLatest(a.asObservable(), b.asObservable()) { $0 + $1 }
    .filter { $0 > 0 }
    .map { "Generated a positive sum (a+b): \($0)" }

c.subscribe(onNext: { (result) in
    print(result)
}, onError: nil, onCompleted: nil, onDisposed: nil)

a.value = 2         // It triggers an event

b.value = -5        // It doesn't trigger an event

b.value = 0         // It triggers an event
