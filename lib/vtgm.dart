import 'ssr/http/server.dart';
import 'ssr/http/request_handler.dart';
import 'pages/home_page.dart';
import 'pages/add_person_page.dart';
import 'pages/check_person_page.dart';
import 'pages/delete_person_page.dart';
import 'api/person_endpoints.dart';


void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homePage),
    RequestHandler(method: RequestMethod.mGet, path: "/person/add", handler: addPersonPage),
    RequestHandler(method: RequestMethod.mGet, path: "/person/check", handler: checkPersonPage),
    RequestHandler(method: RequestMethod.mGet, path: "/person/delete", handler: deletePersonPage),
    RequestHandler(method: RequestMethod.mPost, path: "/person/add", handler: addPersonFormEndpoint),
    RequestHandler(method: RequestMethod.mPost, path: "/person/check", handler: checkPersonFormEndpoint),
    RequestHandler(method: RequestMethod.mPost, path: "/person/delete", handler: deletePersonFormEndpoint),
  ];
  server(8080, handlers);
}
