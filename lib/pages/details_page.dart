import 'package:flutter/material.dart';

 class DetailsPage extends StatelessWidget {
   final String title;
  const DetailsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Text(title),
    );
   
  }
}