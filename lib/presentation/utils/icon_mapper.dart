import 'package:flutter/material.dart';

class IconMapper {
  static IconData getIconForSpecialty(String specialty) {
    switch (specialty.toLowerCase()) {
      case 'troubleshoot_sharp':
        return (Icons.troubleshoot_sharp);
      case 'heart_broken':
        return (Icons.heart_broken);
      case 'local_hospital':
        return (Icons.local_hospital);
      case 'psychology':
        return (Icons.psychology);
      default:
        return (Icons.medical_services);
    }
  }
}
