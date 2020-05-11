import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_new_features/TaskModel.dart';
import 'package:test_new_features/filterModel.dart';

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
  final String url =
      "https://dev-tasks.crossroads-group.com/api/tasks/assigned/paged";
  final String cookie =
      "_fbp=fb.1.1585952795850.569407500; jwt-doSsoCookie=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODI5NTc1Mzc3MTM5ODEyNTEiLCJ1c2VySWQiOiIzODI5NTc1Mzc3MTM5ODEyNTEiLCJleHBpcmVzSW4iOjI1OTIwMDAsImlhdCI6MTU4ODU5OTA5NCwiZXhwIjoxNTkxMTkxMDk0fQ.XTmOMq1_tFnD-dmkv3nAOWkTm6I-inwnWLrVH6v8yx4; crgSsoSessionId=FyJCD5oW6qDSSpMaXn5zcnFRMcnyGFS4; crgSsoSessionId_expiration=1589223685785";
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<TaskModel> tasks = [];
  FilterModel filterModel = FilterModel();

  @override
  void initState() {
    callData();
    super.initState();
  }

  void callData() async {
    var response = await Dio(BaseOptions(headers: {"cookie": cookie})).get(
      url,
      queryParameters: filterModel.getShortParams,
    );
    response.data["assigned"].forEach((data) {
      tasks.add(TaskModel.fromJson(data));
    });
    setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    filterModel.pageNumber += 1;
    var response = await Dio(BaseOptions(headers: {"cookie": cookie}))
        .get(url, queryParameters: filterModel.getShortParams);
    response.data["assigned"].forEach((data) {
      tasks.add(TaskModel.fromJson(data));
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
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) =>
              Card(child: Center(child: Text("Data: ${tasks[i].name}"))),
          itemExtent: 100.0,
          itemCount: tasks.length,
        ),
      ),
    );
  }
}
