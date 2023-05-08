import 'package:flutter/material.dart';

class Sports {
  static IconData spots({required String sport, double size = 15}) {
    switch (sport) {
      case "football":
        return Icons.sports_soccer;
      case "cricket":
        return Icons.sports_cricket;
      case "volley ball":
        return Icons.sports_volleyball;
      case "basket ball":
        return Icons.sports_basketball;
      case "badminton":
        return Icons.sports_soccer;
      default:
        return Icons.sports_soccer;
    }
  }
}
