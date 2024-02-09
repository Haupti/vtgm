import 'package:vtgm/ssr/http/auth.dart';

import 'ssr/http/server.dart';
import 'ssr/http/request_handler.dart';
import 'pages/home_page.dart';
import 'pages/add_person_page.dart';
import 'pages/manage_person_page.dart';
import 'pages/delete_person_page.dart';
import 'api/person_endpoints.dart';


void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homePage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: "/person/add", handler: addPersonPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mGet, path: "/person/update", handler: managePersonPage).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mGet, path: "/person/delete", handler: deletePersonPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: "/person/add", handler: addPersonFormEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: "/person/check", handler: checkPersonFormEndpoint).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mPost, path: "/person/delays", handler: delaysPersonFormEndpoint).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mPost, path: "/person/delete", handler: deletePersonFormEndpoint).setMinimumRole(AuthRole.admin),
  ];
  server(8080, handlers);
}
