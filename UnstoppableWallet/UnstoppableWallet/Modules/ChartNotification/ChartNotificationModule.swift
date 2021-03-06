protocol IChartNotificationView: AnyObject {
    func set(spacerMode: NotificationSettingPresentMode)
    func set(titleViewModel: PriceAlertTitleViewModel)
    func set(sectionViewModels: [PriceAlertSectionViewModel])

    func showWarning()
    func hideWarning()
    func showError(error: Error)
}

protocol IChartNotificationViewDelegate {
    func viewDidLoad()
    func didTapSettingsButton()
}

protocol IChartNotificationInteractor {
    func priceAlert(coin: Coin) -> PriceAlert
    func requestPermission()
    func save(priceAlert: PriceAlert)
}

protocol IChartNotificationInteractorDelegate: AnyObject {
    func didGrantPermission()
    func didDenyPermission()
    func didEnterForeground()
    func didFailSaveAlerts(error: Error)
}

protocol IChartNotificationRouter {
    func openSettings()
}

protocol IChartNotificationViewModelFactory {
    func titleViewModel(coin: Coin) -> PriceAlertTitleViewModel
    func sections(alert: PriceAlert, priceChangeUpdate: @escaping (Int) -> (), trendUpdate: @escaping (Int) -> ()) -> [PriceAlertSectionViewModel]
}
