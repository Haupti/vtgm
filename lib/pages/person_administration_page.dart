import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import 'package:vtgm/dataproviders/repository.dart';
import 'package:vtgm/domain.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';

String playerRow(Person person) {
  return """<tr id="personRow${person.id}">
                <td><button
                        class="btn btn-error"
                        hx-post="${Endpoints.personDelete.path}"
                        hx-target="#personRow${person.id}"
                        hx-swap="outerhtml"
                        hx-vals='{"personId":"${person.id}"}'
                        hx-confirm="Are you sure you want to delete '${person.name}'?"
                        >
                            <i class="icon icon-cross"></i>
                    </button>
                </td>
                <td>${person.name}</td>
                <td></td>
            </tr>""";
}

void personAdministrationPage(SsrRequest request, SsrResponse response) {
  List<Person> members = getPeople();
  RootPage page = basePage([
    Component.fromHtmlString("""
      <div style="max-width: 1000px; margin: auto;">
        <h1> Member Administration </h1>
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th>Name</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                ${members.map((it) => playerRow(it)).join()}
                <tr id="playerInsertTargetId">
                    <form hx-post="${Endpoints.personAdd.path}" hx-target="#playerInsertTargetId" hx-swap="beforebegin">
                        <td></td>
                        <td><input type="text" name="name"/></td>
                        <td><input type="submit" value="Save" class="btn btn-primary"></td>
                    </form>
                </tr>
            </tbody>
        </table>
      </div>
    """)
  ]);
  okHtmlResponse(response, page);
}
