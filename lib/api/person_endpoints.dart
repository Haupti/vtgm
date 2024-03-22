import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/endpoints.dart';
import 'parse_form_post.dart';
import '../dataproviders/repository.dart';
import '../domain.dart';

void addPersonFormEndpoint(SsrRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader(Endpoints.personAdd.path);
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  String? name = params["name"];
  if (name == null) {
    print("error: name parameter is required but not in request body");
    return;
  }
  persons.add(Person(nanoid(), name));
  savePeople(persons);
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
  response.setStatus(301).setLocationHeader(Endpoints.personDelete.path);
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  List<Person> filtered = [];
  for (var p in persons) {
    if (params[p.id] != "on") {
      filtered.add(p);
    }
  }
  savePeople(filtered);
  response.close();
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
