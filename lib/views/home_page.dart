import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => _openDrawer(context),
          ),
      ),
      drawer: const SideBar(),
      body: Container(),
    );
  }
}
