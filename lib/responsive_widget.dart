import 'package:flutter/material.dart';

import 'size_config.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;

  const ResponsiveWidget({
    Key key,
    this.portraitLayout,
    this.landscapeLayout
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
      if(SizeConfig.isPortrait){
        return portraitLayout;
      }
      else{
        return landscapeLayout;
      }
  }
}