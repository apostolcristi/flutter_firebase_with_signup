import 'package:flutter_firebase_with_signup/src/models/app_user.dart';
import 'package:flutter_firebase_with_signup/src/models/movie.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Movie>[]) List<Movie> movies,
    @Default(true) bool isLoading,
    @Default(1) int pageNumber,
    AppUser? user,
  }) = AppState$;
}
