import Foundation
import Alamofire


enum MyPath: String {
    case random = "/photos/random"
    case search = "/photos/search"
    case latestImgs = "/photos"
}

enum ImageType: String {
    case raw = "raw"
    case full = "full"
    case regular = "regular"
    case small = "small"
    case thumb = "thumb"
}

class API {
    
    static var shared: API = API()
    
    
    
    func getRandomImages(image: @escaping (URL?)->()) {
        Req.shared.req(path: .random, method: .get) { data in
            image(URL(string: data?["urls"]["regular"].stringValue ?? ""))
        }
    }
    
    
    func getLatestImages(type: ImageType, page: Int = 1, perPage: Int = 10, images: @escaping ([URL]) -> Void) {
        
        let param = ["page" : page, "per_page" : perPage]
        
        Req.shared.req(path: .latestImgs, params: param, method: .get) { data in
            if let data = data {
                
                var imgs: [URL] = []
                for i in data.arrayValue {
                    if let validURL = URL(string: i["urls"][type.rawValue].stringValue) {
                        imgs.append(validURL)
                    }
                }
                images(imgs)
            } else {
                images([])
            }
        }
    }
    
    
    
}
