class assetTypemodel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? name;
  String? name_th;
  String? icon;
  String? st;
  String? dataUpdate;

  assetTypemodel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.name,
      this.icon,
      this.st,
      this.dataUpdate});

  assetTypemodel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    name = json['name'];
    name_th = json['name_th'];
    icon = json['icon'];
    st = json['st'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['name'] = this.name;
    data['name_th'] = this.name_th;
    data['icon'] = this.icon;
    data['st'] = this.st;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
