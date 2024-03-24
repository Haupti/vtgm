import 'package:ssr/ssr.dart';
import 'package:vtgm/api/home_api.dart';
import 'package:vtgm/api/info_api.dart';
import 'package:vtgm/api/roles_endpoints.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/info_page.dart';
import 'package:vtgm/pages/person_administration_page.dart';
import 'package:vtgm/pages/roles_page.dart';
import 'pages/home_page.dart';
import 'api/person_endpoints.dart';


void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.home.path, handler: homePage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.infoPage.path, handler: infoPage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentEditableOverview.path, handler: editableOverviewTableHandler).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentOverview.path, handler: overviewTableHandler).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentTeamFundContent.path, handler: componentTeamFundContentHandler).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentTeamFundContentEditable.path, handler: componentTeamFundContentEditableHandler).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentInfoPageMessageAdd.path, handler: componentInfoPageMessageAdd).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.componentInfoPageHeading.path, handler: componentInfoPageHeading).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.rolesOverview.path, handler: rolesOverviewPage).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.rolesEdit.path, handler: rolesSetPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mGet, path: Endpoints.personAdministration.path, handler: personAdministrationPage).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiFundSave.path, handler: apiFundSaveEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonAdd.path, handler: addPersonFormEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonUpdate.path, handler: apiPersonUpdateEndpoint).setMinimumRole(AuthRole.mod),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiPersonDelete.path, handler: deletePersonFormEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiInfoMessageAdd.path, handler: apiInfoMessageAdd).setMinimumRole(AuthRole.basic),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiRoleAdd.path, handler: addRoleEndpoint).setMinimumRole(AuthRole.admin),
    RequestHandler(method: RequestMethod.mPost, path: Endpoints.apiRoleDelete.path, handler: deleteRoleEndpoint).setMinimumRole(AuthRole.admin),
  ];
  server(8080, handlers);
}
