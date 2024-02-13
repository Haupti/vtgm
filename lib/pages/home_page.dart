import 'base_page.dart';
import '../dataproviders/repository.dart';
import '../domain.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

void homePage(SsrRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    Component.fromHtmlString("""
      <div style="max-width: 1000px; margin: auto;">
        <h1>Overview</h1>
        <table class="table">
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
      </div>
    """)
  ]);
  okHtmlResponse(response, page);
}
