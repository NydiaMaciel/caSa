import 'package:flutter/material.dart';

class ModUserLayout extends StatelessWidget {
  //const ModUserLayout({super.key});
  Widget mobileScaffold;
  Widget? desktopScaffold;

  ModUserLayout({
    required this.mobileScaffold,
    this.desktopScaffold,
  });

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth<1100){
        return mobileScaffold;
      }else{
        return desktopScaffold!;
      }
    });
  }
}