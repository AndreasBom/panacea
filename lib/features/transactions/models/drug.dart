import 'package:flutter/material.dart';

@immutable
class Drug {
  const Drug(
      {required this.name,
      required this.concentration,
      required this.concentrationUnit,
      required this.quantity,
      required this.dosageForm,
      required this.quantityUnit,
      required this.routeOfAdministration,
      required this.atc});

  final String name;
  final double concentration;
  final String concentrationUnit;
  final double quantity;
  final String quantityUnit;
  final String dosageForm;
  final List<String> routeOfAdministration;
  final String atc;

  Map<String, dynamic> toMap() {
    return {
      'drugName': name,
      'concentration': concentration,
      'concentrationUnit': concentrationUnit,
      'quantity': quantity,
      'dosageForm': dosageForm,
      'quantityUnit': quantityUnit,
      'routeOfAdministration': routeOfAdministration,
      'atc': atc
    };
  }
}
