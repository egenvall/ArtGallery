/**
 Representation of an url query parameter whos formatting may
 differ between APIs
 */
public enum QueryParameter {
    case page(_: Int), resultsPerPage(_: Int), searchTerm(_: String)
}
