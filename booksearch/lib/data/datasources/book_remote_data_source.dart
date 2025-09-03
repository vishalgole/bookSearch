import 'package:booksearch/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks(String query, int page);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookModel>> getBooks(String query, int page) async {
    final response = await dio.get('/search.json', queryParameters: {
      'title': query,
      'page': page,
    });

    if (response.statusCode == 200) {
      final List docs = response.data['docs'] as List;
      return docs.map((e) => BookModel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw ServerException();
    }
  }
}