import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';

class AdMobService {
  String getBannerAdUnitId() {
    // iOSとAndroidで広告ユニットIDを分岐させる
    return (Platform.isIOS) ? 'ca-app-pub-1585283309075901/3447956422':
      'ca-app-pub-1585283309075901/4704912369';
  }

  // 表示するバナー広告の高さを計算
  double getHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final percent = (height * 0.06).toDouble();
    return percent;
  }
}

Widget adMobWidget(BuildContext context) {
  return AdmobBanner(
    adUnitId: AdMobService().getBannerAdUnitId(),
    adSize: AdmobBannerSize(
      width: MediaQuery.of(context).size.width.toInt(),
      height: AdMobService().getHeight(context).toInt(),
      name: 'SMART_BANNER',
    ),
  );
}