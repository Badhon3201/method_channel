import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = "";

  // Future<void> _getBatteryLevel() async {
  //   String batteryLevel;
  //   try {
  //     final int result = await platform.invokeMethod('getBatteryLevel');
  //     batteryLevel = 'Battery level at $result % .';
  //   } on PlatformException catch (e) {
  //     batteryLevel = "Failed to get battery level: '${e.message}'.";
  //   }
  //
  //   setState(() {
  //     _batteryLevel = batteryLevel;
  //   });
  // }

  // int val1 = 5;
  // int val2 = 6;
  var val1 = TextEditingController();
  var val2 = TextEditingController();

  Future<void> getSummation() async {
    String summationData;

    // print("${val1.text} ${val2.text}");
    try {
      final int result = await platform.invokeMethod('getSummation',
          {"val1": int.parse(val1.text), "val2": int.parse(val2.text)});
      summationData = "$result";
    } on PlatformException catch (e) {
      summationData = "Failed to get Summation : '${e.message}'.";
    }
    setState(() {
      _batteryLevel = summationData;
    });
  }

  Future<void> getToast() async {
    String summationData;

    // print("${val1.text} ${val2.text}");
    try {
      final String result = await platform.invokeMethod('getRepeat');
      summationData = result;
    } on PlatformException catch (e) {
      summationData = "Failed to get Toast : '${e.message}'.";
    }
    setState(() {
      _batteryLevel = summationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(controller: val1),
            TextFormField(controller: val2),
            ElevatedButton(
              onPressed: getToast,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
