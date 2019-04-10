import 'package:flrx/navigation/route_retriever.dart';
import 'package:fluro/src/common.dart';
import 'package:flutter/widgets.dart';

class MockRouteRetriever extends RouteRetriever {
  static const String MOCK_LOGIN = "/login";
  static const String MOCK_REGISTER = "/register";
  static const String MOCK_CUSTOMER_HOME = "/customer";
  static const String MOCK_CUSTOMER_PROFILE = "/customer/profile";
  @override
  Map<String, Handler> getCommonRoutes() {
    return <String, Handler>{
      MOCK_LOGIN: Handler(),
      MOCK_REGISTER: Handler(),
    };
  }

  @override
  Map<String, Handler> getModuleRoutes() {
    return <String, Handler>{
      MOCK_CUSTOMER_HOME: Handler(),
      MOCK_CUSTOMER_PROFILE: Handler(),
    };
  }

  @override
  Handler getRootHandler() {
    return Handler();
  }

  @override
  Handler getNotFoundHandler() {
    Handler notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("Route not found");
    });
    return notFoundHandler;
  }
}
