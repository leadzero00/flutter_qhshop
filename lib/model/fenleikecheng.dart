class FenleiKechengModel {
  String code;
  String message;
  List<FenleiKeData> data;

  FenleiKechengModel({this.code, this.message, this.data});

  FenleiKechengModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<FenleiKeData>();
      json['data'].forEach((v) {
        data.add(new FenleiKeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FenleiKeData {
  String image;
  String title;
  String teacher;
  String classaddress;
  String price;
  String url;

  FenleiKeData(
      {this.image,
      this.title,
      this.teacher,
      this.classaddress,
      this.price,
      this.url});

  FenleiKeData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    teacher = json['teacher'];
    classaddress = json['classaddress'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['teacher'] = this.teacher;
    data['classaddress'] = this.classaddress;
    data['price'] = this.price;
    data['url'] = this.url;
    return data;
  }
}

