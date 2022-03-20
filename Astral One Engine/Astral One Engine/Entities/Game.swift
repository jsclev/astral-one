import Foundation
import Combine

public class Game: ObservableObject {
    @Published public var showFPS = false
    @Published public var player = Player()
    
    // Deal with SwiftUI update problems
    //    private var anyCancellableUserViewModel: AnyCancellable? = nil
    //    private var anyCancellableWorkListViewModel: AnyCancellable? = nil
    
    public init() {
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

extension ObservableObject where Self.ObjectWillChangePublisher == ObservableObjectPublisher {
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object, cancellables: inout [AnyCancellable]) {
        cancellables.append(
            vm.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
    func registerNestedObservableObject<Object: ObservableObject>(_ vm: Object, cancellable: inout AnyCancellable?) {
        cancellable = vm.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
