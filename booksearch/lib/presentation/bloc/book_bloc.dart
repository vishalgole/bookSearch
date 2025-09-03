import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/strings/strings.dart';
import '../../domain/repositories/book_repository.dart';
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
        emit(BookError(Strings.failedToFetchBooks));
      }
    });

    on<SaveBookEvent>((event, emit) async {
      try {
        await repository.saveBook(event.book);
        final savedBooks = await repository.getSavedBooks();
        emit(BookLoaded(books: savedBooks));
      } catch (_) {
        emit(BookError(Strings.failedToSaveBook));
      }
    });

    on<GetSavedBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.getSavedBooks();
        emit(BookLoaded(books: books));
      } catch (_) {
        emit(BookError(Strings.failedToLoadSavedBooks));
      }
    });

    on<ClearBooks>((event, emit) async{
      emit(BookCleared());
      try {
        await repository.clearBooks();
        emit(BookLoaded(books: []));
      } catch (e) {
        emit(BookError(Strings.failedToClearBooks));
      }
    });
  }
}
