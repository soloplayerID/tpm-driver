import 'package:TPMDriver/src/model/upload_driver.dart';

abstract class UploadDriverState {
  void refreshData(UploadDriverModel uploadDriverModel);
  void onSuccess(String success);
  void onError(String error);
}
