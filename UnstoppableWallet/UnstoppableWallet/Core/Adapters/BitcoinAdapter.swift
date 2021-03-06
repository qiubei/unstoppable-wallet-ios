import BitcoinKit
import BitcoinCore
import RxSwift

class BitcoinAdapter: BitcoinBaseAdapter {
    private let bitcoinKit: BitcoinKit

    init(wallet: Wallet, syncMode: SyncMode?, derivation: MnemonicDerivation?, testMode: Bool) throws {
        guard case let .mnemonic(words, _) = wallet.account.type else {
            throw AdapterError.unsupportedAccount
        }

        guard let walletDerivation = derivation else {
            throw AdapterError.wrongParameters
        }

        guard let walletSyncMode = syncMode else {
            throw AdapterError.wrongParameters
        }

        let networkType: BitcoinKit.NetworkType = testMode ? .testNet : .mainNet
        let bip = BitcoinBaseAdapter.bip(from: walletDerivation)
        let syncMode = BitcoinBaseAdapter.kitMode(from: walletSyncMode)
        let logger = App.shared.logger.scoped(with: "BitcoinKit")

        bitcoinKit = try BitcoinKit(withWords: words, bip: bip, walletId: wallet.account.id, syncMode: syncMode, networkType: networkType, confirmationsThreshold: BitcoinBaseAdapter.defaultConfirmationsThreshold, logger: logger)

        super.init(abstractKit: bitcoinKit)

        bitcoinKit.delegate = self
    }

}

extension BitcoinAdapter: ISendBitcoinAdapter {
}

extension BitcoinAdapter {

    static func clear(except excludedWalletIds: [String]) throws {
        try BitcoinKit.clear(exceptFor: excludedWalletIds)
    }

}
