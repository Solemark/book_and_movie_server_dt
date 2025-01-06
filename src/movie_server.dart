import 'server.dart';

void main() => MovieServer();

class MovieServer extends Server {
  MovieServer([super.port = 8002, super.route = "127.0.0.1", super.type = "Movie"]) {
    super.start();
  }
}
