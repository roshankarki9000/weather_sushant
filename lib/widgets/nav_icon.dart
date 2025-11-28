import 'package:flutter/material.dart';

//! This widget is for Navugation Icons n HomeScereen
class NavIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const NavIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 26),
      ),
    );
  }
}
