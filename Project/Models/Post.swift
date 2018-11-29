
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
    }
    
    func getMenuName() -> String {
        return menu
    }
    
    func getIngredient() -> String {
        return ingredient
    }
    
    func getMethod() -> String {
        return method
    }
    
//    func getCategory() -> String {
//        return category
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
