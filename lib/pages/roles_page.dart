import 'package:vtgm/dataproviders/responsibility_repository.dart' as repo;
import 'base_page.dart';
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

void homePage(SsrRequest request, SsrResponse response) {
  List<Person> persons = people_repo.getPeople();
  List<Responsibility> responsibilities = repo.getResponsibilities();
  RootPage page = basePage([
    Component.fromHtmlString("""
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
    """)
  ]);
  okHtmlResponse(response, page);
}
