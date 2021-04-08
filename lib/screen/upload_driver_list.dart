import 'package:TPMDriver/helper/getStorage.dart';
import 'package:TPMDriver/screen/fragment/loading.dart';
import 'package:TPMDriver/src/model/upload_driver.dart';
import 'package:flutter/material.dart';
import 'package:TPMDriver/src/state/upload_driver.dart';
import 'package:TPMDriver/src/presenter/upload_driver.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class DriverList extends StatefulWidget {
  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList>
    with SingleTickerProviderStateMixin
    implements UploadDriverState {
  AnimationController _controller;
  String fileName;
  UploadDriverModel _uploadDriverModel;
  UploadDriverPresenter _uploadDriverPresenter;
  final picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  _DriverListState() {
    this._uploadDriverPresenter = new UploadDriverPresenter();
  }

  @override
  void initState() {
    this._uploadDriverPresenter.view = this;
    _controller = AnimationController(vsync: this);
    this._uploadDriverPresenter.getData(GetStorage().read(ID_MURID));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._uploadDriverModel.isloading
          ? Loading()
          : Container(
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
                                'List Upload Driver Terbaru',
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
                    padding: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffecedf2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            height: 750,
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
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(label: Text("Tgl")),
                                      DataColumn(label: Text("Nopol")),
                                      DataColumn(label: Text("Region")),
                                      DataColumn(label: Text("Hari")),
                                    ],
                                    rows: this
                                        ._uploadDriverModel
                                        .driverResponse
                                        .data
                                        .map(
                                          (avenger) => DataRow(cells: [
                                            DataCell(
                                              Text(avenger.tgl),
                                              onTap: () {
                                                // write your code..
                                              },
                                            ),
                                            DataCell(
                                              Text(avenger.nopol),
                                            ),
                                            DataCell(
                                              Text(avenger.region),
                                            ),
                                            DataCell(
                                              Text(avenger.hari),
                                            ),
                                          ]),
                                        )
                                        .toList(),
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
