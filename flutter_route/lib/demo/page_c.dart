import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_route/router/router.dart';

@ARoute(url: 'app://page/c')
class PageC extends StatefulWidget {
  ARouteOption option;
  PageC(this.option) : super();

  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  int _pageIndex;

  @override
  void initState() {
    _pageIndex = this.widget.option.params['pageIndex'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是第$_pageIndex个 PageC'),
      ),
      body: Center(
        child: Container(
          width: 300.0,
          height: 500.0,
          child: WillPopScope(
              child: ListView(
                children: _buildItems(),
              ),
              onWillPop: () {
                Navigator.of(context).pop('第$_pageIndex个PageC pop了');
                return Future.value(false);
              }),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> items = <Widget>[
      ListTile(
          title:
              Text('open', style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('push一个PageC',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.open(context, 'app://page/c',
                params: {'pageIndex': _pageIndex + 1}).then((value) {
              showSimpleDialog(value);
            });
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openReplacement',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageC 并替换当前页',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            HJRouter.openReplacementNamed(context, 'app://page/c',
                params: {'pageIndex': _pageIndex}).then((value) {
                showSimpleDialog(value);
            });
          }),
      Divider(height: 1.0),
      ListTile(
          title: Text('openAndRemoveUntil',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          subtitle: Text('打开一个PageC \n并循环移除之前所有页面 直到找到指定页面为止',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          onTap: () {
            _pageIndex = 1;
            HJRouter.openAndRemoveUntil(
                context, 'app://page/c', ModalRoute.withName('/'),
                params: {'pageIndex': _pageIndex}).then((value) {
              showSimpleDialog(value);
            });
          }),
      Divider(height: 1.0),
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
          title: new Text(value,
              style: TextStyle(fontSize: 16, color: Colors.blue),
              textAlign: TextAlign.center),
          backgroundColor: Colors.yellowAccent,
        );
      },
    );
    Future.delayed(
        const Duration(seconds: 1), () => Navigator.of(context).pop());
  }
}
