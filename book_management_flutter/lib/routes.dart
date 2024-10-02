import 'package:book_management_flutter/screens/book_add_screen.dart';
import 'package:book_management_flutter/screens/book_detail_screen.dart';
import 'package:book_management_flutter/screens/book_edit_screen.dart';
import 'package:book_management_flutter/screens/book_list_screen.dart';
import 'package:book_management_flutter/screens/login_screen.dart';
import 'package:book_management_flutter/screens/register_sceen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings, String token) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/bookList':
        return MaterialPageRoute(builder: (_) => BookListScreen());
      case '/bookEdit':
        if (args is Map<String, dynamic> &&
            args.containsKey('book') &&
            args.containsKey('bookId')) {
          return MaterialPageRoute(
            builder: (_) => BookEditScreen(token: token, book: args['book']),
          );
        }
        return _errorRoute();
      case '/bookDetail':
        if (args is Map<String, dynamic> &&
            args.containsKey('book') &&
            args.containsKey('bookId')) {
          return MaterialPageRoute(
            builder: (_) => BookDetailScreen(
                token: token, book: args['book'], bookId: args['bookId']),
          );
        }
        return _errorRoute();
      case '/bookAdd':
        return MaterialPageRoute(builder: (_) => BookAddScreen(token: token));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: Invalid route'),
        ),
      ),
    );
  }
}
