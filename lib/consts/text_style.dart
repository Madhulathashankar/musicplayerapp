
import 'package:flutter/material.dart';
import 'package:musicplayerapp/consts/colors.dart';

const bold ="bold";
const regular ="regular";
ourstyle({Family = "regular",double? size = 14, color = whiteColor}) {
  return TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontFamily: Family,
  );
}