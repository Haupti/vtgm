import 'package:vtgm/dataproviders/responsibility_repository.dart' as repo;
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';
import '../dataproviders/repository.dart' as people_repo;
import '../domain.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

Person? findPersonResponsible(Responsibility resp, List<Person> people) {
  for (final p in people) {
    if (p.id == resp.personId) {
      return p;
    }
  }
  return null;
}

void rolesOverviewPage(SsrRequest request, SsrResponse response) {
  List<Person> persons = people_repo.getPeople();
  List<Responsibility> responsibilities = repo.getResponsibilities();
  RootPage page = basePage("""
      <div style="max-width: 1000px; margin: auto;">
        <h1>Overview</h1>
        <table class="table">
          <thead>
            <tr>
              <th>Role</th>
              <th>Name</th>
            </tr>
          </thead>
          <tbody>
            ${renderMany(responsibilities.map((responsibility) => Component.fromHtmlString("""
              <tr>
                <td>${responsibility.name}</td>
                <td>${findPersonResponsible(responsibility, persons)?.name ?? " "}</td>
              </tr>
            """)).toList())}
          </tbody>
        </table
      </div>
    """);
  okHtmlResponse(response, page);
}

String roleRow(Responsibility responsibility, List<Person> persons) {
  return """
              <tr id="responsibility${responsibility.id}">
                <td><button class="btn btn-error" hx-post="${Endpoints.apiRoleDelete.path}" hx-vals='{"roleId":"${responsibility.id}"}' hx-target="#responsibility${responsibility.id}" hx-swap="outerHTML"><i class="icon icon-cross"></i></button></td>
                <td>${responsibility.name}</td>
                <td>${findPersonResponsible(responsibility, persons)?.name ?? " "}</td>
                <td></td>
              </tr>
            """;
}

void rolesSetPage(SsrRequest request, SsrResponse response) {
  List<Person> persons = people_repo.getPeople();
  List<Responsibility> responsibilities = repo.getResponsibilities();
  RootPage page = basePage(
    """
      <div style="max-width: 1000px; margin: auto;">
        <h1>Overview</h1>
        <table class="table">
          <thead>
            <tr>
              <th></th>
              <th>Role</th>
              <th>Name</th>
              <th></th>
            </tr>
          </thead>
          <tbody >
            ${responsibilities.map((it) => roleRow(it, persons)).join()}
            <tr id="responsibilityInsertId">
              <form hx-post="${Endpoints.apiRoleAdd.path}" hx-target="#responsibilityInsertId" hx-swap="beforebegin">
                <td></td>
                <td><input type="text" name="roleName"/></td>
                <td>
                    <select class="form-select" id="memberIdSelect" name="memberId">
                      ${persons.map((it) => """<option value="${it.id}">${it.name}</option>""")}
                    </select>
                </td>
                <td><input class="btn btn-primary" type="submit" value="Save"/></td>
              </form>
            </tr>
          </tbody>
        </table
      </div>
    """);
  okHtmlResponse(response, page);
}
