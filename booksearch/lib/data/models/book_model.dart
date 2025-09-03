class BookModel {
  final String id;
  final String title;
  final String author;
  final String coverUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      coverUrl: map['coverUrl'],
    );
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['key'] ?? '',
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'No Author',
      coverUrl: json['coverUrl'] ?? 'No Cover',
    );
}
}