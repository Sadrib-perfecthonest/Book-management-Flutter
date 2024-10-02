//'http://192.168.0.104:9096/books/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> _books = [];
  String? _token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _token = ModalRoute.of(context)!.settings.arguments as String?;
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://192.168.0.104:9096/books/'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      setState(() {
        _books = List<Book>.from(l.map((model) => Book.fromJson(model)));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load books')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/bookAdd', arguments: _token)
                  .then((_) => _fetchBooks());
            },
          ),
        ],
      ),
      body: _books.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.of(context).pushNamed('/bookDetail', arguments: {
                      'book': book,
                      'token': _token,
                    });
                  },
                );
              },
            ),
    );
  }
}
