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
  static const String title = 'Book Finder';
  static const String bookSavedSuccess = 'Book saved successfully ✅';
  static const String saveBookTitle = 'Save Book';
  static const String failedToFetchBooks = 'Failed to fetch books';
  static const String failedToSaveBook = 'Failed to save book';
  static const String failedToLoadSavedBooks = 'Failed to load saved books';
  static const String noTitle = 'No Title';
  static const String unknownAuthor = 'Unknown Author';
  static const String failedToClearBooks = 'Failed to clear books';

  factory Strings() {
    return _instance;
  }

  Strings._internal();
}