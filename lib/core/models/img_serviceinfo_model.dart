class Imgserviceinfo_model {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? service_ser;
  String? img;
  String? img_type;
  String? st;
  String? dataUpdate;

  Imgserviceinfo_model(
      {this.ser, this.datex, this.timex, this.user, this.service_ser, this.img, this.st, this.dataUpdate});

  Imgserviceinfo_model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    service_ser = json['service_ser'];
    img = json['img'];
    img_type = json['img_type'];
    st = json['st'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['service_ser'] = this.service_ser;
    data['img'] = this.img;
    data['img_type'] = this.img_type;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
