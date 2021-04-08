import 'package:TPMDriver/src/model/bayar.dart';
import 'package:TPMDriver/src/model/total_nilai.dart';
import 'package:TPMDriver/src/model/total_nilai_detail.dart';
import 'package:TPMDriver/src/model/tryout.dart';
import 'package:flutter/material.dart';

abstract class ReportNilaiState {
  void refreshData(TotalNilaiDetailModel totalNilaiDetailModel);
  void refreshDataModel(TryoutModel tryoutModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String error);
  void showMatpel(BuildContext context);
  void onCheckBayar(BayarModel bayarModel);
}
