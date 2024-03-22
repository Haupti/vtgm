import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/api/parse_form_post.dart';
import 'package:vtgm/dataproviders/repository.dart';
import 'package:vtgm/dataproviders/responsibility_repository.dart';
import 'package:vtgm/domain.dart';

void addRoleEndpoint(SsrRequest request, SsrResponse response) async {
  print(request.requestData);
  response.setStatus(301).setLocationHeader("/roles/set");

  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  List<Responsibility> responsibilities = getResponsibilities();

  final String? roleName = params["roleName"];
  final String? responsiblePersonId = persons.where((it) => it.id == params["memberId"]).firstOrNull?.id;
  if (roleName == null || responsiblePersonId == null) {
    response.close();
    return;
  }
  responsibilities.add(Responsibility(id: nanoid(), name: roleName, personId: responsiblePersonId));
  saveResponsibilities(responsibilities);

  response.close();
}
