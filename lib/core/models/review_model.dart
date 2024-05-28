class reviewmodel {
  String? ser;
  String? datex;
  String? timex;
  String? ser_asset;
  String? user;
  String? description;
  String? poit_score;
  String? name;
  String? st;
  String? data_update;

  reviewmodel(
      {this.ser,
      this.datex,
      this.timex,
      this.ser_asset,
      this.user,
      this.description,
      this.poit_score,
      this.name,
      this.st,
      this.data_update});

  reviewmodel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    ser_asset = json['ser_asset'];
    user = json['user'];
    description = json['description'];
    poit_score = json['poit_score'];
    name = json['name'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['ser_asset'] = this.ser_asset;
    data['user'] = this.user;
    data['description'] = this.description;
    data['poit_score'] = this.poit_score;
    data['name'] = this.name;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
