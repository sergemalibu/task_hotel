import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task_flutter/pages/hotel/hotel_page.dart';
import 'package:task_flutter/res/app_strings.dart';

class PaidPage extends StatefulWidget {
  const PaidPage({super.key});

  @override
  State<PaidPage> createState() => _PaidPageState();
}

class _PaidPageState extends State<PaidPage> {
  int? rundomNumber;

  generate() {
    final random = Random();
    return random.nextInt(100000) + 10000;
  }

  @override
  void initState() {
    setState(() {
      rundomNumber = generate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          AppStrings.orderPaid,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 50,
              child: const Center(
                child: Text(
                  AppStrings.emoji,
                  style: TextStyle(fontSize: 44),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              AppStrings.orderAccepted,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Text(
              AppStrings.confirmation +
                  rundomNumber.toString() +
                  AppStrings.confirmation2,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => (HotelPage())));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(AppStrings.superr),
        ),
      ),
    );
  }
}
