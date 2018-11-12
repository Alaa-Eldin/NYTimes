import UIKit

class NewsFeedWireframe {
        // MARK: - VIPER Stack
        lazy var moduleInteractor = NewsFeedInteractor()
        // Uncomment to use a navigationController from storyboard
    
        lazy var moduleNavigationController: UINavigationController = {
                let sb = NewsFeedWireframe.storyboard()
                let nc = (sb.instantiateViewController(withIdentifier: NewsFeedConstants.navigationControllerIdentifier) as? UINavigationController)!
                return nc
        }()
        
        lazy var modulePresenter = NewsFeedPresenter()
        lazy var moduleView: NewsFeedView = {
                // Uncomment the commented line below and delete the storyboard
                //      instantiation to use a navigationController from storyboard
                let vc = self.moduleNavigationController.viewControllers[0] as! NewsFeedView
                return vc
        }()

        // MARK: - Computed VIPER Variables
        lazy var presenter: NewsFeedWireframeToPresenterInterface = self.modulePresenter
        lazy var view: NewsFeedNavigationInterface = self.moduleView

        // MARK: - Instance Variables

        // MARK: - Initialization
        init() {
                let i = moduleInteractor
                let p = modulePresenter
                let v = moduleView

                i.presenter = p

                p.interactor = i
                p.view = v
                p.wireframe = self

                v.presenter = p
        }

    	class func storyboard() -> UIStoryboard {
                return UIStoryboard(name: NewsFeedConstants.storyboardIdentifier,
                                    bundle: Bundle(for: NewsFeedWireframe.self))
    	}

        // MARK: - Operational

}

// MARK: - Module Interface
extension NewsFeedWireframe: NewsFeed {
        var delegate: NewsFeedDelegate? {
                get {
                        return presenter.delegate
                }
                set {
                        presenter.set(delegate: newValue)
                }
        }
}

// MARK: - Presenter to Wireframe Interface
extension NewsFeedWireframe: NewsFeedPresenterToWireframeInterface {

}
