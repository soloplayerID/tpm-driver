import 'package:TPMDriver/src/model/upload_driver.dart';
import 'package:TPMDriver/src/state/upload_driver.dart';
import 'package:TPMDriver/src/resources/driverApi.dart';

abstract class UploadDriverPresenterAbstract {
  set view(UploadDriverState view);
  void getData(String idMurid) {}
}

class UploadDriverPresenter implements UploadDriverPresenterAbstract {
  UploadDriverModel _uploadDriverModel = new UploadDriverModel();
  UploadDriverState _uploadDriverState;
  DriverActivityApi _driverActivityApi = new DriverActivityApi();

  @override
  set view(UploadDriverState view) {
    this._uploadDriverState = view;
    this._uploadDriverState.refreshData(this._uploadDriverModel);
  }

  @override
  void getData(String idMurid) {
    print(idMurid);
    this._uploadDriverModel.isloading = true;
    this._uploadDriverState.refreshData(this._uploadDriverModel);
    this._driverActivityApi.getDriver(idMurid).then((value) {
      this._uploadDriverModel.driverResponse = value;
      this._uploadDriverModel.isloading = false;
      this._uploadDriverState.refreshData(this._uploadDriverModel);
    });
  }
}
