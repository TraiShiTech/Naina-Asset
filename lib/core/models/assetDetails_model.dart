class assetdetails_model {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? docno;
  String? doctax;
  String? typeSer;
  String? name_th;
  String? name_en;
  String? content;
  String? content_sub;
  String? corver_img;
  String? tel;
  String? place;
  String? s_datex;
  String? l_datex;
  String? addr;
  String? poit_score;
  String? amt;
  String? total_dis;
  String? bedroom;
  String? guests;
  String? bathroom;
  String? bed;
  String? qty;
  String? total;
  String? tax;
  String? vat;
  String? pvat;
  String? wht;
  String? nvat;
  String? remark;
  String? refno;
  String? unit;
  String? st;
  String? dtype;
  String? amphures;
  String? provinces;
  String? data_update;
  String? provinces_th;
  String? provinces_en;
  String? amphures_th;
  String? amphures_en;
  String? amphures_code;
  String? unit_ser;
  String? unit_name;

  assetdetails_model(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.docno,
      this.doctax,
      this.typeSer,
      this.name_th,
      this.name_en,
      this.content,
      this.content_sub,
      this.corver_img,
      this.tel,
      this.place,
      this.s_datex,
      this.l_datex,
      this.addr,
      this.poit_score,
      this.amt,
      this.total_dis,
      this.bedroom,
      this.guests,
      this.bathroom,
      this.bed,
      this.qty,
      this.total,
      this.tax,
      this.vat,
      this.pvat,
      this.wht,
      this.nvat,
      this.remark,
      this.refno,
      this.unit,
      this.st,
      this.dtype,
      this.amphures,
      this.provinces,
      this.data_update,
      this.provinces_th,
      this.provinces_en,
      this.amphures_th,
      this.amphures_en,
      this.amphures_code,
      this.unit_ser,
      this.unit_name});

  assetdetails_model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    docno = json['docno'];
    doctax = json['doctax'];
    typeSer = json['type_ser'];
    name_th = json['name_th'];
    name_en = json['name_en'];
    content = json['content'];
    content_sub = json['content_sub'];
    corver_img = json['corver_img'];
    tel = json['tel'];
    place = json['place'];
    s_datex = json['s_datex'];
    l_datex = json['l_datex'];
    addr = json['addr'];
    poit_score = json['poit_score'];
    amt = json['amt'];
    total_dis = json['total_dis'];
    bedroom = json['bedroom'];
    guests = json['guests'];
    bathroom = json['bathroom'];
    bed = json['bed'];
    qty = json['qty'];
    total = json['total'];
    tax = json['tax'];
    vat = json['vat'];
    pvat = json['pvat'];
    wht = json['wht'];
    nvat = json['nvat'];
    remark = json['remark'];
    refno = json['refno'];
    unit = json['unit'];
    st = json['st'];
    dtype = json['dtype'];
    amphures = json['amphures'];
    provinces = json['provinces'];
    data_update = json['data_update'];
    provinces_th = json['provinces_th'];
    provinces_en = json['provinces_en'];
    amphures_th = json['amphures_th'];
    amphures_en = json['amphures_en'];
    amphures_code = json['amphures_code'];
    unit_ser = json['unit_ser'];
    unit_name = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['type_ser'] = this.typeSer;
    data['name_th'] = this.name_th;
    data['name_en'] = this.name_en;
    data['content'] = this.content;
    data['content_sub'] = this.content_sub;
    data['corver_img'] = this.corver_img;
    data['tel'] = this.tel;
    data['place'] = this.place;
    data['s_datex'] = this.s_datex;
    data['l_datex'] = this.l_datex;
    data['addr'] = this.addr;
    data['poit_score'] = this.poit_score;
    data['amt'] = this.amt;
    data['total_dis'] = this.total_dis;
    data['bedroom'] = this.bedroom;
    data['guests'] = this.guests;
    data['bathroom'] = this.bathroom;
    data['bed'] = this.bed;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['tax'] = this.tax;
    data['vat'] = this.vat;
    data['pvat'] = this.pvat;
    data['wht'] = this.wht;
    data['nvat'] = this.nvat;
    data['remark'] = this.remark;
    data['refno'] = this.refno;
    data['unit'] = this.unit;
    data['st'] = this.st;
    data['dtype'] = this.dtype;
    data['amphures'] = this.amphures;
    data['provinces'] = this.provinces;
    data['data_update'] = this.data_update;
    data['provinces_th'] = this.provinces_th;
    data['provinces_en'] = this.provinces_en;
    data['amphures_th'] = this.amphures_th;
    data['amphures_en'] = this.amphures_en;
    data['amphures_code'] = this.amphures_code;
    data['unit_ser'] = this.unit_ser;
    data['unit_name'] = this.unit_name;
    return data;
  }
}
