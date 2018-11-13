import UIKit

class NewsDetailsWireframe {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = NewsDetailsInteractor()
 
        lazy var modulePresenter = NewsDetailsPresenter()
        lazy var moduleView: NewsDetailsView = {

                let sb = NewsDetailsWireframe.storyboard()
                let vc = (sb.instantiateViewController(withIdentifier: NewsDetailsConstants.viewIdentifier) as? NewsDetailsView)!
                return vc
        }()

        // MARK: - Computed VIPER Variables
        lazy var presenter: NewsDetailsWireframeToPresenterInterface = self.modulePresenter
        lazy var view: NewsDetailsNavigationInterface = self.moduleView

        // MARK: - Instance Variables

        // MARK: - Initialization
    init(newsFeedInfo:NewsFeedData) {
        let i = moduleInteractor
        let p = modulePresenter
        let v = moduleView

        i.presenter = p
        p.interactor = i
        p.view = v
        p.wireframe = self
        v.presenter = p
        p.newsFeedInfo = newsFeedInfo
    }

    class func storyboard() -> UIStoryboard {
            return UIStoryboard(name: NewsDetailsConstants.storyboardIdentifier,
                                bundle: Bundle(for: NewsDetailsWireframe.self))
    }

        // MARK: - Operational

}

// MARK: - Module Interface
extension NewsDetailsWireframe: NewsDetails {
        var delegate: NewsDetailsDelegate? {
                get {
                        return presenter.delegate
                }
                set {
                        presenter.set(delegate: newValue)
                }
        }
}

// MARK: - Presenter to Wireframe Interface
extension NewsDetailsWireframe: NewsDetailsPresenterToWireframeInterface {

}
