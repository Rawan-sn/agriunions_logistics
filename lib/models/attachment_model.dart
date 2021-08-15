import 'dart:convert';

class Attachment {
  String? imageFileName;
  String? image;
  String? path;
  
  Attachment({
    this.imageFileName,
    this.image,
    this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'image_file_name': imageFileName,
      'image': image,
    };
  }

  static Attachment? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
  
    return Attachment(
      imageFileName: map['image_file_name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  static Attachment? fromJson(String source) => fromMap(json.decode(source));
}
