import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgetView.dart';
import 'Betterflye/common.dart';
import 'package:logger/logger.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  @override
  Widget build(BuildContext context) => _UserRegistrationView(this);
}

class _UserRegistrationView
    extends WidgetView<UserRegistration, _UserRegistrationState> {
  _UserRegistrationView(_UserRegistrationState state) : super(state);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Common.bfDarkBlue,
        elevation: 0,
      ),
      body: RegistrationForm(),
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
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  Logger _logger = new Logger();
  Map<String, String> values;

  GlobalKey _formKey = new GlobalKey();
  int totalPages;
  int currentPage = 0;

  PageController controller = new PageController(
    keepPage: false,
    initialPage: 0,
  );
  PageStorageKey pageKey = new PageStorageKey("registrationFormPageKey");
  @override
  Widget build(BuildContext context) => _RegistrationFormView(this);

  void handlePageChanged(int page) {
    _logger.d("Page changed to $page");
    _logger.d("OnLastPage: ${page == totalPages}");
    setState(() {
      currentPage = page;
    });
    return;
  }

  String validateName(String value) {
    _logger.d("Validating $value");
    if (value.isEmpty) {
      return "Your name cannot be empty!";
    }
    if (value.length > 10) {
      return "Your name cannot be more than 10 characters";
    }
    RegExp validationRegEx = new RegExp(r"^[a-zA-Z]+$");
    if (!(validationRegEx.hasMatch(value))) {
      validationRegEx.allMatches(value).forEach(
        (element) {
          _logger.d(element.toString());
        },
      );
      return "Your name must consist of only alphabetic characters.";
    }
    return null;
  }
}

class _RegistrationFormView
    extends WidgetView<RegistrationForm, _RegistrationFormState> {
  _RegistrationFormView(_RegistrationFormState state) : super(state);

  Widget build(BuildContext context) {
    Container container = new Container(
      padding: EdgeInsets.fromLTRB(32, 134, 32, 25),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(
            image: AssetImage('assets/images/Logo.png'),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Form(
            key: state._formKey,
            child: Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getRegistrationPageView(),
                ],
              ),
            ),
          ),
          pageIndicatorRow(),
          //FlatButton(
          //  onPressed: () => {},
          //  child: Text(
          //    'Next',
          //    style: TextStyle(color: Common.bfDarkBlue, fontSize: 18),
          //  ),
          //  color: Common.bfLightBlue,
          //  highlightColor: Common.bfLightBlue,
          //)
        ],
      ),
    );
    state.totalPages = getRegistrationPages().length - 1;
    return container;
  }

  Widget pageIndicatorRow() {
    bool isActive;
    int totalPages = getRegistrationPages().length;
    List<Widget> children = new List<Widget>(totalPages);
    for (int i = 0; i < totalPages; i++) {
      isActive = ((state.currentPage ?? 0) == i);
      state._logger.d(state.currentPage, i);
      children[i] = circleBar(isActive);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Common.bfLightBlue : Common.bfDarkBlue,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  PageView getRegistrationPageView() {
    return new PageView(
      controller: state.controller,
      onPageChanged: (value) => state.handlePageChanged(value),
      pageSnapping: true,
      physics: ClampingScrollPhysics(),
      children: getRegistrationPages(),
      key: state.pageKey,
      allowImplicitScrolling: true,
    );
  }

  List<Widget> getRegistrationPages() {
    List<Widget> registrationPages = new List<Widget>();
    registrationPages.add(getNameAndUserNamePage());
    registrationPages.add(getEmailAndPasswordPage());
    return registrationPages;
  }

  Container getEmailAndPasswordPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onChanged: (value) => {},
            decoration: InputDecoration(
              hintText: 'Enter Email',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.email),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            obscureText: true,
            onChanged: (value) => {},
            decoration: InputDecoration(
              hintText: 'Enter Password',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.lock_outline_rounded),
            ),
            style: TextStyle(),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            obscureText: true,
            onChanged: (value) => {},
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.lock_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Container getNameAndUserNamePage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            maxLength: 20,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: (value) => {},
            validator: (value) => state.validateName(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'First Name',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.perm_identity),
              labelText: 'First Name',
              errorMaxLines: 3,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            onChanged: (value) => {},
            validator: (value) => state.validateName(value),
            decoration: InputDecoration(
              hintText: 'Last Name',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.perm_identity),
              labelText: 'Last Name',
            ),
            style: TextStyle(),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            onChanged: (value) => {},
            decoration: InputDecoration(
              hintText: 'mm/dd/yyyy',
              fillColor: Colors.white,
              filled: true,
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              icon: Icon(Icons.perm_identity),
              labelText: 'Date of Birth',
            ),
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
