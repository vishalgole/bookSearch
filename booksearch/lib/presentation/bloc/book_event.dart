
import '../../data/models/book_model.dart';

abstract class BookEvent {}

class SearchBooks extends BookEvent {
  final String query;
  final int page;
  SearchBooks({required this.query, required this.page});
}

class SaveBookEvent extends BookEvent {
  final BookModel book;
  SaveBookEvent(this.book);
}

class GetSavedBooks extends BookEvent {}

class ClearBooks extends BookEvent {}
