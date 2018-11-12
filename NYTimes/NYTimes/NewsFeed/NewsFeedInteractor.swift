import Foundation

enum NewsPeriod:String {
    case Day = "1"
    case Week = "7"
    case Month = "30"
}

enum NewsFeedFetchError {
    case Unexpected
    case Parsing
    case BadRequest
}

class NewsFeedInteractor {
    // MARK: - VIPER Stack
    weak var presenter: NewsFeedInteractorToPresenterInterface!

    // MARK: - Instance Variables

    // MARK: - Operational

}

// MARK: - Presenter To Interactor Interface
extension NewsFeedInteractor: NewsFeedPresenterToInteractorInterface {
    func fetchNewsFeedForPeriod(period:NewsPeriod, section:String){
        guard let gitUrl = URL(string: APIsURLs.NYTimesAPIBaseURL +
            section + "/" + period.rawValue + ".json?" + APIsParamaeters.NYTimesAPIKey + "=" + APIsParamaeters.NYTimesAPIValue) else {
                self.presenter.fetchNewsFailedWithError(fetchError: .Unexpected)
                return
        }
        let request = NSMutableURLRequest(url: gitUrl)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        _ = session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {//call main thread to handle response
                    self.presenter.fetchNewsFailedWithError(fetchError: .Unexpected)
                }
                return
            }
            do {
                let newsFeedEntity = try JSONDecoder().decode(NewsFeedEntity.self, from: data)
                if let httpURLResponse = response as? HTTPURLResponse {
                    if (httpURLResponse.statusCode == 400){
                        DispatchQueue.main.async {
                            self.presenter.fetchNewsFailedWithError(fetchError: .BadRequest)
                        }
                        return
                    }
                }
                DispatchQueue.main.async {//call main thread to handle response
                    self.presenter.fetchNewsSuccess(newsFeedEntity: newsFeedEntity)
                }
            } catch let err {//This is where we catch the parsing error
                DispatchQueue.main.async { //call main thread to handle response
                    self.presenter.fetchNewsFailedWithError(fetchError: .Parsing)
                }
                print("Err", err)
            }
        }.resume()
    }
}
