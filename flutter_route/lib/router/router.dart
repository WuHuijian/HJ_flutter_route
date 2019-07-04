import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import './router.internal.dart';

@ARouteRoot()
class HJRouter extends Navigator{

  static Widget notFoundPage;

  // 获取所有路由
  static Map<String, WidgetBuilder> getAllRoutes() {
    Map<String, WidgetBuilder> allRoutes = Map<String, WidgetBuilder>();
    ARouterInternalImpl internal = ARouterInternalImpl();
    Map<String, List<Map<String, dynamic>>> innerRouterMap =
        internal.innerRouterMap;
    innerRouterMap.forEach((key, value) {
      value.forEach((map){
        bool hasParams = false;
        map.forEach((key1,value1){
          if(key1 == 'params'){
            hasParams = true;
            Map<String, WidgetBuilder> route = <String, WidgetBuilder>{
              key: (BuildContext context) => getPage(key, value1)
            };
            allRoutes.addAll(route);
          }
        });

        if(!hasParams){
          Map<String, WidgetBuilder> route = <String, WidgetBuilder>{
            key: (BuildContext context) => getPage(key, null)
          };
          allRoutes.addAll(route);
        }
      });
    });
    return allRoutes;
  }

  // 获取对应页面
  static Widget getPage(String url, Map<String, dynamic> params) {
    ARouterInternalImpl internal = ARouterInternalImpl();
    ARouterResult routerResult =
        internal.findPage(ARouteOption(url, params), ARouteOption(url, params));

    if (routerResult.state == ARouterResultState.FOUND) {
      return routerResult.widget;
    } else if (routerResult.state == ARouterResultState.REDIRECT) {
      //重定向
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('重定向页面'),
        ),
      );
    } else {
      if (notFoundPage != null) {
        return notFoundPage;
      } else {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('未注册的url'),
          ),
        );
      }
    }
  }


  // 这段来自Navigator 为了继续使用Navigator的方法
  static NavigatorState of(
      BuildContext context, {
        bool rootNavigator = false,
        bool nullOk = false,
      }) {
    final NavigatorState navigator = rootNavigator
        ? context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>())
        : context.ancestorStateOfType(const TypeMatcher<NavigatorState>());
    assert(() {
      if (navigator == null && !nullOk) {
        throw FlutterError(
            'Navigator operation requested with a context that does not include a Navigator.\n'
                'The context used to push or pop routes from the Navigator must be that of a '
                'widget that is a descendant of a Navigator widget.'
        );
      }
      return true;
    }());
    return navigator;
  }

  // 打开页面 参数可选
  @optionalTypeArgs
  static Future<T> open<T extends Object>(
      BuildContext context,
      String routeName,
      {Map<String, dynamic> params}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return HJRouter.getPage(routeName, params);
    }));
  }

  // 替换页面 参数可选（先push 后 remove原来页面）
  @optionalTypeArgs
  static Future<T> openReplacementNamed<T extends Object, TO extends Object>(
      BuildContext context,
      String routeName, {
        TO result,
        Object arguments,
        Map<String, dynamic> params
      }) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return HJRouter.getPage(routeName, params);
    }));
  }

  // 打开页面 返回时返回到指定页面
  @optionalTypeArgs
  static Future<T> openAndRemoveUntil<T extends Object>(
      BuildContext context,
      String newRouteName,
      RoutePredicate predicate, {
        Object arguments,
        Map<String, dynamic> params
      }) {
    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
      return HJRouter.getPage(newRouteName, params);
    }), predicate);
  }

}
