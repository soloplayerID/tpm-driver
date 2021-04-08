import 'dart:io';

import 'package:TPMDriver/src/model/upload_driver.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TPMDriver/helper/getStorage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:TPMDriver/src/state/upload_driver.dart';
import 'package:TPMDriver/src/presenter/upload_driver.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:TPMDriver/helper/paths.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class Service {
  Future<int> submitSubscription(
      {File file,
      String filename,
      String idMurid,
      String tgl,
      String projectCode,
      String statusAktivitas,
      String nama,
      String region,
      String hari,
      String tujuan,
      String user,
      String nopol,
      String kmawal,
      String pengisianPertama,
      String pengisianKedua,
      String kmakhir,
      BuildContext context}) async {
    ///MultiPart request

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${Paths.BASEURLTPM}${Paths.DRIVERTPM}"),
    );
    Map<String, String> headers = {
      "accept": "application/json",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'spedometer',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "tgl": tgl,
      "project_code": projectCode,
      "status_aktifitas": statusAktivitas,
      "nama": nama,
      "region": region,
      "hari": hari,
      "tujuan": tujuan,
      "user": user,
      "nopol": nopol,
      "km_awal": kmawal,
      "pengisian_pertama": pengisianPertama,
      "pengisian_kedua": pengisianKedua,
      "km_akhir": kmakhir,
    });
    print(request.fields);
    print("request: " + request.toString());
    final res = await request.send();
    final respStr = await res.stream.bytesToString();
    print("This is response:" + respStr.toString());
    if (res.statusCode == 200) {
      Toast.show("Berhasil", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.popAndPushNamed(context, '/upload');
    }
    return res.statusCode;
  }
}

class DriverUpload extends StatefulWidget {
  @override
  _DriverUploadState createState() => _DriverUploadState();
}

class _DriverUploadState extends State<DriverUpload>
    with SingleTickerProviderStateMixin
    implements UploadDriverState {
  File _image;
  AnimationController _controller;
  String fileName;
  UploadDriverModel _uploadDriverModel;
  UploadDriverPresenter _uploadDriverPresenter;
  final picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  _DriverUploadState() {
    this._uploadDriverPresenter = new UploadDriverPresenter();
  }

  @override
  void initState() {
    this._uploadDriverPresenter.view = this;
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Icon(LineIcons.arrow_left),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Upload Driver',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     RaisedButton(
                    //       padding: EdgeInsets.all(1),
                    //       color: Colors.grey,
                    //       disabledColor: Colors.red,
                    //       onPressed: () async {
                    //         SharedPreferences preferences =
                    //             await SharedPreferences.getInstance();
                    //         preferences.clear();
                    //         Navigator.pushNamed(context, "/");
                    //       },
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(2),
                    //       ),
                    //       child: Text(
                    //         'Simpan',
                    //         style: GoogleFonts.poppins(
                    //           color: Colors.white,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 1400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffeeeeee),
                              blurRadius: 7,
                            )
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.blue,
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                            _image,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 80,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff2D8EFF),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: ExactAssetImage(
                                                    "assets/img/spedo.png",
                                                  )))),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Material(
                                child: InkWell(
                                  child: Text("Spedometer",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      )),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Ambil Gambar"),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  GestureDetector(
                                                    child: Text(
                                                        'Ambil dari Kamera'),
                                                    onTap: () {
                                                      getImage();
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                  ),
                                                  GestureDetector(
                                                    child: Text(
                                                        'Ambil dari Galery'),
                                                    onTap: () {
                                                      getImageGalery();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 50,
                                                    child: RaisedButton(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      color: Colors.blue,
                                                      disabledColor: Colors.red,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop('Success');
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      child: Text(
                                                        'Selesai',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text('Tanggal'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              // initialValue: new DateFormat("d, MMMM - y").format(this._signUpModel.tanggalLahir.toLocal()).toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: ' Tanggal',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                              onTap: (() => {this.showCalender()}),
                              controller: _uploadDriverModel.tglController,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Project Code'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller:
                                  _uploadDriverModel.projectCodeController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String projectCode) {},
                              decoration: InputDecoration(
                                  hintText: ' Project Code',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Status Aktivitas'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller:
                                  _uploadDriverModel.statusAktifitasController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String statusAktivitas) {},
                              decoration: InputDecoration(
                                  hintText: 'Status aktivitas',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Region'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.regionController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String region) {},
                              decoration: InputDecoration(
                                  hintText: 'Region',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Hari'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.hariController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String hari) {},
                              decoration: InputDecoration(
                                  hintText: 'hari',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Tujuan'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.tujuanController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String tujuan) {},
                              decoration: InputDecoration(
                                  hintText: 'Tujuan',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('User'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.userController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String user) {},
                              decoration: InputDecoration(
                                  hintText: 'User',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Nopol'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.nopolController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String nopol) {},
                              decoration: InputDecoration(
                                  hintText: 'nopol',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('KM Awal'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.kmAwalController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (String kmawal) {},
                              decoration: InputDecoration(
                                  hintText: 'kmawal',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Pengisian Pertama'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller:
                                  _uploadDriverModel.pengisianPertamaController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (String pengisianPertama) {},
                              decoration: InputDecoration(
                                  hintText: 'Pengisian pertama',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Pengisian kedua'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller:
                                  _uploadDriverModel.pengisianKeduaController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (String pengisianKedua) {},
                              decoration: InputDecoration(
                                  hintText: 'pengisian kedua',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('KM akhir'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              controller: _uploadDriverModel.kmAkhirController,
                              validator: _userPasswordValidation,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onChanged: (String kmakhir) {},
                              decoration: InputDecoration(
                                  hintText: 'km akhir',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              width: double.infinity,
                              child: RaisedButton(
                                color: Colors.green,
                                child: Text(
                                  "Kirim",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  // if (_image != null ||
                                  //     _inputNamaController.text != '' ||
                                  //     _inputEmailController.text != '' ||
                                  //     _inputPasswordController.text !=
                                  //         '' ||
                                  //     _inputPhoneController.text != '' ||
                                  //     _inputAlamatController.text != '') {
                                  if (_image != null) {
                                    print('test');
                                    Service service = Service();

                                    service.submitSubscription(
                                        file: _image,
                                        filename: fileName,
                                        idMurid: GetStorage().read(ID_MURID),
                                        tgl: _uploadDriverModel
                                            .tglController.text,
                                        projectCode: _uploadDriverModel
                                            .projectCodeController.text,
                                        statusAktivitas: _uploadDriverModel
                                            .statusAktifitasController.text,
                                        nama: _uploadDriverModel
                                            .userController.text,
                                        region: _uploadDriverModel
                                            .regionController.text,
                                        hari: _uploadDriverModel
                                            .hariController.text,
                                        tujuan: _uploadDriverModel
                                            .tujuanController.text,
                                        user: _uploadDriverModel
                                            .userController.text,
                                        nopol: _uploadDriverModel
                                            .nopolController.text,
                                        kmawal: _uploadDriverModel
                                            .kmAwalController.text,
                                        pengisianPertama: _uploadDriverModel
                                            .pengisianPertamaController.text,
                                        pengisianKedua: _uploadDriverModel
                                            .pengisianKeduaController.text,
                                        kmakhir: _uploadDriverModel
                                            .kmAkhirController.text,
                                        context: context);
                                  } else {
                                    Toast.show(
                                        "Foto Spedometer harus diisi! :)",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }
                                  // } else {
                                  //   Toast.show(
                                  //       "Harus terisi semua! :)", context,
                                  //       duration: Toast.LENGTH_LONG,
                                  //       gravity: Toast.BOTTOM);
                                  // }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGalery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void showCalender() {
    // ignore: todo
    // TODO: implement showCalender.
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 1, 11, 33),
            lastDate: DateTime(2023, 1, 1, 11, 33))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _uploadDriverModel.tglController.text = DateFormat("yyyy-mm-dd")
            .format(this._uploadDriverModel.tgl.toLocal())
            .toString();
        // this.refreshData(this._profileModel);
      });
    });
  }

  String _userPasswordValidation(String value) {
    if (value.isEmpty) {
      return "field tidak boleh kosong";
    } else {
      return null;
    }
  }

  @override
  void onError(String error) {
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Toast.show("$success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void refreshData(UploadDriverModel uploadDriverModel) {
    setState(() {
      this._uploadDriverModel = uploadDriverModel;
    });
  }
}
