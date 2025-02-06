import 'package:flutter/material.dart';
import 'package:tolist_app/menu_bar.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      drawer: MenuLeft(),
    );
  }
}
