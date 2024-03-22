import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';

void addPersonPage(SsrRequest request, SsrResponse response) {
  RootPage page = basePage([
    Component.fromHtmlString("""
      <div style="max-width: 1000px; margin: auto;">
        <h1> Add Player </h1>
        <form action="${Endpoints.apiPersonAdd.path}" method="post" styled="padding: 0 0 0 16px;">
          <div class="form-group">
            <label class="form-label" for="add-person-input">Name</label>
            <input class="form-input" type="text" id="add-person-input" name="name" placeholder="Name">
          </div>
          <div class="form-group">
            <input type="submit" value="save" class="btn btn-primary"/>
          </div>
        </form>
      </div>
    """)
  ]);
  okHtmlResponse(response, page);
}
