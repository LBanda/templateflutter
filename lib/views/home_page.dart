import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController cpController = TextEditingController();
  final TextEditingController trestbpsController = TextEditingController();
  final TextEditingController cholController = TextEditingController();
  final TextEditingController fbsController = TextEditingController();
  final TextEditingController restecgController = TextEditingController();
  final TextEditingController thalachController = TextEditingController();
  final TextEditingController exangController = TextEditingController();
  final TextEditingController oldpeakController = TextEditingController();
  final TextEditingController slopeController = TextEditingController();
  final TextEditingController caController = TextEditingController();
  final TextEditingController thalController = TextEditingController();

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  String? scoreText;

  Future<void> getScore() async {
    try {
      String endpoint = 'https://deployml-service-jazaelog.cloud.okteto.net/score';
      final response = await Dio().post(endpoint, data: {
        "age": int.tryParse(ageController.text) ?? 0,
        "sex": int.tryParse(sexController.text) ?? 0,
        "cp": int.tryParse(cpController.text) ?? 0,
        "trestbps": int.tryParse(trestbpsController.text) ?? 0,
        "chol": int.tryParse(cholController.text) ?? 0,
        "fbs": int.tryParse(fbsController.text) ?? 0,
        "restecg": int.tryParse(restecgController.text) ?? 0,
        "thalach": int.tryParse(thalachController.text) ?? 0,
        "exang": int.tryParse(exangController.text) ?? 0,
        "oldpeak": double.tryParse(oldpeakController.text) ?? 0.0,
        "slope": int.tryParse(slopeController.text) ?? 0,
        "ca": int.tryParse(caController.text) ?? 0,
        "thal": int.tryParse(thalController.text) ?? 0,
      });

      setState(() {
        scoreText = response.data.toString();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    sexController.dispose();
    cpController.dispose();
    trestbpsController.dispose();
    cholController.dispose();
    fbsController.dispose();
    restecgController.dispose();
    thalachController.dispose();
    exangController.dispose();
    oldpeakController.dispose();
    slopeController.dispose();
    caController.dispose();
    thalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: sexController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sex',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cp',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: trestbpsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Trestbps',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cholController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Chol',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: fbsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Fbs',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: restecgController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Restecg',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: thalachController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Thalach',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: exangController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Exang',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: oldpeakController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Oldpeak',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: slopeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Slope',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: caController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ca',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: thalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Thal',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getScore();
                },
                child: const Text('Obtener Score'),
              ),
              const SizedBox(height: 20),
              if (scoreText != null)
                Text(
                  'Resultado: $scoreText',
                  style: const TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
