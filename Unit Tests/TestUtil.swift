import Foundation
@testable import Astral_One_Engine

class TestUtil {
    static func getDb() -> Db {
        Db(fullRefresh: false)
    }
    
    //    static func getGame(gameId: Int,
    //                           genders: [GenderDTO]? = nil,
    //                           hohStatuses: [HOHStatusDTO]? = nil,
    //                           languages: [LanguageDTO]? = nil,
    //                           mealTypes: [MealTypeDTO]? = nil,
    //                           paymentTypes: [PaymentTypeDTO]? = nil,
    //                           veteranStatuses: [VeteranStatusDTO]? = nil,
    //                           volRoles: [VolunteerRoleDTO]? = nil) -> AccountDTO {
    //        return Game()
    //        var testGenders = [TestUtil.getGender(genderId: 1)]
    //        if let genders = genders {
    //            testGenders = genders
    //        }
    //
    //    }
}
