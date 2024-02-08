import 'dart:io';
import '../ssr/response.dart';
import 'parse_form_post.dart';
import '../dataproviders/repository.dart';
import 'dart:convert';
import '../domain.dart';

void addPersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/add");
  String requestBody = await utf8.decodeStream(request);
  Map<String, String> params =formPostBodyToMap(requestBody);
  List<Person> persons = getPeople();
  String? name = params["name"];
  if(name == null){
    print("error: name parameter is required but not in request body");
    return;
  }
  persons.add(Person(name));
  savePeople(persons);
}
