import 'package:flutter/material.dart';

class SizeConfig{
  static double screenWidth;
  static double screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static double heightAvg;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  static double screenWidthSize =0;
  static double screenHeightSize =0;

  void init(BoxConstraints constraints, Orientation orientation){
    if(orientation == Orientation.portrait){
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if(screenWidth < 450){
        isMobilePortrait = true;
      }
    }
    else{
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isMobilePortrait = false;
      isPortrait = false;
    }
    

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
    heightAvg = (_blockHeight + _blockWidth)/2;
    screenWidthSize = screenWidth;
    screenHeightSize = screenHeight;
    print("Width");
    print(_blockWidth);
    print("Height");
    print(_blockHeight);
    print("Height avg");
    print(heightAvg);
  }
}