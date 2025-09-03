class Strings {

  static final Strings _instance = Strings._internal();

  static const String appTitle = 'Book Search';
  static const String searchHint = 'Search for books...';
  static const String noResults = 'No results found.';
  static const String savedBooks = 'Saved Books';
  static const String save = 'Save';
  static const String remove = 'Remove';
  static const String errorOccurred = 'An error occurred. Please try again.';
  static const String searchURL = 'https://openlibrary.org/search.json';
  static const String baseURL = 'https://openlibrary.org';
  static const String unknown = 'Unknown';

  factory Strings() {
    return _instance;
  }

  Strings._internal();
}