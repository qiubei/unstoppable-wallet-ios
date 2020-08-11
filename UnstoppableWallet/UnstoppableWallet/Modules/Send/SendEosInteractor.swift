import RxSwift

class SendEosInteractor {
    private let adapter: ISendEosAdapter

    init(adapter: ISendEosAdapter) {
        self.adapter = adapter
    }

}

extension SendEosInteractor: ISendEosInteractor {

    var availableBalance: Decimal {
        adapter.availableBalance
    }

    func validate(account: String) throws {
        try adapter.validate(account: account)
    }

    func sendSingle(amount: Decimal, account: String, memo: String?) -> Single<Void> {
        adapter.sendSingle(amount: amount, account: account, memo: memo)
    }

}
