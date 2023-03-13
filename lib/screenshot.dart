import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenShotScreen extends StatelessWidget {
  const ScreenShotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hahahahahah"),
      ),
      body: const Center(
          child: Text(
        "No ScrrenShot After Now Baby",
        style: TextStyle(
          color: Colors.red,
        ),
      )),
    );
  }
}
