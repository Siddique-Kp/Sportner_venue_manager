import 'package:flutter/material.dart';

class Sports {
  static IconData spots({required String sport, double size = 15}) {
    switch (sport) {
      case "football":
        return Icons.sports_soccer;
      case "Cricket":
        return Icons.sports_cricket;
      case "Football":
        return Icons.sports_soccer;
      case "Volley ball":
        return Icons.sports_volleyball;
      case "Basket ball":
        return Icons.sports_basketball;
      case "Badminton":
        return Icons.sports_soccer;
      default:
        return Icons.sports_soccer;
    }
  }
}