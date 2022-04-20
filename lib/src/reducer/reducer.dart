import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_with_signup/src/actions/create_user.dart';
import 'package:flutter_firebase_with_signup/src/actions/get_current_user.dart';
import 'package:flutter_firebase_with_signup/src/actions/get_movies.dart';
import 'package:flutter_firebase_with_signup/src/actions/index.dart';
import 'package:flutter_firebase_with_signup/src/actions/login.dart';
import 'package:flutter_firebase_with_signup/src/models/app_state.dart';
import 'package:flutter_firebase_with_signup/src/models/movie.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is! AppAction) {
    throw ArgumentError('All actions should implement AppAction');
  }

  //if(action is ErrorAction)

  if (kDebugMode) {
    print(action);
  }
  final AppState newState = _reducer(state, action);
  if (kDebugMode) {
    print(newState);
  }
  return newState;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesSuccessful>(_getMovieSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMovieError),
  TypedReducer<AppState, GetMovies>(_getMovie),
  TypedReducer<AppState, LoginSuccessful>(_loginSuccessful),
  TypedReducer<AppState, GetCurrentUserSuccessful>(_getCurrentUserSuccessful),
  TypedReducer<AppState, CreateUserSuccessful>(_createUserSuccessful)
]);

AppState _getMovieSuccessful(AppState state, GetMoviesSuccessful action) {
  return state
      .copyWith(movies: <Movie>[...state.movies, ...action.movies], isLoading: false, pageNumber: state.pageNumber + 1);
}

AppState _getMovieError(AppState state, GetMoviesError action) {
  return state.copyWith(isLoading: false);
}

AppState _getMovie(AppState state, GetMovies action) {
  return state.copyWith(isLoading: true);
}

AppState _loginSuccessful(AppState state, LoginSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _getCurrentUserSuccessful(AppState state, GetCurrentUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _createUserSuccessful(AppState state, CreateUserSuccessful action) {
  return state.copyWith(user: action.user);
}
