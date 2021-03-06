//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

enum CustomError: Error {
    case someError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) -> Void {
    print(label, (event.element ?? event.error) ?? event)
}

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()

    subject
        .subscribe(onNext: { string in
            print(string)
    })
    subject.onNext("Is anyone listening?")
}

example(of: "ReplaySubject") {
    let disposeBag = DisposeBag()
    let repSubject = ReplaySubject<String>.create(bufferSize: 2)
    repSubject.onNext("first call")
    repSubject.onNext("second call")
    repSubject.onNext("third call")
    repSubject.subscribe{
        print(label: "subsc 1", event: $0)
//        onNext: {
//            print("1 subsc", $0)
//        }
    }
    .disposed(by: disposeBag)
    
    repSubject.onNext("fourth call")
    
    repSubject.subscribe {
        print(label: "subsc 2", event: $0)
//        onNext: {
//            print("2 subs", $0)
//        }
        }
        .disposed(by: disposeBag)
    
    repSubject.onNext("4th copy call")
    repSubject.onNext("fifth call")
    repSubject.onNext("sixth call")
    repSubject.onError(CustomError.someError)
    repSubject.onCompleted()
    
    repSubject.subscribe (
//        print(label: "subsc 3", event: $0)
        onNext: {
            print("subsc 3", $0)
    },
        onDisposed: {
            print("observable completed")
        }
      )
        .disposed(by: disposeBag)
}

/*:
 Copyright (c) 2014-2017 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
