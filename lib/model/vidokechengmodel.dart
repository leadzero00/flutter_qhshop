class VideoKechengModel {
  String code;
  String message;
  List<VideoKechengData> data;

  VideoKechengModel({this.code, this.message, this.data});

  VideoKechengModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<VideoKechengData>();
      json['data'].forEach((v) {
        data.add(new VideoKechengData.fromJson(v));
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

class VideoKechengData {
  String image;
  String title;
  String price;
  String howmany;
  String url;

  VideoKechengData({this.image, this.title, this.price, this.howmany, this.url});

  VideoKechengData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
    howmany = json['howmany'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['howmany'] = this.howmany;
    data['url'] = this.url;
    return data;
  }
}
