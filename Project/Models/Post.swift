import Foundation
import Firebase
import SwiftyJSON
class Post {
    
    var user = UserProfileStruct()
    var menu: String!
    var ingredient: String!
    var method: String!
    var kindOFfood: String!
    var photoURL: String!
    var timestamp: Double!
    var numberOfLikes = 0
    var likeState = 0
    let ref: DatabaseReference!
    
//    init(user: UserProfile, menu: String, ingredient: String, method: String, kindOFfood: String, photoURL: String, timestamp: Double) {
//        self.user = user
//        self.menu = menu
//        self.ingredient = ingredient
//        self.method = method
//        self.kindOFfood = kindOFfood
//        self.photoURL = photoURL
//        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
//        self.timestamp = timestamp
//        ref = Database.database().reference().child("posts").childByAutoId()
//    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let value = snapshot.value as!  [String: Any]
        let getuser = value["User"] as! [String: Any]
        self.user.uid = getuser["uid"] as? String
        self.user.photoURL = getuser["photoURL"] as? String
        self.user.username = getuser["username"] as? String
        
        let json = JSON(snapshot.value)
        self.menu =  value["menu"] as! String
        self.ingredient =  value["ingredient"] as! String
        self.method =  value["method"] as! String
        self.kindOFfood = value["kindOFfood"] as! String
        self.photoURL = json["photoURL"].stringValue
        self.timestamp = value["timestamp"] as! Double
        self.numberOfLikes = value["numberOfLikes"] as! Int
        
        
//        let locationDict = userDict["location"] as! [String: Any]
//        self.loc.coords = locationDict["coords"] as? String
//        self.loc.name = locationDict["name"] as? String
//        self.loc.visibility = locationDict["visibility"] as? Bool
    }
    
    func getMenuName() -> String {
        return menu
    }
//
//    func getIngredient() -> String {
//        return ingredient
//    }
//
//    func getMethod() -> String {
//        return method
//    }
//
//    func getKindOFfood() -> String {
//        return kindOFfood
//    }
//
//    func getPhotoURL() -> String {
//        return photoURL
//    }
//
//    func getUser() -> UserProfileStruct {
//        return user
//    }
//
//    func getCreateAt() -> Date{
//        return createdAt
//    }
}
extension Post {
    func like() {
        numberOfLikes += 1
        ref.child("numberOfLikes").setValue(numberOfLikes)
    }
}

struct UserProfileStruct {
    var uid: String?
    var username: String?
    var photoURL: String?
}
