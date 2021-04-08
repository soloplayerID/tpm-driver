import 'package:TPMDriver/screen/fragment/pembayaran_detail.dart';
// ignore: unused_import
import 'package:TPMDriver/screen/fragment/profile_detail_nilai.dart';
import 'package:TPMDriver/screen/fragment/profile_edit_profile.dart';
import 'package:TPMDriver/screen/fragment/profile_history.dart';
import 'package:TPMDriver/screen/fragment/profile_info_app.dart';
import 'package:TPMDriver/screen/fragment/profile_info_layanan.dart';
import 'package:TPMDriver/screen/fragment/profile_kebijakan_privacy.dart';
import 'package:TPMDriver/screen/fragment/profile_nilai.dart';
import 'package:TPMDriver/screen/fragment/profile_syarat_ketentuan.dart';
import 'package:TPMDriver/screen/fragment/profile_tagihan.dart';
import 'package:TPMDriver/screen/fragment/verifitaction.dart';
import 'package:TPMDriver/screen/fragment/pembayaran_list.dart';
import 'package:TPMDriver/screen/onboarding_page.dart';
import 'package:TPMDriver/screen/pembayaran_info.dart';
import 'package:TPMDriver/screen/profile_detail.dart';
import 'package:TPMDriver/screen/signup.dart';
import 'package:TPMDriver/screen/upload_driver.dart';
// ignore: unused_import
import 'package:TPMDriver/screen/tryout.dart';
import 'package:TPMDriver/screen/upload_driver_home.dart';
import 'package:TPMDriver/screen/upload_driver_list.dart';
import 'package:flutter/material.dart';
import 'package:TPMDriver/screen/home.dart';
import 'package:TPMDriver/screen/login.dart';
import 'package:TPMDriver/screen/landing_page.dart';

final routes = {
  '/': (BuildContext context) => new OnBoarding(),
  '/landing': (BuildContext context) => new LandingScreen(),
  '/login': (BuildContext context) => new Login(),
  '/signup': (BuildContext context) => new SignUp(),
  '/home': (BuildContext context) => new Home(),
  '/upload': (BuildContext context) => new DriverUpload(),
  '/home_driver': (BuildContext context) => new HomeDriver(),
  '/list_driver': (BuildContext context) => new DriverList(),
};
