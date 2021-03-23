import 'package:flutter/material.dart';

import 'widget/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('test title'),
        ),
        body: Body(),
      ),
    );
  }
}
