import 'package:panacea_app/features/transactions/models/patient.dart';

import 'consumption_describtion.dart';

class DrugConsumer {
  final Patient? patient;
  final ConsumptionDescription? consumptionDescription;

  DrugConsumer({this.patient, this.consumptionDescription});
}

