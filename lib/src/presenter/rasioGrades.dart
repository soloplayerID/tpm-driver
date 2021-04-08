import 'dart:convert';

import 'package:TPMDriver/src/model/bayar.dart';
import 'package:TPMDriver/src/model/paket.dart';
import 'package:TPMDriver/src/model/rasioGrades.dart';

import 'package:TPMDriver/src/resources/historyTryoutApi.dart';
import 'package:TPMDriver/src/resources/bayarApi.dart';
import 'package:TPMDriver/src/state/RasioGrades.dart';
import 'package:TPMDriver/src/state/total_nilai.dart';

abstract class RasioGradesPresenterAbstract {
  set view(RasioGradeState view) {}
  void getData(int idMurid, int idTryout, int idTujuanSekolah) {}
}

class RasioGradesPresenter implements RasioGradesPresenterAbstract {
  RasioGradeModel _rasioGradeModel = new RasioGradeModel();
  RasioGradeState _rasioGradeState;
  HistoryTryoutApi _historyTryoutApi = new HistoryTryoutApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(RasioGradeState view) {
    // ignore: todo
    // TODO: implement view
    this._rasioGradeState = view;
    this._rasioGradeState.refreshData(this._rasioGradeModel);
  }

  @override
  void getData(int idMurid, int idTryout, int idTujuanSekolah) {
    print('test');
    this._rasioGradeModel.isloading = true;
    this._rasioGradeState.refreshData(this._rasioGradeModel);
    this
        ._historyTryoutApi
        .getRasioGrades(idMurid, idTryout, idTujuanSekolah)
        .then((value) {
      value.dataTryout.forEach((element) {
        this._rasioGradeModel.rasioGrade.add(new RasioGrade(
              id: element.id,
              idPaket: element.idPaket,
              status: element.status,
              totalNilai: element.totalNilai,
              namaSekolah: element.dataSekolah[0].namaSekolah,
              kkm: element.dataSekolah[0].kkm,
              grade: element.dataSekolah[0].grades,
            ));
      });
      this._rasioGradeModel.rasioGradeResponse = value;
      this._rasioGradeModel.isloading = false;
      this._rasioGradeState.refreshData(this._rasioGradeModel);
    }).catchError((err) {
      print(err.toString());
      this._rasioGradeModel.isloading = false;
      this._rasioGradeState.refreshData(this._rasioGradeModel);
      this._rasioGradeState.onError(err.toString());
    });
  }
}
