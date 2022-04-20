import 'package:flutter/material.dart';
import 'package:flutter_firebase_with_signup/src/actions/get_movies.dart';
import 'package:flutter_firebase_with_signup/src/actions/index.dart';
import 'package:flutter_firebase_with_signup/src/models/app_state.dart';
import 'package:flutter_firebase_with_signup/src/models/movie.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    StoreProvider.of<AppState>(context, listen: false).dispatch(GetMovies(_onResult));
  }

  void _onResult(AppAction action) {
    {
      if (action is GetMoviesSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('page loaded succesfull')));
      } else if (action is GetMoviesError) {
        final Object error = action.error;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error has occured $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies ${state.pageNumber}'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context, listen: false).dispatch(GetMovies(_onResult));
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (state.isLoading && state.movies.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Movie movie = state.movies[index];

                  return Column(
                    children: <Widget>[
                      Image.network(movie.poster),
                      Text(movie.title),
                      Text('${movie.year}'),
                      Text(movie.genres.join(', ')),
                      Text('${movie.rating}'),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
