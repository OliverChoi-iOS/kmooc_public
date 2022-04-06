import Foundation

class KmoocDetailViewModel: ObservableObject {
    var repository = KmoocRepository.shared

    @Published var lecture = Lecture.EMPTY
    @Published var isLoading = false
    
    var lectureId: String = ""

    func detail(onLoad: @escaping () -> Void) {
        isLoading = true
        repository.detail(courseId: lectureId) { lecture in
            self.lecture = lecture
            self.isLoading = false
            onLoad()
        }
    }
}
