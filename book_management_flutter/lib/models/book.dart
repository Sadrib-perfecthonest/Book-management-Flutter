class Book {
  final String id;
  final String title;
  final String author;
  final int pages;
  final String content;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.pages,
      required this.content});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      title: json['title'],
      author: json['author'],
      pages: json['pages'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'pages': pages,
      'content': content,
    };
  }
}
