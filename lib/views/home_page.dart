import 'dart:convert';

import 'package:crypto/crypto.dart';
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
  final TextEditingController hourController = TextEditingController();
  final TextEditingController junctionController = TextEditingController();
  final TextEditingController urlUserController = TextEditingController();

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  String generateSHA() {
  final now = DateTime.now().toString(); 
  final bytes = utf8.encode(now);
  final sha = sha1.convert(bytes); 
  return sha.toString();
}

  String? trafficStatus;
  String? reTrain;
  final Color greenColor = Colors.green;
  final Color redColor = Colors.red;

  Future<void> reTrainModel(String urlUser) async {
  try {
    final String url = 'https://api.github.com/repos/JazaeloG/ModeloTrafico/dispatches';
    final shaGenerate = generateSHA();

    final Map<String, dynamic> requestBody = {
      "event_type": "tm_ci_cd",
      "client_payload": {
        "dataseturl": urlUser,
        "sha": shaGenerate,
      }
    };

    final String basicAuth = 'Bearer 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';

    final dio = Dio();

    dio.options.headers['Accept'] = 'application/vnd.github.v3+json';
    dio.options.headers['Authorization'] = basicAuth;

    final response = await dio.post(
      url,
      data: jsonEncode(requestBody),
    );

    if (response.statusCode == 204) {
      print('Solicitud enviada con éxito');
    } else {
      print('Error al enviar la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

  Future<void> getTrafficStatus() async {
  try {
    //String endpoint = 'https://traffic-model-service-jazaelog.cloud.okteto.net/predict';
    String endpoint = 'https://heart-model-service-lbanda.cloud.okteto.net/score';
    /*
    final response = await Dio().post(endpoint, data: {
      "DateTime": hourController.text, 
      "Junction": int.tryParse(junctionController.text) ?? 0,  
    });
    */
    final response = await Dio().post(endpoint, data: {
      "age": 64,
      "sex": 1,
      "cp": 3,
      "trestbps": 120,
      "chol": 267,
      "fbs": 0,
      "restecg": 0,
      "thalach": 99,
      "exang": 1,
      "oldpeak": 1.8,
      "slope": 1,
      "ca": 2,
      "thal": 2
    });

/*
    if (response.data != null && response.data is Map) {
      final isTraffic = response.data['is_traffic'];
      if (isTraffic != null) {
        setState(() {
          trafficStatus = isTraffic ? 'true' : 'false';
        });
        return;
      }
    }
*/

    if (response != null) {
      //final isTraffic = response.score;

      print(response);

      /*if (isTraffic != null) {
        setState(() {
          trafficStatus = response.score;
        });
        return;
      }*/
    }
    
    setState(() {
      trafficStatus = 'Respuesta inesperada';
    });
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
  }
}



  void _showStatusDialog(String? status) {
    status = trafficStatus;
  if (status != null) {
    final bgColor = status == 'false' ? greenColor : redColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Estado de Tráfico'),
          content: Text(status == 'true' ? 'Habra trafico' : 'No habra trafico'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: bgColor,
        );
      },
    );
  }
}


  @override
  void dispose() {
    hourController.dispose();
    junctionController.dispose();
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
              controller: hourController,
              keyboardType: TextInputType.text, 
              decoration: const InputDecoration(
                labelText: 'Hora',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: junctionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calle/Intersección',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getTrafficStatus();
              },
              child: const Text('Obtener Estado de Tráfico'),
            ),
            const SizedBox(height: 20),
            if (trafficStatus != null)
              ElevatedButton(
                onPressed: () {
                  _showStatusDialog(trafficStatus!);
                },
                child: const Text('Ver Estado'),
              ),
            TextField(
                controller: urlUserController, 
                keyboardType: TextInputType.url, 
                decoration: const InputDecoration(
                  labelText: 'URL de datos',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  reTrainModel(urlUserController.text);
                },
                child: const Text('Enviar Solicitud'),
              ),
          ],
        ),
      ),
    ),
  );
}


}