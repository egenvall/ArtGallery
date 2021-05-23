public enum EndpointError: Error {
    case invalidResponse(_: Error), decodingFailure(_: Error), invalidUrlRequest, paginationError
}
