import 'base_page.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

void addPersonPage(SsrRequest request, SsrResponse response) {
  RootPage page = basePage([
    Component.fromHtmlString("""
      <h1> Add Player </h1>
        <form action="/person/add" method="post" styled="padding: 0 0 0 16px;">
          <div class="form-group">
            <label class="form-label" for="add-person-input">Name</label>
            <input class="form-input" type="text" id="add-person-input" name="name" placeholder="Name">
          </div>
          <div class="form-group">
            <input type="submit" value="save" class="btn btn-primary"/>
          </div>
        </form>
    """)
  ]);
  okHtmlResponse(response, page);
}
