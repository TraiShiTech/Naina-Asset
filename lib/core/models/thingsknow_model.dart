class Thingsknow_model {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? asset_ser;
  String? things_ser;
  String? name;
  String? icon;
  String? dataUpdate;

  Thingsknow_model(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.asset_ser,
      this.things_ser,
      this.name,
      this.icon,
      this.dataUpdate});

  Thingsknow_model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    asset_ser = json['asset_ser'];
    things_ser = json['things_ser'];
    name = json['name'];
    icon = json['icon'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['asset_ser'] = this.asset_ser;
    data['things_ser'] = this.things_ser;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
