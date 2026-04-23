struct Cargo: Identifiable, Decodable {
    var id: Int
    var origine: String
    var destination: String
    var weight: Int
    var type: String
    var distance: Int
}