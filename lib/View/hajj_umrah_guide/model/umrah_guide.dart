class UmraSteps {
  String? title;
  String? description;
  String? image;

  UmraSteps({this.title, this.description, this.image});

  UmraSteps.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}

// class UmraSteps {
//
//   String? title;
//   List<IhramSteps>? ihramSteps = [];
//
//   UmraSteps({this.title, this.ihramSteps});
//
//   UmraSteps.fromJson(Map<String, dynamic> json){
//     title = json['title'];
//     ihramSteps = json['steps'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['steps'] = ihramSteps;
//     return data;
//   }
// }
