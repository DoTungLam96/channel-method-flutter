// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_channel_platform/model/user.dart';
import 'package:flutter_channel_platform/screens/home.dart';
import 'package:flutter_channel_platform/screens/widget/item.dart';
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
  User? user;
  List<String> items = [];
  @override
  void initState() {
    serviceLocator.registerFactory(() => PlatformNativeDemo());

    items = List<String>.generate(1000, (i) => 'Item $i');

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
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (user?.id != null)
            Text(
              ' ID: ${user?.id} - Nickname: ${user?.nickName}',
            ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () async {
              final result = await serviceLocator
                  .get<PlatformNativeDemo>()
                  .checkInforDevice();
              setState(() {
                user = result;
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
          ),
          _buildListView(),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSliverView() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (user?.id != null)
                Text(
                  ' ID: ${user?.id} - Nickname: ${user?.nickName}',
                ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  final result = await serviceLocator
                      .get<PlatformNativeDemo>()
                      .checkInforDevice();
                  setState(() {
                    user = result;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 130,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blue),
                  child: Text(
                    'Device info',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ItemData(item: items[index], index: index);
          },
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      prototypeItem: ItemData(
        index: 0,
        item: items[0],
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemData(
          index: index,
          item: items[index],
        );
      },
    );
  }
}
