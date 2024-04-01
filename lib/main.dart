// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_channel_platform/screens/home.dart';
import 'package:get_it/get_it.dart';

import 'platform/platform_native_demo.dart';

final GetIt serviceLocator = GetIt.instance;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  var data = "...";
  @override
  void initState() {
    serviceLocator.registerFactory(() => PlatformNativeDemo());
    print("initState\n");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    print("didChangeDependencies\n");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    print("didUpdateWidget\n");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("build\n");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${data}',
          ),
          const SizedBox(
            height: 8,
          ),
          StreamBuilder(
            stream: serviceLocator.get<PlatformNativeDemo>().getSensorValue(),
            builder: (context, snapshot) {
              return Text(
                'Sensor: ${snapshot.data}',
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () async {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()));
              final result = await serviceLocator
                  .get<PlatformNativeDemo>()
                  .checkInforDevice();
              setState(() {
                data = result;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 130,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.blue),
              child: Text(
                'Device info',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
