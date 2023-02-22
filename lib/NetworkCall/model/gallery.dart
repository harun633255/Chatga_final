
import 'dart:convert';
List<Gallery> GalleryJson(String str) => List<Gallery>.from(json.decode(str).map((x) => Gallery.fromJson(x)));

String postToJson(List<Gallery> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gallery {
String? id;
String? name;
String? image;


Gallery(
{this.id, this.name, this.image, });

Gallery.fromJson(Map<String, dynamic> json) {
id = json['id'];
name = json['name'];
image = json['image'];

}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['name'] = this.name;
data['image'] = this.image;
return data;
}
}
