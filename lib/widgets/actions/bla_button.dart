import "package:flutter/material.dart";
import 'package:blabla/theme/theme.dart';


class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color color;

  const BlaButton({super.key, required this.color, required this.label,this.icon});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color == BlaColors.primary ? BlaColors.backGroundColor : BlaColors.white
        ),
        icon: icon == null ? null : Icon(
          icon,
          color: color == BlaColors.primary ? BlaColors.white : BlaColors.primary,
        ),
        onPressed: () {},
        label: Text(
          label,
          style: BlaTextStyles.label.copyWith(
            color: color == BlaColors.primary ? BlaColors.white : BlaColors.primary
          ),
        ),
    );
  }
}