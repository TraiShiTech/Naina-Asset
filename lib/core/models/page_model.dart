class PageModel {
  String? ser;
  String? datex;
  String? timex;
  String? name;
  String? corver_img;
  String? st;
  String? data_update;

  PageModel(
      {this.ser,
      this.datex,
      this.timex,
      this.name,
      this.corver_img,
      this.st,
      this.data_update});

  PageModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    name = json['name'];
    corver_img = json['corver_img'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['name'] = this.name;
    data['corver_img'] = this.corver_img;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
