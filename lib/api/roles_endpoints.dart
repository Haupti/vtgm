import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/api/parse_form_post.dart';
import 'package:vtgm/dataproviders/repository.dart';
import 'package:vtgm/domain.dart';

void addRoleEndpoint(SsrRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/roles/set");
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();

  print(request.requestData);
  response.close();
}
