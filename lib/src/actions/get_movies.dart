import 'package:flutter_firebase_with_signup/src/actions/index.dart';
import 'package:flutter_firebase_with_signup/src/models/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_movies.freezed.dart';

@freezed
class GetMovies with _$GetMovies implements AppAction {
  const factory GetMovies(ActionResult onResult) = GetMoviesStart;

  const factory GetMovies.successful(List<Movie> movies) = GetMoviesSuccessful;

  @Implements<ErrorAction>()
  const factory GetMovies.error(Object error, StackTrace stackTrace) = GetMoviesError;
}
