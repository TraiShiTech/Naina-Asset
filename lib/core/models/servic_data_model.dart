class ServiceData_Model {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? name;
  String? corver_img;
  String? st;
  String? data_update;
  String? content;
  String? content_sub1;
  String? content_sub2;
  String? content_sub3;

  ServiceData_Model(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.name,
      this.corver_img,
      this.st,
      this.data_update,
      this.content,
      this.content_sub1,
      this.content_sub2,
      this.content_sub3});

  ServiceData_Model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    name = json['name'];
    corver_img = json['corver_img'];
    st = json['st'];
    data_update = json['data_update'];
    content = json['content'];
    content_sub1 = json['content_sub1'];
    content_sub2 = json['content_sub2'];
    content_sub3 = json['content_sub3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['name'] = this.name;
    data['corver_img'] = this.corver_img;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    data['content'] = this.content;
    data['content_sub1'] = this.content_sub1;
    data['content_sub2'] = this.content_sub2;
    data['content_sub3'] = this.content_sub3;
    return data;
  }
}
