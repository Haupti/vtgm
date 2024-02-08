import 'dart:math';
class Style {
  Map<String, String> property = {};
  Style({String? color, String? width, String? height}){
    if(color != null){
      property["color"] = color;
    }
    if(width != null){
      property["width"] = width;
    }
    if(height != null){
      property["height"] = height;
    }
  }
  String inline(){
    String inlineStyle = "";
    for(var key in property.keys) {
      inlineStyle = "$inlineStyle$key:${property[key]}";
    }
    return inlineStyle;
  }
  static String inlineProp(Style? style){
    if(style == null){
      return "";
    } else {
      return " style=\"${style.inline()}\"";
    }
  }
}

class Component{
  String render() => "";
}

String renderMany(List<Component> components){
  String result = "";
  for(var c in components){
    result = "$result$c";
  }
  return result;
}


class H1 implements Component{
  Style? style;
  String text;
  H1({this.style, required this.text});

  @override
  String render(){
    return """
      <h1${Style.inlineProp(style)}> $text </h1>
    """;
  }
}

class Anchor implements Component{
  Style? style;
  String href;
  String text;
  Anchor({this.style, required this.href, required this.text});

  @override
  String render(){
    return """
      <a${Style.inlineProp(style)} href="$href"> $text </a>
    """;
  }
}

class Div implements Component{
  Style? style;
  List<Component> children;

  Div({required this.children, this.style });
  @override
  String render(){
    return """
      <a${Style.inlineProp(style)}>
        ${renderMany(children)}
      </a>
    """;
  }
}


String generateId() {
  var r = Random();
  return String.fromCharCodes(List.generate(8, (index) => r.nextInt(33) + 89));
}
class FormInput implements Component {
  Style? style;
  String labelText;
  String type;
  String name;
  bool required = true;

  FormInput({required this.type, required this.name, required this.labelText, this.required = true, this.style});

  @override
  String render() {
    String id = generateId();
    String requiredFlag = required ? "required" : "";
    return """
      <div${Style.inlineProp(style)}>
        <label for="$id">$labelText</label>
        <input type="$type" name="$name" id="$id" $requiredFlag/>
      </div>
    """;
  }
}

class Form implements Component{
  List<FormInput> formInputs;
  String action;
  String submitButtonText;

  Form({required this.formInputs, required this.action, required this.submitButtonText});

  @override
  String render(){
    return """
      <form action="$action" method="get">
        renderMany(formInputs);
        <input type="submit" value="$submitButtonText" />
      </form>
    """;
  }
}
