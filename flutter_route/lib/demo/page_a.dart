import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route/router/router.dart';

@ARoute(url: 'app://page/a')
class PageA extends StatefulWidget {
  PageA(ARouteOption option) : super();

  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageA'),
      ),
      body: Center(
        child: Container(
          width: 300.0,
          height: 500.0,
          child: ListView(
            children: _buildItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> items = <Widget>[
      ListTile(
          title:
              Text('open', style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('push一个PageA',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.open(context, 'app://page/a');
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openReplacement',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageA 并替换当前页',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openReplacementNamed(context, 'app://page/a');
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openAndRemoveUntil',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageA \n并循环移除之前所有页面 直到找到指定页面为止',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openAndRemoveUntil(
                context, 'app://page/a', ModalRoute.withName('/'));
          }),
      Divider(height: 1.0),
    ];
    return items;
  }
}
