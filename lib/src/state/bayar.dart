import 'package:TPMDriver/src/model/bayar.dart';
import 'package:TPMDriver/src/model/pembayaran.dart';

abstract class PembayaranState {
  void refreshData(BayarModel bayarModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String orderId);
  void removeDataBayar(String error);
  void refreshDataBayar(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
}
