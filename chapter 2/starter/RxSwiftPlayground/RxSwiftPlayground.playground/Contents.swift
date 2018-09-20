import RxSwift

/* DisposeBag Example */
example(of: "DisposeBag") {
let disposeBag = DisposeBag()
let observable = Observable<Int>.from([1,2,3,4])
let subscription = observable.subscribe(
    onNext: {
        print($0)
    },
    onError: {
      print($0)
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("Disposed")
    })
    .disposed(by: disposeBag)
}

/* Example of create operator */
example(of: "create") {
    enum MyError: Error {
        case anError
    }
    let disposeBag = DisposeBag()
    let obs = Observable<String>.create { observable in
        observable.onNext("A")
        observable.onError(MyError.anError)
        observable.onCompleted()
        observable.onNext("B")
        return Disposables.create()
    }
        obs.subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") }
    )
    .disposed(by: disposeBag)
}

example(of: "Single") {
    let disposeBag = DisposeBag()

    enum CustomError: Error {
        case unusualerror
    }

    func SingleFunc(str: String) -> Single<String> {
        return Single<String>.create { single in
            let disposable = Disposables.create()
            //single(.success("It's done"))
            single(.error(CustomError.unusualerror))
            return disposable
        }
    }

    SingleFunc(str: "Hey buddy, did you finish the job?")
        .subscribe {
        switch $0 {
        case .success(let str):
            print(str)
        case .error(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)
}

example(of: "do") {
let disposeBag = DisposeBag()
let observable = Observable<Int>.of(1,2,3)
let subscription = observable
    .debug("DEBUG-PRINT", trimOutput: false)
    .do(
    onNext: {
        print($0+5)
    },
    onError: {
      print($0)
    },
    onCompleted: {
        print("Completed in do operator")
    },
    onSubscribe: {
      print("Hey subscribed")
    },
    onDispose: {
        print("Disposed in do operator")
    })
    .subscribe(
        onNext: {
            print($0)
    },
        onError: {
            print($0)
    },
        onCompleted: {
            print("Completed")
    },
    onDisposed: {
        print("Disposed")
    })
    .disposed(by: disposeBag)
}
