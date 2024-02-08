import "dart:convert";
import "dart:io";

class Person {
  String name;
  Person(this.name);

  Map<String, dynamic> toJson(Person person) {
    return {
      "name": person.name,
    };
  }
}
