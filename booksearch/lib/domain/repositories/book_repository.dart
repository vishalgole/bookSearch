import '../../data/models/book_model.dart';

abstract class BookRepository {
  Future<List<BookModel>> searchBooks(String query, int page);
  Future<void> saveBook(BookModel book);
  Future<List<BookModel>> getSavedBooks();
}
