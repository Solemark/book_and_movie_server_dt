import 'server.dart';

void main() => MovieServer();

class MovieServer extends Server {
  MovieServer([super.route = "localhost", super.port = 8002, super.type = Type.Movie]);
}
