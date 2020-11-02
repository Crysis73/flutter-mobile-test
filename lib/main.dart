import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'widgetView.dart';
import 'userRegistration.dart';
import 'Betterflye/common.dart';
import 'screens/initScreen/components/init.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageController createState() => _MyHomePageController();
}

class _MyHomePageController extends State<MyHomePage> {
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) => _MyHomePageView(this);

  void handleLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Initiative()),
    );
    _logger.d("Directing user to login page");
  }

  void handleSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserRegistration()),
    );
    _logger.d("Directing user to sign up page");
  }

  Future<void> handleForgotPassword() async {
    const String url =
        "http://sandbox.betterflye.me/php/APIV1/init/getInits.php";
    const String API_KEY = "MTIzNDU2Nzg5MTIzNDU2Nzg5MTIzNDU2";
    var response = await http.post(
      url,
      body: {
        'API_KEY': API_KEY,
        'searchParam': 'volunteering',
        'searchTerm': 'somethingRandom',
        'pageNo': '1'
      },
    );

    String json = response.body;
    _logger.d("$json");
    print(json);
  }
}

class _MyHomePageView extends WidgetView<MyHomePage, _MyHomePageController> {
  _MyHomePageView(_MyHomePageController state) : super(state);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  backgroundColor: Common.bfDarkBlue,
      //  elevation: 0,
      //),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 134, 32, 50),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/images/Logo.png'),
              ),
              getButtons(),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(
      //  items: [
      //    BottomNavigationBarItem(
      //      label: "Home",
      //      icon: Icon(
      //        Icons.home,
      //      ),
      //      backgroundColor: Common.bfDarkBlue,
      //    ),
      //    BottomNavigationBarItem(
      //      label: "Upgrade",
      //      icon: Icon(
      //        Icons.upgrade,
      //      ),
      //    ),
      //  ],
      //  backgroundColor: Common.bfDarkBlue,
      //),
    );
  }

  Container getButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlatButton(
            onPressed: () => state.handleLogin(),
            child: Text(
              'Login',
              style: TextStyle(
                color: Common.bfDarkBlue,
                fontSize: 24,
              ),
            ),
            color: Common.bfLightBlue,
          ),
          FlatButton(
            onPressed: () => state.handleSignUp(),
            child: Text(
              'Sign Up',
              style: TextStyle(color: Common.bfDarkBlue, fontSize: 24),
            ),
            color: Common.bfLightBlue,
            highlightColor: Common.bfLightBlue,
          ),
          FlatButton(
            onPressed: () => state.handleForgotPassword(),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Common.bfDarkBlue,
                fontSize: 18,
              ),
            ),
            color: Common.bfWhite,
          ),
        ],
      ),
    );
  }
}
