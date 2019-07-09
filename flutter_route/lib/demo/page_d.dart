import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route/router/router.dart';

@ARoute(alias: [
  ARouteAlias(url: 'app://page/d'),
  ARouteAlias(url: 'app://page/d/open'),
  ARouteAlias(url: 'app://page/d/openReplacement'),
  ARouteAlias(url: 'app://page/d/openAndRemoveUntil'),
])
class PageD extends StatefulWidget {
  PageD(ARouteOption option) : super();

  @override
  _PageDState createState() => _PageDState();
}

class _PageDState extends State<PageD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageD'),
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
          subtitle: Text('push一个PageD',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
//            HJRouter.open(context, 'app://page/d/open');
          Navigator.of(context).pushNamed('app://page/d/open',arguments: 'hello');
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openReplacement',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageD 并替换当前页',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openReplacementNamed(context, 'app://page/d/openReplacement');
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openAndRemoveUntil',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageD \n并循环移除之前所有页面 直到找到指定页面为止',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openAndRemoveUntil(
                context, 'app://page/d/openAndRemoveUntil', ModalRoute.withName('/'));
          }),
      Divider(height: 1.0),
    ];
    return items;
  }
}
