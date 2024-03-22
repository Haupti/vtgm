import 'package:ssr/ssr.dart';
import 'package:vtgm/api/roles_endpoints.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/roles_page.dart';
import 'pages/home_page.dart';
import 'pages/add_person_page.dart';
import 'pages/manage_person_page.dart';
import 'pages/delete_person_page.dart';
import 'api/person_endpoints.dart';


void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.home.path, handler: homePage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.rolesOverview.path, handler: rolesOverviewPage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.rolesEdit.path, handler: rolesSetPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.personAdd.path, handler: addPersonPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.personManager.path, handler: managePersonPage).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.personDelete.path, handler: deletePersonPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonAdd.path, handler: addPersonFormEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonCheckUpdate.path, handler: checkPersonFormEndpoint).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonDelaysUpdate.path, handler: delaysPersonFormEndpoint).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonDelete.path, handler: deletePersonFormEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiRoleAdd.path, handler: addRoleEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiRoleDelete.path, handler: deleteRoleEndpoint).setMinimumRole(AuthRole.admin),
  ];
  server(8080, handlers);
}
