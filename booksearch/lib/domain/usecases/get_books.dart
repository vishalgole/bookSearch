// lib/domain/usecases/get_books.dart
import '../repositories/book_repository.dart';
import '../../data/models/book_model.dart';

class GetBooks {
  final BookRepository repository;

  GetBooks(this.repository);

  Future<List<BookModel>> call() async {
    return await repository.getSavedBooks();
  }
}
