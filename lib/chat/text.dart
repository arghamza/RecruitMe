import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'AAZZZZZZZZZZZZZZ',
          style: TextStyle(fontSize: 50.0),
        ),
      ),
    );
  }
}
