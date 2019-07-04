import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route/router/router.dart';

@ARoute(url: 'app://page/b')
class PageB extends StatefulWidget {

  ARouteOption option;
  PageB(this.option) : super();

  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> {

  int _pageIndex;

  @override
  void initState() {

    _pageIndex = this.widget.option.params['pageIndex'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是第$_pageIndex个 PageB'),
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
          subtitle: Text('push一个PageB',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.open(context, 'app://page/b',
                params: {'pageIndex': _pageIndex+1});
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openReplacement',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageB 并替换当前页',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openReplacementNamed(context, 'app://page/b',params: {'pageIndex': _pageIndex});
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openAndRemoveUntil',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageB \n并循环移除之前所有页面 直到找到指定页面为止',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openAndRemoveUntil(
                context, 'app://page/b', ModalRoute.withName('/'),params: {'pageIndex': 1});
          }),
      Divider(height: 1.0),
    ];
    return items;
  }
}
