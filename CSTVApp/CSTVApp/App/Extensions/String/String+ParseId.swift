extension String {
    init(parsingId id: Int?) {
        var result = ""

        if let unwrappedId = id {
            result = String(unwrappedId)
        }

        self = result
    }
}
