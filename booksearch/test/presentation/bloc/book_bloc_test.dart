import 'package:bloc_test/bloc_test.dart';
import 'package:booksearch/core/strings/strings.dart';
import 'package:booksearch/data/models/book_model.dart';
import 'package:booksearch/domain/repositories/book_repository.dart';
import 'package:booksearch/presentation/bloc/book_bloc.dart';
import 'package:booksearch/presentation/bloc/book_event.dart';
import 'package:booksearch/presentation/bloc/book_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  late MockBookRepository mockBookRepository;
  late BookBloc bookBloc;

  final testBook = BookModel(
    id: '1',
    title: 'Test Book',
    author: 'Author',
    coverUrl: '',
  );

  setUp(() {
    mockBookRepository = MockBookRepository();
    bookBloc = BookBloc(repository: mockBookRepository);
  });

  tearDown(() {
    bookBloc.close();
  });

  group("BookBloc", () {
    // Add your tests here
    blocTest<BookBloc, BookState>(
      "emits [BookLoading, BookLoaded] when books are searched successfully",
      build: () {
        when(
          () => mockBookRepository.searchBooks("Test book", 1),
        ).thenAnswer((_) async => [testBook]);
        return bookBloc;
      },
      act: (bloc) => bloc.add(SearchBooks(query: "Test book", page: 1)),
      wait: const Duration(milliseconds: 100), 
      expect: () => [
        isA<BookLoading>(),
        isA<BookLoaded>().having((state) => state.books, 'books', [testBook]),
      ],
    );

    group("SearchBooks", () {
      blocTest<BookBloc, BookState>(
        "emits [BookLoading, BookError] when books are searched failed",
        build: () {
          when(
            () => mockBookRepository.searchBooks("Test book", 1),
          ).thenThrow(Exception("Failed to search books"));
          return bookBloc;
        },
        act: (bloc) => bloc.add(SearchBooks(query: "Test book", page: 1)),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookLoading>(),
          isA<BookError>().having(
            (state) => state.message,
            'message',
            "Failed to fetch books",
          ),
        ],
      );

      blocTest<BookBloc, BookState>(
        "emits [BookLoaded] when saved books are saved successfully",
        build: () {
          when(
            () => mockBookRepository.saveBook(testBook),
          ).thenAnswer((_) async => [testBook]);
          when(
            () => mockBookRepository.getSavedBooks(),
          ).thenAnswer((_) async => [testBook]);
          return bookBloc;
        },
        act: (bloc) => bloc.add(SaveBookEvent(testBook)),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookLoaded>().having((state) => state.books, 'books', [testBook]),
        ],
      );

      blocTest<BookBloc, BookState>(
        "emits [BookError] when saved books event failed",
        build: () {
          when(
            () => mockBookRepository.saveBook(testBook),
          ).thenThrow(Exception("Failed to save book"));
          return bookBloc;
        },
        act: (bloc) => bloc.add(SaveBookEvent(testBook)),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookError>().having(
            (state) => state.message,
            'message',
            "Failed to save book",
          ),
        ],
      );

      blocTest<BookBloc, BookState>(
        'emits [BookLoading, BookLoaded] when GetSavedBooks succeeds',
        build: () {
          when(
            () => mockBookRepository.getSavedBooks(),
          ).thenAnswer((_) async => [testBook]);
          return bookBloc;
        },
        act: (bloc) => bloc.add(GetSavedBooks()),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookLoading>(),
          isA<BookLoaded>().having((state) => state.books, 'books', [testBook]),
        ],
      );

      blocTest<BookBloc, BookState>(
        "emits [BookLoading, BookError] when GetSavedBooks event failed",
        build: () {
          when(
            () => mockBookRepository.getSavedBooks(),
          ).thenThrow(Exception("Failed to get saved books"));
          return bookBloc;
        },
        act: (bloc) => bloc.add(GetSavedBooks()),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookLoading>(),
          isA<BookError>().having(
            (state) => state.message,
            'message',
            Strings.failedToLoadSavedBooks,
          ),
        ],
      );

      blocTest(
        'emits [BookCleared, BookLoaded([])] when ClearBooks succeeds',
        build: () {
          when(
            () => mockBookRepository.clearBooks(),
          ).thenAnswer((_) async => []);
          return bookBloc;
        },
        act: (bloc) => bloc.add(ClearBooks()),
        wait: const Duration(milliseconds: 100), 
        expect: () => [
          isA<BookCleared>(),
          isA<BookLoaded>().having((state) => state.books, 'books', []),
        ],
      );

      blocTest('emits [BookCleared, BookError] when ClearBooks fails', build: () {
        when(
          () => mockBookRepository.clearBooks(),
        ).thenThrow(Exception("Failed to clear books"));
        return bookBloc;
      },
      act: (bloc) => bloc.add(ClearBooks()),
      wait: const Duration(milliseconds: 100), 
      expect: () => [
        isA<BookCleared>(),
        isA<BookError>().having(
          (state) => state.message,
          'message',
          Strings.failedToClearBooks,
        ),
      ],
      );
    });
  });
}
