import 'package:booksearch/data/models/book_model.dart';

import '../entities/book.dart';
import '../repositories/book_repository.dart';

class SaveBook {
  final BookRepository repository;
  final Book book;

  SaveBook(this.repository, this.book);

  Future<void> call(Book book) async {
    await repository.saveBook(book as BookModel);
  }
}