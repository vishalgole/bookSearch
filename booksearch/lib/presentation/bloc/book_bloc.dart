import 'package:booksearch/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecases/save_book.dart';
import 'book_event.dart';
import 'book_state.dart';


class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;

  BookBloc({required this.repository}) : super(BookInitial()) {
    on<SearchBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.searchBooks(event.query, event.page);
        emit(BookLoaded(books: books));
      } catch (_) {
        emit(BookError("Failed to fetch books"));
      }
    });

    on<SaveBookEvent>((event, emit) async {
      try {
        await repository.saveBook(event.book);
        emit(BookSaved());
      } catch (_) {
        emit(BookError("Failed to save book"));
      }
    });

    on<GetSavedBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.getSavedBooks();
        emit(BookLoaded(books: books));
      } catch (_) {
        emit(BookError("Failed to load saved books"));
      }
    });
  }
}
