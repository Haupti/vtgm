import 'package:vtgm/dataproviders/repository.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';
import '../domain.dart';

Component _toWorkoutInput(Person p) {
  return Component.fromHtmlString("""
    <div class="form-group">
      <label class="form-checkbox">
        <input type="checkbox" name="${p.id}" ${p.checked ? "checked" : ""}>
        <i class="form-icon"></i>${p.name}
      </label>
    </div>
  """);
}

String _userWorkoutForm(List<Person> persons) {
  return """
    <form action="${Endpoints.apiPersonCheckUpdate.path}" method="post" style="padding: 0 0 0 16px;">
      ${renderMany(persons.map(_toWorkoutInput).toList())}
      <div class="form-group">
        <input type="submit" value="save" class="btn btn-primary"/>
      </div>
    </form>
  """;
}

Component _toUserFineInput(Person p) {
  return Component.fromHtmlString("""
      <div class="form-group">
        <label class="form-number">
          <input type="number" name="${p.id}" value="${p.currentDelays}"/>
          <i class="form-icon"></i>${p.name}
        </label>
        </div>
  """);
}

String _usersFineForm(List<Person> persons) {
  return """
    <form action="${Endpoints.apiPersonDelaysUpdate.path}" method="post" style="padding: 0 0 32px 16px;">
      ${renderMany(persons.map(_toUserFineInput).toList())}
      <div class="form-group">
        <input type="submit" value="save" class="btn btn-primary"/>
      </div>
    </form>
""";
}

void managePersonPage(SsrRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    Component.fromHtmlString("""
      <div style="max-width:1000px; margin: auto;">
        <h1>Update</h1>
        <h2>Who has prepared workout so far?</h2>
        ${_userWorkoutForm(persons)}
        <h2 style="margin: .5em 0 .5em 0;">Whats the fine everybody has to pay (in Euro)?</h2>
        ${_usersFineForm(persons)}
      </div>
    """)
  ]);
  okHtmlResponse(response, page);
}
