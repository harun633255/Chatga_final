
import 'dart:convert';
List<Sobdo> SobdoJson(String str) => List<Sobdo>.from(json.decode(str).map((x) => Sobdo.fromJson(x)));

String postToJson(List<Sobdo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sobdo {
  String? id;
  String? ctg;
  String? shabdasomuho;
  String? catid;
  

  Sobdo(
      {this.id, this.ctg, this.shabdasomuho, this.catid});

  Sobdo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ctg = json['ctg'];
    shabdasomuho = json['shabdasomuho'];
    catid = json['catid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ctg'] = this.ctg;
    data['shabdasomuho'] = this.shabdasomuho;
    data['catid'] = this.catid;
    return data;
  }
}