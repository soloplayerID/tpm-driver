import 'package:TPMDriver/src/model/jenjang.dart';

abstract class JenjangState {
  void refreshData(JenjangModel jenjangModel);
  void onSuccess(String success);
  void onError(String error);
}
