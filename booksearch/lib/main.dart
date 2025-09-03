import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'presentation/bloc/book_bloc.dart';
import 'presentation/pages/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Finder',
      home: BlocProvider(
        create: (_) => di.sl<BookBloc>(),
        child: const SearchPage(),
      ),
    );
  }
}
