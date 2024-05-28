class Specialknow_model {
  String? datex;
  String? timex;
  String? user;
  String? asset_ser;
  String? name;
  String? content;
  String? icon;
  String? data_update;

  Specialknow_model(
      {this.datex,
      this.timex,
      this.user,
      this.asset_ser,
      this.name,
      this.content,
      this.icon,
      this.data_update});

  Specialknow_model.fromJson(Map<String, dynamic> json) {
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    asset_ser = json['asset_ser'];
    name = json['name'];
    content = json['content'];
    icon = json['icon'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['asset_ser'] = this.asset_ser;
    data['name'] = this.name;
    data['content'] = this.content;
    data['icon'] = this.icon;
    data['data_update'] = this.data_update;
    return data;
  }
}
