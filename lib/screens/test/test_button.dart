import 'package:blabla/theme/theme.dart';
import 'package:blabla/screens/ride_pref/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlaButton(
              icon: Icons.message,
              color: BlaColors.backgroundAccent,
              label: "Contact Volodia"
            ),
            BlaButton(
              icon: Icons.calendar_month,
              color: BlaColors.primary, 
              label: "Request to book"
            ),
          ],
      ),
    );
  }
}