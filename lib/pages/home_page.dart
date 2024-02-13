import 'base_page.dart';
import '../dataproviders/repository.dart';
import '../domain.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

void homePage(SsrRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    Component.fromHtmlString("""
      <h1>overview</h1>
      <table class="table" style="max-width: 1000px; margin: auto;">
        <thead>
          <tr>
            <th>name</th>
            <th>workout</th>
            <th>fine/euro</th>
          </tr>
        </thead>
        <tbody>
          ${renderMany(persons.map((p) => Component.fromHtmlString("""
            <tr>
              <td>${p.name}</td>
              <td>${p.checked ? "done" : ""}</td>
              <td>${p.currentDelays}</td>
            </tr>
          """)).toList())}
        </tbody>
      </table
    """)
  ]);
  okHtmlResponse(response, page);
}
