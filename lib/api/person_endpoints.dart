import 'package:nanoid/nanoid.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/domain/person.dart';
import 'package:vtgm/pages/person_administration_page.dart';
import 'parse_form_post.dart';
import '../dataproviders/repository.dart';

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
  Map<String, String> params = await parseFormData(request);

  List<Person> persons = getPeople();
  persons = persons.map((it) {
    it.workoutsPrepared = int.parse(params["workouts%3A${it.id}"] ?? "${it.workoutsPrepared}");
    it.openFine = int.parse(params["fine%3A${it.id}"] ?? "${it.openFine}");
    return it;
  }).toList();
  savePeople(persons);
  response.setStatus(200);
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

