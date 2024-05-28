class assetmodel {
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
  String? contentSub;
  String? corverImg;
  String? place;
  String? s_datex;
  String? l_datex;
  String? addr;
  String? poitScore;
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
  String? st;
  String? dtype;
  String? amphures;
  String? provinces;
  String? provinces_th;
  String? provinces_en;
  String? amphures_th;
  String? amphures_en;
  String? dataUpdate;

  assetmodel(
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
      this.contentSub,
      this.corverImg,
      this.place,
      this.s_datex,
      this.l_datex,
      this.addr,
      this.poitScore,
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
      this.st,
      this.dtype,
      this.amphures,
      this.provinces,
      this.provinces_th,
      this.provinces_en,
      this.amphures_th,
      this.amphures_en,
      this.dataUpdate});

  assetmodel.fromJson(Map<String, dynamic> json) {
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
    contentSub = json['content_sub'];
    corverImg = json['corver_img'];
    place = json['place'];
    s_datex = json['s_datex'];
    l_datex = json['l_datex'];
    addr = json['addr'];
    poitScore = json['poit_score'];
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
    st = json['st'];
    dtype = json['dtype'];
    amphures = json['amphures'];
    provinces = json['provinces'];

    provinces_th = json['provinces_th'];
    provinces_en = json['provinces_en'];
    amphures_th = json['amphures_th'];
    amphures_en = json['amphures_en'];

    dataUpdate = json['data_update'];
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
    data['content_sub'] = this.contentSub;
    data['corver_img'] = this.corverImg;
    data['place'] = this.place;
    data['s_datex'] = this.s_datex;
    data['l_datex'] = this.l_datex;
    data['addr'] = this.addr;
    data['poit_score'] = this.poitScore;
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
    data['st'] = this.st;
    data['dtype'] = this.dtype;
    data['amphures'] = this.amphures;
    data['provinces'] = this.provinces;
    data['provinces_th'] = this.provinces_th;
    data['provinces_en'] = this.provinces_en;
    data['amphures_th'] = this.amphures_th;
    data['amphures_en'] = this.amphures_en;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
