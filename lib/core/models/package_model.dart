class packagemodel {
  String? ser;
  String? name;
  String? qty;
  String? pri;
  String? pri_dis;
  String? user;
  String? st;
  String? payment;
  String? description;
  String? descriptionSub;
  String? img;
  String? data_update;

  packagemodel(
      {this.ser,
      this.name,
      this.qty,
      this.pri,
      this.pri_dis,
      this.user,
      this.st,
      this.payment,
      this.description,
      this.descriptionSub,
      this.img,
      this.data_update});

  packagemodel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    name = json['name'];
    qty = json['qty'];
    pri = json['pri'];
    pri_dis = json['pri_dis'];
    user = json['user'];
    st = json['st'];
    payment = json['payment'];
    description = json['description'];
    descriptionSub = json['descriptionSub'];
    img = json['img'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['pri'] = this.pri;
    data['pri_dis'] = this.pri_dis;
    data['user'] = this.user;
    data['st'] = this.st;
    data['payment'] = this.payment;
    data['description'] = this.description;
    data['descriptionSub'] = this.descriptionSub;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    return data;
  }
}
