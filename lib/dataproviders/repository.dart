import 'dart:io';
import "dart:convert";
import 'package:vtgm/domain/person.dart';

File peoplesFile = File("data/people.json");

List<Person> getPeople(){
  if(!peoplesFile.existsSync()){
    return [];
  }
  String jsonArrayString = peoplesFile.readAsStringSync();
  if(jsonArrayString.isEmpty){
    return [];
  }
  List<dynamic> jsonTodos = jsonDecode(jsonArrayString);

  List<Person> persons = [];
  for(final jsonTodo in jsonTodos){
    try{
      persons.add(Person.fromJson(jsonTodo) );
    } catch(e) {
      print("ERROR: could not read from file: $e");
      exit(1);
    }
  }
  return persons;
}

void savePeople(List<Person> persons){
  if(!peoplesFile.existsSync()){
    peoplesFile.createSync(recursive: true);
  }
  String jsonArrayString = jsonEncode(persons);
  peoplesFile.writeAsStringSync(jsonArrayString);
}
