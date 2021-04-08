import 'package:TPMDriver/src/model/bayar.dart';
import 'package:TPMDriver/src/model/total_nilai.dart';

abstract class TotalNilaiState {
  void refreshData(TotalNilaiModel paketModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String error);
  void onCheckStatus(int idMurid, int idTryout);
  void removeDataBayar(String error);
  void refreshDataBayar(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
}
