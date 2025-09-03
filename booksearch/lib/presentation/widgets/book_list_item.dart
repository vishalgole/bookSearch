import 'package:booksearch/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookListItem({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.authors),
      onTap: onTap,
      leading: book.coverUrl.isNotEmpty
          ? Image.network(book.coverUrl, width: 50, fit: BoxFit.cover)
          : Container(width: 50, color: Colors.grey),
    );
  }
}