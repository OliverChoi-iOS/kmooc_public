import Foundation

class KmoocRepository: NSObject {
    /**
     * 국가평생교육진흥원_K-MOOC_강좌정보API
     * https://www.data.go.kr/data/15042355/openapi.do
     */

    private let httpClient = HttpClient(baseUrl: "http://apis.data.go.kr/B552881/kmooc")
    private let serviceKey =
        "LwG%2BoHC0C5JRfLyvNtKkR94KYuT2QYNXOT5ONKk65iVxzMXLHF7SMWcuDqKMnT%2BfSMP61nqqh6Nj7cloXRQXLA%3D%3D"

    func list(completed: @escaping (LectureList) -> Void) {
        httpClient.getJson(path: "/courseList",
                           params: ["serviceKey": serviceKey, "Mobile": 1]
        ) { result in
            if let json = try? result.get(), let data = json.data(using: .utf8) {
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonObj = jsonObj {
                    let pagination = jsonObj["pagination"] as! [String: Any]
                    let count = pagination["count"] as? Int ?? 0
                    let next = pagination["next"] as? String ?? ""
                    let numPages = pagination["num_pages"] as? Int ?? 0
                    let previous = pagination["previous"] as? String ?? ""
                    
                    let results = jsonObj["results"] as! [[String: Any]]
                    let lectures = results.map { lectureJson -> Lecture in
                        let id = lectureJson["course_id"] as? String ?? ""
                        let number = lectureJson["number"] as? String ?? ""
                        let name = lectureJson["name"] as? String ?? ""
                        let classfyName = lectureJson["classfy_name"] as? String ?? ""
                        let middleClassfyName = lectureJson["middle_classfy_name"] as? String ?? ""
                        let shortDescription = lectureJson["short_description"] as? String ?? ""
                        let orgName = lectureJson["org_name"] as? String ?? ""
                        let start = DateUtil.parseDate(lectureJson["start"] as! String)
                        let end = DateUtil.parseDate(lectureJson["end"] as! String)
                        let teachers = lectureJson["teachears"] as? String ?? ""
                        
                        
                        let media = lectureJson["media"] as! [String: Any]
                        let images = media["image"] as! [String: Any]
                        let courseImage = images["small"] as? String ?? ""
                        let courseImageLarge = images["large"] as? String ?? ""
                        
                        
                        return Lecture(id: id, number: number, name: name, classfyName: classfyName, middleClassfyName: middleClassfyName, courseImage: courseImage, courseImageLarge: courseImageLarge, shortDescription: shortDescription, orgName: orgName, start: start, end: end, teachers: teachers, overview: nil)
                    }
                    
                    completed(LectureList(count: count, numPages: numPages, previous: previous, next: next, lectures: lectures))
                } else {
                    completed(LectureList.EMPTY)
                }
            }
        }
    }

    func next(currentPage: LectureList, completed: @escaping (LectureList) -> Void) {
        let nextPageUrl = currentPage.next
        httpClient.getJson(path: nextPageUrl, params: [:]) { result in
            if let json = try? result.get(), let data = json.data(using: .utf8) {
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonObj = jsonObj {
                    let pagination = jsonObj["pagination"] as! [String: Any]
                    let count = pagination["count"] as? Int ?? 0
                    let next = pagination["next"] as? String ?? ""
                    let numPages = pagination["num_pages"] as? Int ?? 0
                    let previous = pagination["previous"] as? String ?? ""
                    
                    let results = jsonObj["results"] as! [[String: Any]]
                    let lectures = results.map { lectureJson -> Lecture in
                        let id = lectureJson["course_id"] as? String ?? ""
                        let number = lectureJson["number"] as? String ?? ""
                        let name = lectureJson["name"] as? String ?? ""
                        let classfyName = lectureJson["classfy_name"] as? String ?? ""
                        let middleClassfyName = lectureJson["middle_classfy_name"] as? String ?? ""
                        let shortDescription = lectureJson["short_description"] as? String ?? ""
                        let orgName = lectureJson["org_name"] as? String ?? ""
                        let start = DateUtil.parseDate(lectureJson["start"] as! String)
                        let end = DateUtil.parseDate(lectureJson["end"] as! String)
                        let teachers = lectureJson["teachers"] as? String ?? ""
                        
                        
                        let media = lectureJson["media"] as! [String: Any]
                        let images = media["image"] as! [String: Any]
                        let courseImage = images["small"] as? String ?? ""
                        let courseImageLarge = images["large"] as? String ?? ""
                        
                        
                        return Lecture(id: id, number: number, name: name, classfyName: classfyName, middleClassfyName: middleClassfyName, courseImage: courseImage, courseImageLarge: courseImageLarge, shortDescription: shortDescription, orgName: orgName, start: start, end: end, teachers: teachers, overview: nil)
                    }
                    
                    completed(LectureList(count: count, numPages: numPages, previous: previous, next: next, lectures: lectures))
                } else {
                    completed(LectureList.EMPTY)
                }
            } else {
                completed(LectureList.EMPTY)
            }
        }
    }

    func detail(courseId: String, completed: @escaping (Lecture) -> Void) {
        httpClient.getJson(path: "/courseDetail",
                           params: ["CourseId": courseId, "serviceKey": serviceKey]) { result in
            if let json = try? result.get(), let data = json.data(using: .utf8) {
                let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonObj = jsonObj {
                    let id = jsonObj["course_id"] as? String ?? ""
                    let number = jsonObj["number"] as? String ?? ""
                    let name = jsonObj["name"] as? String ?? ""
                    let classfyName = jsonObj["classfy_name"] as? String ?? ""
                    let middleClassfyName = jsonObj["middle_classfy_name"] as? String ?? ""
                    let shortDescription = jsonObj["short_description"] as? String ?? ""
                    let orgName = jsonObj["org_name"] as? String ?? ""
                    let start = DateUtil.parseDate(jsonObj["start"] as! String)
                    let end = DateUtil.parseDate(jsonObj["end"] as! String)
                    let teachers = jsonObj["teachers"] as? String ?? ""
                    let overview = jsonObj["overview"] as? String ?? ""
                    
                    let media = jsonObj["media"] as! [String: Any]
                    let images = media["image"] as! [String: Any]
                    let courseImage = images["small"] as? String ?? ""
                    let courseImageLarge = images["large"] as? String ?? ""
                    
                    completed(Lecture(id: id, number: number, name: name, classfyName: classfyName, middleClassfyName: middleClassfyName, courseImage: courseImage, courseImageLarge: courseImageLarge, shortDescription: shortDescription, orgName: orgName, start: start, end: end, teachers: teachers, overview: overview))
                } else {
                    completed(Lecture.EMPTY)
                }
            } else {
                completed(Lecture.EMPTY)
            }
        }
    }
}

extension KmoocRepository {
    static var shared = KmoocRepository()
}
