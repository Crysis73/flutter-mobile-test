import 'package:flutter/material.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Common.bfDarkBlue,
      //   elevation: 0,
      // ),
      body: RegistrationForm(),
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
  PageController _controller = new PageController(
    initialPage: 0,
  );

  GlobalKey _formKey = new GlobalKey();
  int totalPages;
  @override
  Widget build(BuildContext context) => _RegistrationFormView(this);
}

class _RegistrationFormView
    extends WidgetView<RegistrationForm, _RegistrationFormState> {
  _RegistrationFormView(_RegistrationFormState state) : super(state);

  Widget build(BuildContext context) {
    Container container = new Container(
      padding: EdgeInsets.fromLTRB(32, 134, 32, 50),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(
            image: AssetImage('assets/images/Logo.png'),
          ),
          Form(
            key: state._formKey,
            child: Expanded(
              child: PageView(
                controller: state._controller,
                onPageChanged: (value) => state.handlePageChanged(value),
                pageSnapping: true,
                physics: ClampingScrollPhysics(),
                children: [
                  getButtons(),
                  getButtons(),
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () => state.handleNextButtonPressed(),
            child: Text(
              'Next',
              style: TextStyle(color: Common.bfDarkBlue, fontSize: 18),
            ),
            color: Common.bfLightBlue,
            highlightColor: Common.bfLightBlue,
          )
        ],
      ),
    );
    state.totalPages = 2;
    return container;
  }

  Container getButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onChanged: (value) => state.handleEmailChanged(value),
            decoration: InputDecoration(
              hintText: 'Enter Email',
            ),
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) => state.handlePasswordChanged(value),
            decoration: InputDecoration(
              hintText: 'Enter Password',
            ),
          ),
          TextFormField(
            obscureText: true,
            onChanged: (value) => state.handleConfirmPasswordChanged(value),
            validator: (value) => state.handlePasswordValidation(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
        ],
      ),
    );
  }
}
