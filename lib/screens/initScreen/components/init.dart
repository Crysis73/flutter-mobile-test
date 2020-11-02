import 'package:flutter/material.dart';
import 'package:mobileTest/widgetView.dart';
import 'package:mobileTest/Betterflye/common.dart';
import 'package:logger/logger.dart';

class Initiative extends StatefulWidget {
  @override
  _InitiativeState createState() => _InitiativeState();
}

class _InitiativeState extends State<Initiative> {
  Logger _logger = new Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Common.bfDarkBlue,
      ),
      body: _InitiativeView(this),
    );
  }

  void sayHello() {
    _logger.d("Hello");
  }
}

class _InitiativeView extends WidgetView<Initiative, _InitiativeState> {
  _InitiativeView(_InitiativeState state) : super(state);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 50),
        children: getChildren(),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < 15; i++) widgets.add(constructMike());
    return widgets;
  }

  Widget constructMike() {
    return GestureDetector(
      onTap: () => state.sayHello(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/Mike.jpg'),
            ),
            Text("Mike"),
          ],
        ),
      ),
    );
  }
}
