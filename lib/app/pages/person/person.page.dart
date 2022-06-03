import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/person/person.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonPage extends StatefulWidget {
  PersonPage();

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final PersonController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<PersonController>();

    controller.addListener(() {
      if (controller.state == ExitState.success) {
        Future.delayed(
            Duration(milliseconds: 1000),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: Consumer<PersonController>(builder:
                        (BuildContext context, controller, Widget? child) {
                      return ElevatedButton(
                        onPressed: () {
                          controller.exit();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder()),
                        child: const Text("Sair"),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
