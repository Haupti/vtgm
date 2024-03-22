import 'package:ssr/html.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/endpoints.dart';

Component navBar() {
  var brand = Component.fromHtmlString(
      """<a href="${Endpoints.home.path}" class="navbar-brand mr-2">TGM H5</a>""");
  var roles = Component.fromHtmlString(
      """<a href="${Endpoints.rolesOverview.path}" class="btn btn-link">Roles</a>""");
  var info = Component.fromHtmlString(
      """<a href="${Endpoints.infoPage.path}" class="btn btn-link">Roles</a>""");
  AuthRole currentRole = getCurrentAuthorizedUserRole();

  return Component.fromHtmlString("""
  <header class="navbar" style="padding: 16px 16px 0 16px;">
    <section class="navbar-section">
      <div class="dropdown">
        <a href="#" class="btn btn-link dropdown-toggle" tabindex="0"><i class="icon icon-menu"></i></a>
        <ul class="menu">
            <li class="menu-item"><a href="${Endpoints.home.path}">Overview</a></li>
            <li class="menu-item"><a href="${Endpoints.rolesOverview.path}">Roles</a></li>
            <li class="menu-item"><a href="${Endpoints.infoPage.path}">Roles</a></li>
            ${currentRole == AuthRole.admin ? """<li class="menu-item"><a href="${Endpoints.rolesEdit.path}">Set Roles</a></li>""" : ""}
            ${currentRole == AuthRole.admin ? """<li class="menu-item"><a href="${Endpoints.personAdministration.path}">Member Administration</a></li>""" : ""}
        </ul>
      </div>
      ${brand.render()}
      ${roles.render()}
      ${info.render()}
    </section>
  </header>
  <div class="divider"></div>
  """);
}
