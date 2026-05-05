import Foundation
import SwiftUI
//
//// The date object allows to use and manipulate the date in several ways, when you initialize this object it creates the date of the current moment and time DEPENDING ON THE USER TIMEZONE, calendar, etc
//
//// Create the current date
//let now = Date()
//
//// Create date from specific calendar date and time components
//var components = DateComponents()
//components.year = 2023
//components.month = 11
//components.day = 1
//components.hour = 9
//components.minute = 0
//components.second = 0
//let calendar = Calendar.current
//let date = calendar.date(from: components)
//
//// This is a class to formate the Date data into a more readable way
//let dateFormatter = DateFormatter()
//dateFormatter.dateStyle = .medium
//dateFormatter.timeStyle = .medium
//
//// Extracting Components from Dates
//let year = calendar.component(.year, from: date ?? Date())
//print(year) // it will print the year of the date
//
//
//let unixTimestamp: TimeInterval = 1678886400 // Example: March 15, 2023 12:00:00 AM UTC
//
//// Convert to a Date object
//let daate = Date(timeIntervalSince1970: unixTimestamp)
//print(date as Any) // Output will be in UTC by default, e.g., "2023-03-15 00:00:00 +0000"
//
//let fixed = 10000
//print()
print("Image url get called")

let imageTask = Task { () -> UIImage? in
    print("url request")
    let imageURL = URL(string: "https://httpbin.org/image")!
    var imageRequest = URLRequest(url: imageURL)
    imageRequest.allHTTPHeaderFields = ["accept": "image/jpeg"]

    /// Throw an error if the task was already cancelled.
    imageTask.isCancelled
    print("Starting network request...")
    let (imageData, _) = try await URLSession.shared.data(for: imageRequest)
    return UIImage(data: imageData)
}
// Cancel the image request right away:
let executor = TaskExecutor(Button("", action: {
    <#code#>
}))

Task(executorPreference: executor) {
    
}
