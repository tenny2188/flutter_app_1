import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/join_or_login.dart';
import 'package:flutter_application_1/screens/main_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/utils/providers.dart';
import 'package:flutter_application_1/utils/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider (
        providers: providers,
        child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
      return MaterialApp(
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return MainPage(); // 이걸 나중에 mainscreen 에 있는 tabscreen 으로 바꿀 것임.
            } else
              return ChangeNotifierProvider<JoinOrLogin>.value(
                  // 로그인 정보 주는 프로바이더
                  // 로그인 되어 있지 않으므로 value 값 가지고 AuthPage 로 감.
                  value: JoinOrLogin(),
                  child: AuthPage());
          }),
    );}
    ));
  }
}

/*class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
                // 로그인 정보 주는 프로바이더
                // 로그인 되어 있지 않으므로 value 값 가지고 AuthPage 로 감.
                value: JoinOrLogin(),
                child: AuthPage());
          } else {
            // 이미 로그인 되어 있으면 메인페이지로 email 넘김
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}
*/
