import Foundation
import Combine

class Player: ObservableObject {
    @Published var showFPS = false
    @Published var money: Int = 0
    
    
    // Deal with SwiftUI update problems
    //    private var anyCancellableUserViewModel: AnyCancellable? = nil
    //    private var anyCancellableWorkListViewModel: AnyCancellable? = nil
    
    init() {
        //    let workList = WorkList(works: self.db.work.getHugoWorks())
        //    userViewModel = UserViewModel(user: self.db.user.getCurrentUser(), workList: workList)
        //    workListViewModel = WorkListViewModel(workList)
        
        // Deal with SwiftUI update problems
        //        anyCancellableUserViewModel = userViewModel.objectWillChange.sink { [weak self] _ in
        //            self?.objectWillChange.send()
        //        }
        //
        //        anyCancellableWorkListViewModel = workListViewModel.objectWillChange.sink { [weak self] _ in
        //            self?.objectWillChange.send()
        //        }
    }
}

