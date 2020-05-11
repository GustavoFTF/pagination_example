import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chips Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "https://pokeapi.co/api/v2/pokemon";
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<dynamic> pokemon = [];
  int offset = 20, limit = 20;

  @override
  void initState() {
    callData();
    super.initState();
  }

  void callData() async {
    var response =
        await Dio().get(url, queryParameters: {"offset": 0, "limit": 20});
    setState(() {
      pokemon = response.data["results"];
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    await Dio()
        .get(url, queryParameters: {"offset": offset + 20, "limit": limit});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    var response = await Dio()
        .get(url, queryParameters: {"offset": offset + 20, "limit": limit});
    offset += 20;
    response.data["results"].forEach((data) {
      pokemon.add(data);
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chips Input Example'),
      ),
      resizeToAvoidBottomInset: false,
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) =>
              Card(child: Center(child: Text("Data: ${pokemon[i]["name"]}"))),
          itemExtent: 100.0,
          itemCount: pokemon.length,
        ),
      ),
    );
  }
}
