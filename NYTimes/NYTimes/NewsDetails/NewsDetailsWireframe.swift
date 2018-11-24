import UIKit

class NewsDetailsWireframe {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = NewsDetailsInteractor()
        lazy var modulePresenter = NewsDetailsPresenter()
        lazy var moduleView: NewsDetailsView = {
            let storyboard = NewsDetailsWireframe.storyboard()
            let view = storyboard.instantiateViewController(withIdentifier: NewsDetailsConstants.viewIdentifier)
                return (view as? NewsDetailsView)!
        }()

        // MARK: - Computed VIPER Variables
        lazy var presenter: NewsDetailsWireframeToPresenterInterface = self.modulePresenter
        lazy var view: NewsDetailsNavigationInterface = self.moduleView

        // MARK: - Instance Variables

        // MARK: - Initialization
    init(newsFeedInfo: NewsFeedData) {
        let interactor = moduleInteractor
        let presenter = modulePresenter
        let view = moduleView

        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.wireframe = self
        view.presenter = presenter
        presenter.newsFeedInfo = newsFeedInfo
    }

    class func storyboard() -> UIStoryboard {
            return UIStoryboard(name: NewsDetailsConstants.storyboardIdentifier,
                                bundle: Bundle(for: NewsDetailsWireframe.self))
    }

        // MARK: - Operational

}

// MARK: - Module Interface
extension NewsDetailsWireframe: NewsDetails {
}

// MARK: - Presenter to Wireframe Interface
extension NewsDetailsWireframe: NewsDetailsPresenterToWireframeInterface {

}
