import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/api/parse_form_post.dart';
import 'package:vtgm/api/util.dart';
import 'package:vtgm/dataproviders/repository.dart';
import 'package:vtgm/dataproviders/responsibility_repository.dart';
import 'package:vtgm/domain/person.dart';
import 'package:vtgm/domain/responsibility.dart';
import 'package:vtgm/pages/roles_page.dart';

void deleteRoleEndpoint(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);
  List<Responsibility> responsibilities = getResponsibilities();
  final String? roleId = params["roleId"];
  if (roleId == null || roleId == "") {
    response.setStatus(400);
    response.close();
    return;
  }
  responsibilities =
      responsibilities.where((it) => it.id != params["roleId"]).toList();
  saveResponsibilities(responsibilities);

  response.setStatus(200);
  response.write("");
}

void addRoleEndpoint(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  List<Responsibility> responsibilities = getResponsibilities();

  final String? roleName = params["roleName"];
  final String? responsiblePersonId =
      persons.where((it) => it.id == params["memberId"]).firstOrNull?.id;
  if (roleName == null || responsiblePersonId == null) {
    response.setStatus(400);
    response.close();
    return;
  }
  final newResponsibility = Responsibility(
      id: nanoid(), name: urlDecode(roleName), personId: responsiblePersonId);
  responsibilities.add(newResponsibility);
  saveResponsibilities(responsibilities);

  response.setStatus(200);
  response.write(roleRow(newResponsibility, persons));
}
