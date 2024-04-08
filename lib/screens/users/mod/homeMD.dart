import 'package:flutter/material.dart';

class HomeMD extends StatefulWidget {
  const HomeMD({super.key});

  @override
  State<HomeMD> createState() => _HomeMDState();
}

class _HomeMDState extends State<HomeMD> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('H O M E   md'),
      ),
    );
  }
}