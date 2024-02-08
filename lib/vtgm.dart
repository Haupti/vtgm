import 'ssr/server.dart';
import 'ssr/request_handler.dart';
import 'pages/home_page.dart';
import 'pages/add_person_page.dart';
import 'api/add_person_endpoint.dart';


void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint),
    RequestHandler(method: RequestMethod.mGet, path: "/person/add", handler: addPersonEndpoint),
    RequestHandler(method: RequestMethod.mPost, path: "/person/add", handler: addPersonFormEndpoint)
  ];
  server(8080, handlers);
}
