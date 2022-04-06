import Foundation

class KmoocListViewModel: ObservableObject {
    var repository = KmoocRepository.shared

    @Published var lectureList: LectureList = LectureList.EMPTY
    @Published var isLoading = false
    var currentPage = 1
    var isLast = false

    func lecturesCount() -> Int {
        return lectureList.lectures.count
    }

    func lecture(at index: Int) -> Lecture {
        return lectureList.lectures[index]
    }

    func list() {
        if isLoading { return }
        isLoading = true
        currentPage = 1
        isLast = false
        
        repository.list {
            self.lectureList = $0
            self.isLoading = false
            self.currentPage += 1
            self.isLast = self.currentPage > self.lectureList.numPages
        }
    }

    func next() {
        if isLoading || isLast { return }
        isLoading = true
        
        repository.next(currentPage: lectureList) {
            var lectureList = $0
            lectureList.lectures.insert(contentsOf: self.lectureList.lectures, at: 0)
            
            self.lectureList = lectureList
            self.isLoading = false
            self.currentPage += 1
            self.isLast = self.currentPage > self.lectureList.numPages
        }
    }
}
