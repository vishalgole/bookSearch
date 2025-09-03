// lib/presentation/pages/details_page.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_bloc.dart';
import '../../data/models/book_model.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';

class DetailsPage extends StatefulWidget {
  final BookModel book;

  const DetailsPage({super.key, required this.book});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // NOTE: Use the event name that exists in your bloc.
  // In this file we are using SaveBookEvent (most common).
  void _saveBook() {
    context.read<BookBloc>().add(SaveBookEvent(widget.book));
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book saved successfully ✅')),
            );
          } else if (state is BookError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: AnimatedBuilder(
                  
                  animation: _controller,
                  builder: (context, child) {
                    final angle = _controller.value * 3.14; // 0 → π (180°)
                    return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: child,
        );
                  },
                  child: book.coverUrl.isNotEmpty
                      ? Image.network(book.coverUrl, height: 240, fit: BoxFit.cover)
                      : const Icon(Icons.book, size: 200),
                ),
              ),
              const SizedBox(height: 20),
              Text(book.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('by ${book.author}', style: const TextStyle(fontSize: 18)),
              // const Spacer(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveBook,
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Save Book'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
