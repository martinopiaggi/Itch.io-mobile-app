import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_app_bar.dart';

class FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Text('Favorites Page with favorites games etc'),
        ),
      );
  }
}
