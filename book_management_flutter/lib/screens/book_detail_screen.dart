//http://192.168.0.104:9096/books/$id
import 'package:book_management_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final String token;

  BookDetailScreen({required this.book, required this.token, required bookId});

  Future<void> _deleteBook(BuildContext context) async {
    final url = Uri.parse('http://192.168.0.104:9096/books/${book.id}');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete book')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${book.title}'),
            Text('Author: ${book.author}'),
            Text('Pages: ${book.pages.toString()}'),
            Text('Content: ${book.content}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _deleteBook(context),
              child: Text('Delete Book'),
            ),
            ElevatedButton(
              onPressed: () => _deleteBook(context),
              child: Text('Delete Book'),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed('/bookEdit',
                    arguments: {'book': book, 'token': token});
              },
            ),
          ],
        ),
      ),
    );
  }
}
