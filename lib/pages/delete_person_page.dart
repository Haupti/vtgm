import 'package:vtgm/dataproviders/repository.dart';
import 'base_page.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import '../domain.dart';

Component _toDeleteInput(Person p) {
  return Component.fromHtmlString("""
    <div class="form-group">
      <label class="form-checkbox">
        <input type="checkbox" name="${p.id}">
        <i class="form-icon"></i>${p.name}
      </label>
    </div>
  """);
}

String _userDeleteForm(List<Person> persons) {
  return """
    <form action="/person/delete" method="post" style="padding: 0 0 0 16px;">
      ${renderMany(persons.map(_toDeleteInput).toList())}
      <div class="form-group">
        <input type="submit" value="delete" class="btn btn-primary"/>
      </div>
    </form>
  """;
}

void deletePersonPage(SsrRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  Style style = Style(display: "flex", flexDirection: "row-reverse", justifyContent: "left");
  RootPage page = basePage([
    Component.fromHtmlString("""
      <div style="max-width: 1000px; margin: auto;">
        <h1> Delete Player </h1>
        ${_userDeleteForm(persons)}
      </div>
    """)
  ]);
  okHtmlResponse(response, page);
}
