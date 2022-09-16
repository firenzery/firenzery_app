import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "Meus dados",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
