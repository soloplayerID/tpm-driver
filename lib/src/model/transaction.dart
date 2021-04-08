// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:TPMDriver/src/model/warehouse.dart';
import 'package:TPMDriver/src/response/pembelian.dart';
import 'package:TPMDriver/src/response/penjualan.dart';

class TransactionModel {
  bool isloading = false;
  bool isSuccess = false;
  int idWarehouse = 0;
  String wareouseName = "ALL";
  WarehouseMod warehouse;
  List<WarehouseMod> warehouses = new List<WarehouseMod>();
  Penjualan penjualan = new Penjualan();
  Pembelian pembelian = new Pembelian();
  TabController tabController;
}
