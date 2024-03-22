import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/person_administration_page.dart';
import 'parse_form_post.dart';
import '../dataproviders/repository.dart';
import '../domain.dart';

void addPersonFormEndpoint(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  String? name = params["name"];
  if (name == null) {
    print("error: name parameter is required but not in request body");
    return;
  }
  final newPerson = Person(nanoid(), name);
  persons.add(newPerson);
  savePeople(persons);
  response.setStatus(200);
  response.write(playerRow(newPerson));
}

void apiPersonUpdateEndpoint(SsrRequest request, SsrResponse response) async {
  print(request.requestData);
  response.setStatus(200);
  response.close();
}

void checkPersonFormEndpoint(SsrRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader(Endpoints.personManager.path);
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  for (var p in persons) {
    p.workoutsPrepared = int.parse(params[p.id] ?? "0");
  }
  savePeople(persons);
  response.close();
}

void deletePersonFormEndpoint(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();

  String? personId = params["personId"];
  if (personId == null || personId == "") {
    response.setStatus(400);
    response.close();
    return;
  }

  persons = persons.where((it) => it.id != personId).toList();
  savePeople(persons);
  response.setStatus(200);
  response.write("");
}

void delaysPersonFormEndpoint(SsrRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader(Endpoints.personManager.path);
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  for (var p in persons) {
    int openFine = int.parse(params[p.id] ?? "0");
    p.openFine = openFine;
  }
  savePeople(persons);
  response.close();
}
