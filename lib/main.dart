import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_free_doc_reader/configs/routes.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPageService.dart';
import 'package:my_free_doc_reader/pages/text_page/TextPageService.dart';

void main() {
  setupGetIt();
  runApp(MyApp());
}

void setupGetIt() {
  GetIt.instance
      .registerSingleton(MainPageService(), instanceName: "MainPageService");
  GetIt.instance
      .registerSingleton(TextPageService(), instanceName: "TextPageService");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      routerConfig: router,
    );
  }
}
