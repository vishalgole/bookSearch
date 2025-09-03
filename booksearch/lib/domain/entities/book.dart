import 'package:equatable/equatable.dart';

import '../../core/strings/strings.dart';

class Book extends Equatable {
  final String title;
  final String authors;
  final String coverUrl;

  const Book({
    required this.title,
    required this.authors,
    required this.coverUrl,
  });

  @override
  List<Object?> get props => [title, authors, coverUrl];

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? Strings.noTitle,
      authors: (json['volumeInfo']['authors'] as List<dynamic>?)
              ?.join(', ') ??
          Strings.unknownAuthor,
      coverUrl: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'authors': authors,
      'coverUrl': coverUrl,
    };
  }
}