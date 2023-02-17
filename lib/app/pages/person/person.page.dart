import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/my_data/my_data.page.dart';
import 'package:firenzery/app/pages/person/person.controller.dart';
import 'package:firenzery/app/pages/settings/settings.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class ConfigModel {
  String? name;
  IconData? icon;
  Widget? tabs;

  ConfigModel({name, icon, tabs});

  ConfigModel setValues(String name, IconData icon, Widget tabs) {
    this.name = name;
    this.icon = icon;
    this.tabs = tabs;

    return this;
  }
}

class PersonPage extends StatefulWidget {
  PersonPage();

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final PersonController controller;
  List<ConfigModel> settings = [
    ConfigModel().setValues(
        'Meus dados', Icons.adf_scanner_outlined, const MyDataPage()),
    ConfigModel()
        .setValues('Configurações', Icons.settings, const SettingsPage()),
    ConfigModel().setValues('Sair', Icons.exit_to_app, LoginPage())
  ];

  @override
  void initState() {
    super.initState();

    controller = context.read<PersonController>();

    controller.addListener(() {
      if (controller.state == ExitState.success) {
        Future.delayed(
            const Duration(milliseconds: 1000),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "Perfil",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(defaultPadding / 4),
              horizontal: getProportionateScreenWidth(defaultPadding)),
          child: GestureDetector(
            onTap: () {
              if (settings[index].name == 'Sair') {
                controller.exit();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => settings[index].tabs!));
              }
            },
            child: Container(
              height: getProportionateScreenWidth(70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        getProportionateScreenWidth(defaultPadding / 1.5),
                    vertical: getProportionateScreenHeight(defaultPadding / 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: defaultPadding),
                    Icon(settings[index].icon!),
                    const SizedBox(width: defaultPadding),
                    Text(
                      settings[index].name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Center(
            //             child: SizedBox(
            //               width: 200,
            //               height: 48,
            //               child: Consumer<PersonController>(builder:
            //                   (BuildContext context, controller, Widget? child) {
            //                 return ElevatedButton(
            //                   onPressed: () {
            //                     controller.exit();
            //                   },
            //                   style: ElevatedButton.styleFrom(
            //                       primary: primaryColor,
            //                       shape: const StadiumBorder()),
            //                   child: const Text("Sair"),
            //                 );
            //               }),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 40,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
