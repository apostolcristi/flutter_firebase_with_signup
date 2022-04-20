import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_with_signup/src/data/auth_api.dart';
import 'package:flutter_firebase_with_signup/src/data/movie_api.dart';
import 'package:flutter_firebase_with_signup/src/epics/add_epic.dart';
import 'package:flutter_firebase_with_signup/src/models/app_state.dart';
import 'package:flutter_firebase_with_signup/src/presentation/home.dart';
import 'package:flutter_firebase_with_signup/src/reducer/reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
  final Client client = Client();
  final MovieApi movieApi = MovieApi(client);
  final AuthApi authApi = AuthApi(auth);
  final AppEpic epic = AppEpic(movieApi, authApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epic.getEpics()),
    ],
  );

  runApp(MovieApp(store: store));
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}
