import 'package:bloc_test/bloc_test.dart';
import 'package:booksearch/data/models/book_model.dart';
import 'package:booksearch/presentation/bloc/book_bloc.dart';
import 'package:booksearch/presentation/bloc/book_event.dart';
import 'package:booksearch/presentation/bloc/book_state.dart';
import 'package:booksearch/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';


/// Mock Bloc
class MockBookBloc extends Mock implements BookBloc {}

/// Fake events & states so mocktail can register them
class FakeBookEvent extends Fake implements BookEvent {}
class FakeBookState extends Fake implements BookState {}

void main() {
  late MockBookBloc mockBookBloc;

  setUpAll(() {
    registerFallbackValue(FakeBookEvent());
    registerFallbackValue(FakeBookState());
  });

  setUp(() {
    mockBookBloc = MockBookBloc();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<BookBloc>.value(
        value: mockBookBloc,
        child: child,
      ),
    );
  }

  group('SearchPage Widget Tests', () {
    testWidgets('renders saved books when state is BookLoaded', (tester) async {
  // Arrange
  final books = [
    BookModel(
      id: '1',
      title: 'Flutter in Action',
      author: 'Eric Windmill',
      coverUrl: 'https://via.placeholder.com/150',
    )
  ];

  when(() => mockBookBloc.state).thenReturn(BookLoaded(books: books));
  whenListen(
    mockBookBloc,
    Stream<BookState>.fromIterable([BookLoaded(books: books)]),
  );

  // Act
  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(makeTestableWidget(const SearchPage()));
    await tester.pumpAndSettle();
  });

  // Assert
  expect(find.text('Flutter in Action'), findsOneWidget);
  expect(find.text('Eric Windmill'), findsOneWidget);
});

    testWidgets('triggers SearchBooks event when Search button pressed', (tester) async {
      when(() => mockBookBloc.state).thenReturn(BookInitial());
      whenListen(
        mockBookBloc,
        Stream<BookState>.fromIterable([BookInitial()]),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));
      await tester.pumpAndSettle();

      // Enter search text
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.tap(find.text('Search'));
      await tester.pump();

      // Verify event added
      verify(() => mockBookBloc.add(any(that: isA<SearchBooks>()))).called(1);
    });

    testWidgets('shows shimmer when loading state isFirstFetch=true', (tester) async {
      when(() => mockBookBloc.state).thenReturn(BookLoading());
      whenListen(
        mockBookBloc,
        Stream<BookState>.fromIterable([BookLoading()]),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));
      await tester.pump();

      // Expect shimmer widget exists
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('shows error message when state is BookError', (tester) async {
      when(() => mockBookBloc.state).thenReturn(BookError('Something went wrong'));
      whenListen(
        mockBookBloc,
        Stream<BookState>.fromIterable([BookError('Something went wrong')]),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));
      await tester.pump();

      expect(find.text('Something went wrong'), findsWidgets);
    });
  });
}
