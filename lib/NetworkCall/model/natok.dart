
import 'dart:convert';
List<Natok> NatokJson(String str) => List<Natok>.from(json.decode(str).map((x) => Natok.fromJson(x)));

String postToJson(List<Natok> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Natok {
  String? id;
  String? name;
  String? youtubelink;
  String? type;

  Natok(
      {this.id, this.name, this.youtubelink, this.type});

  Natok.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    youtubelink = json['youtubelink'];
    type = json['type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['youtubelink'] = this.youtubelink;
    data['type'] = this.type;
    return data;
  }
}