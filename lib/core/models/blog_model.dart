class BlogModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? name;
  String? name_th;
  String? content;
  String? content_sub1;
  String? content_sub2;
  String? content_sub3;
  String? corver_img;
  String? st;
  String? view;
  String? data_update;

  BlogModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.name,
      this.name_th,
      this.content,
      this.content_sub1,
      this.content_sub2,
      this.content_sub3,
      this.corver_img,
      this.st,
      this.view,
      this.data_update});

  BlogModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    name = json['name'];
    name_th = json['name_th'];
    content = json['content'];
    content_sub1 = json['content_sub1'];
    content_sub2 = json['content_sub2'];
    content_sub3 = json['content_sub3'];
    corver_img = json['corver_img'];
    st = json['st'];
    view = json['view'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['name'] = this.name;
    data['name_th'] = this.name_th;
    data['content'] = this.content;
    data['content_sub1'] = this.content_sub1;
    data['content_sub2'] = this.content_sub2;
    data['content_sub3'] = this.content_sub3;
    data['corver_img'] = this.corver_img;
    data['st'] = this.st;
    data['view'] = this.view;
    data['data_update'] = this.data_update;
    return data;
  }
}
