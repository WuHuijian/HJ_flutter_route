import 'package:flutter/material.dart';
import 'package:annotation_route/route.dart';
import 'package:flutter_route/router/router.dart';

@ARoute(url: '/')
class HJHomeList extends StatefulWidget {
  HJHomeList(ARouteOption option) : super();

  @override
  State<StatefulWidget> createState() {
    return _HJHomeListState();
  }
}

class _HJHomeListState extends State<HJHomeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      //加入可滚动组件
      body: ListView(
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> items = <Widget>[
      ListTile(
          title: Text('PageA'),
          onTap: () {
            HJRouter.open(context, 'app://page/a');
//            HJRouter.of(context).pushNamed('app://page/a');
          }),
      ListTile(
          title: Text('PageB'),
          onTap: () {
            HJRouter.open(context, 'app://page/b', params: {'pageIndex': 1});
          }),
      ListTile(
          title: Text('PageC'),
          onTap: () {
            HJRouter.open(context, 'app://page/c', params: {'pageIndex': 1})
                .then((value) {
              showSimpleDialog(value);
            });
          }),
    ];
    return items;
  }

  showSimpleDialog(String value) {

    if (value == null)
      return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          titlePadding: EdgeInsets.all(20.0),
          title:
          new Text(value, style: TextStyle(fontSize: 16, color: Colors.blue),textAlign: TextAlign.center),
          backgroundColor: Colors.yellowAccent,
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () => Navigator.of(context).pop());
  }
}
