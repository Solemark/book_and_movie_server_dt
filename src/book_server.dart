import 'server.dart';

void main() => BookServer();

class BookServer extends Server {
  BookServer([super.route = "localhost", super.port = 8001, super.type = Type.Book]);
}
