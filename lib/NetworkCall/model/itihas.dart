
import 'dart:convert';
List<Itihas> ItihasJson(String str) => List<Itihas>.from(json.decode(str).map((x) => Itihas.fromJson(x)));

String postToJson(List<Itihas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itihas {
  String? id;
  String? value;

  //[{"id":"1","value":"Test Bangladesh"}]
  Itihas(
      {this.id, this.value});

  Itihas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}