class DriverResponse {
  bool status;
  List<Data> data;

  DriverResponse({this.status, this.data});

  DriverResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String tgl;
  String projectCode;
  String statusAktifitas;
  String nama;
  String region;
  String hari;
  String tujuan;
  String user;
  String nopol;
  String kmAwal;
  String pengisianPertama;
  String pengisianKedua;
  String kmAkhir;
  String spedometer;
  String createdBy;
  String createdDate;
  String modifiedBy;
  String modifiedDate;

  Data(
      {this.id,
      this.tgl,
      this.projectCode,
      this.statusAktifitas,
      this.nama,
      this.region,
      this.hari,
      this.tujuan,
      this.user,
      this.nopol,
      this.kmAwal,
      this.pengisianPertama,
      this.pengisianKedua,
      this.kmAkhir,
      this.spedometer,
      this.createdBy,
      this.createdDate,
      this.modifiedBy,
      this.modifiedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tgl = json['tgl'];
    projectCode = json['project_code'];
    statusAktifitas = json['status_aktifitas'];
    nama = json['nama'];
    region = json['region'];
    hari = json['hari'];
    tujuan = json['tujuan'];
    user = json['user'];
    nopol = json['nopol'];
    kmAwal = json['km_awal'];
    pengisianPertama = json['pengisian_pertama'];
    pengisianKedua = json['pengisian_kedua'];
    kmAkhir = json['km_akhir'];
    spedometer = json['spedometer'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tgl'] = this.tgl;
    data['project_code'] = this.projectCode;
    data['status_aktifitas'] = this.statusAktifitas;
    data['nama'] = this.nama;
    data['region'] = this.region;
    data['hari'] = this.hari;
    data['tujuan'] = this.tujuan;
    data['user'] = this.user;
    data['nopol'] = this.nopol;
    data['km_awal'] = this.kmAwal;
    data['pengisian_pertama'] = this.pengisianPertama;
    data['pengisian_kedua'] = this.pengisianKedua;
    data['km_akhir'] = this.kmAkhir;
    data['spedometer'] = this.spedometer;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    return data;
  }
}
