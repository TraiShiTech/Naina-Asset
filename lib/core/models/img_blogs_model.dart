// ImgBlogs_model
class ImgBlogs_model {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? assetSer;
  String? img;
  String? st;
  String? dataUpdate;

  ImgBlogs_model(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.assetSer,
      this.img,
      this.st,
      this.dataUpdate});

  ImgBlogs_model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    assetSer = json['asset_ser'];
    img = json['img'];
    st = json['st'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['asset_ser'] = this.assetSer;
    data['img'] = this.img;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
