import 'package:vtgm/domain/person.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';
import 'package:vtgm/pages/info_page.dart';
import '../dataproviders/repository.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

enum ButtonType {
  edit,
  close;
}

String backButton(String swapId) {
  return """
         <button
             class="btn btn-primary"
             hx-get="${Endpoints.componentOverview.path}"
             hx-swap="innerhtml"
             hx-target="#$swapId"
             >
                 <i class="icon icon-cross"></i>
         </button>
         """;
}

String editButton(String swapId) {
  AuthRole currentRole = getCurrentAuthorizedUserRole();
  if (currentRole == AuthRole.mod || currentRole == AuthRole.admin) {
    return """<button
              class="btn btn-primary"
              hx-get="${Endpoints.componentEditableOverview.path}"
              hx-swap="innerhtml"
              hx-target="#$swapId"
              >
                  <i class="icon icon-edit"></i>
              </button>
        """;
  } else {
    return "";
  }
}

String titleWithButton(ButtonType buttonType, String swapId) {
  return """
            <div style="display: flex; justify-content: space-between;">
                <h1>Overview</h1>
                ${buttonType == ButtonType.edit ? editButton(swapId) : backButton(swapId)}
            </div>
    """;
}

String editableOverviewTableComponent() {
  String swapId = "homeContentId";
  List<Person> persons = getPeople();
  return """
        <div id="$swapId">
            ${titleWithButton(ButtonType.close, swapId)}
            <form
                hx-post="${Endpoints.apiPersonUpdate.path}"
                hx-swap="none"
            >
                <div style="display: flex; justify-content: flex-end;"><input type="submit" value="Save" class="btn btn-success"/></div>
                <table class="table">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Workouts</th>
                      <th>Fine (Euro)</th>
                    </tr>
                  </thead>
                  <tbody>
                    ${persons.map((p) => """
                        <tr>
                          <td>${p.name}</td>
                          <td><input type="number" max="999" min="-999" value="${p.workoutsPrepared}" name="workouts:${p.id}"/></td>
                          <td><input type="number" max="999" min="-999" value="${p.openFine}" name="fine:${p.id}"</td>
                        </tr>
                    """).join()}
                  </tbody>
                </table
            </form>
        </div>
        """;
}

String overviewTableComponent() {
  List<Person> persons = getPeople();
  persons.sort((a, b) => (a.workoutsPrepared.compareTo(b.workoutsPrepared)));
  List<Person> firstThree = persons.sublist(0, 3);
  List<Person> rest = persons.sublist(3);
  String swapId = "homeContentId";
  return """
        <div id="$swapId">
            ${titleWithButton(ButtonType.edit, swapId)}
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Workouts</th>
                  <th>Fine (Euro)</th>
                </tr>
              </thead>
              <tbody>
                ${renderMany(firstThree.map((p) => Component.fromHtmlString("""
                  <tr style="background-color: #FDFD96">
                    <td>${p.name}</td>
                    <td>${p.workoutsPrepared}</td>
                    <td>${p.openFine}</td>
                  </tr>
                """)).toList())}
                ${renderMany(rest.map((p) => Component.fromHtmlString("""
                  <tr>
                    <td>${p.name}</td>
                    <td>${p.workoutsPrepared}</td>
                    <td>${p.openFine}</td>
                  </tr>
                """)).toList())}
              </tbody>
            </table
        </div>
        """;
}

void homePage(SsrRequest request, SsrResponse response) {
  RootPage page =
      basePage("""
${overviewTableComponent()}
<div style="width: 100%; display: flex; justify-content: end; margin-top: 8px;">
    ${componentTeamFundContent()}
</div>
""");
  okHtmlResponse(response, page);
}
