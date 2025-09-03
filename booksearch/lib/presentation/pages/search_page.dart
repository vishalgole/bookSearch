import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import '../../data/models/book_model.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(GetSavedBooks());
    // Optionally, load saved books on init
    // context.read<BookBloc>().add(GetSavedBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Finder"),
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: BlocConsumer<BookBloc, BookState>(
              listener: (context, state) {
                if (state is BookError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is BookInitial) {
                  return const Center(child: Text("Search for a book..."));
                } else if (state is BookLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookLoaded) {
                  if (state.books.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      _page = 1;
                      context.read<BookBloc>().add(
                            SearchBooks(query: _controller.text, page: _page),
                          );
                    },
                    child: ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return _buildBookTile(context, book);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Search book by title",
              border: const OutlineInputBorder(),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        _page = 1;
                        // Reload saved books after clearing search
                        context.read<BookBloc>().add(GetSavedBooks());
                        setState(() {}); // rebuild to hide suffixIcon
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {}); // refresh suffixIcon visibility
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              _page = 1;
              context.read<BookBloc>().add(
                    SearchBooks(query: _controller.text, page: _page),
                  );
            }
          },
          child: const Text("Search"),
        ),
      ],
    ),
  );
}


  Widget _buildBookTile(BuildContext context, BookModel book) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.white,
      child: ListTile(
      leading: book.coverUrl.isNotEmpty
          ? Image.network(book.coverUrl, width: 80, fit: BoxFit.fill)
          : const Icon(Icons.book, size: 60),
      title: Text(book.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      subtitle: Text(book.author),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<BookBloc>(),
              child: DetailsPage(book: book),
            ),
          ),
        );
      },
    )
    );
  }
}
