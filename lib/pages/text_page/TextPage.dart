import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextPage extends StatefulWidget {
  String text;

  TextPage(this.text, {super.key});

  @override
  _TextPageState createState() {
    return _TextPageState();
  }
}

class _TextPageState extends State<TextPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: SelectableText(widget.text),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: () async {
                  context.go("/");
                },
                child: Container(
                  color: Colors.red.withOpacity(0),
                  child: const Icon(
                    CupertinoIcons.back,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
