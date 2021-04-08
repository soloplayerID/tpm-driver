import 'package:flutter/material.dart';
import 'package:TPMDriver/src/response/driverResponse.dart';

class UploadDriverModel {
  bool isloading = false;
  bool isSuccess = false;
  DateTime tgl = DateTime.now().toLocal();
  DriverResponse driverResponse = new DriverResponse();
  TextEditingController tglController = new TextEditingController();
  TextEditingController projectCodeController = new TextEditingController();
  TextEditingController statusAktifitasController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController regionController = new TextEditingController();
  TextEditingController hariController = new TextEditingController();
  TextEditingController tujuanController = new TextEditingController();
  TextEditingController userController = new TextEditingController();
  TextEditingController nopolController = new TextEditingController();
  TextEditingController kmAwalController = new TextEditingController();
  TextEditingController pengisianPertamaController =
      new TextEditingController();
  TextEditingController pengisianKeduaController = new TextEditingController();
  TextEditingController kmAkhirController = new TextEditingController();
}
