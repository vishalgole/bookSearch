import 'package:dio/dio.dart';

import '../../core/strings/strings.dart';
import '../datasources/book_local_data_source.dart';
import '../models/book_model.dart';
import '../../domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final Dio dio;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({required this.dio, required this.localDataSource});

  @override
  Future<List<BookModel>> searchBooks(String query, int page) async {
    final response = await dio.get(
      Strings.searchURL,
      queryParameters: {"q": query, "page": page},
    );

    final List docs = response.data['docs'];
    return docs.map((doc) {
      return BookModel(
        id: doc['key'] ?? '',
        title: doc['title'] ?? Strings.unknown,
        author: (doc['author_name'] != null && doc['author_name'].isNotEmpty)
            ? doc['author_name'][0]
            : Strings.unknown,
        coverUrl: doc['cover_i'] != null
            ? "https://covers.openlibrary.org/b/id/${doc['cover_i']}-M.jpg"
            : '',
      );
    }).toList();
  }

  @override
  Future<void> saveBook(BookModel book) async {
    await localDataSource.saveBook(book);
  }

  @override
  Future<List<BookModel>> getSavedBooks() async {
    return await localDataSource.getSavedBooks();
  }

@override
Future<void> clearBooks() async {
  await localDataSource.clearBooks();
}
}