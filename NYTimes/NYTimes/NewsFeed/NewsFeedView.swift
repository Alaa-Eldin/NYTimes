import UIKit

class NewsFeedView: UIViewController {
    // MARK: - VIPER Stack
    weak var presenter: NewsFeedViewToPresenterInterface!

    // MARK: - Instance Variables
    var newsFeedsData = [NewsFeedData]()
    
    // MARK: - Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: - Operational
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalViewSetup()
        presenter.viewDidLoad()
    }
    
    func additionalViewSetup(){
        newsTableView.isHidden = true
    }
}

// MARK: - Navigation Interface
extension NewsFeedView: NewsFeedNavigationInterface { }

// MARK: - Presenter to View Interface
extension NewsFeedView: NewsFeedPresenterToViewInterface {
    func showMostPopularNews(_newsFeedData:[NewsFeedData]){
        newsFeedsData = _newsFeedData
        newsTableView.isHidden = false
        newsTableView.reloadData()
    }
}

extension NewsFeedView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedConstants.newsFeedCellID, for: indexPath) as! NewsFeedCell
        
        let newsFeedInfo = newsFeedsData[indexPath.row]
        cell.newsTitleLabel.text = newsFeedInfo.title
        cell.newsDescriptionLabel.text = newsFeedInfo.abstract
        cell.newsImageView.tag = indexPath.row
    
        if let thumnailURL = newsFeedInfo.thumbnailURL {
            cell.newsImageView.loadImageUsingCache(withUrl: thumnailURL, cellIndexPathRow: indexPath.row)
        }
        else{
            cell.newsImageView.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedsData.count
    }
}
