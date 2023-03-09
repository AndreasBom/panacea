import 'package:panacea_app/features/transactions/models/consumption_describtion.dart';
import 'package:panacea_app/features/transactions/models/drug.dart';
import 'package:panacea_app/features/transactions/models/drug_consumer.dart';
import 'package:panacea_app/features/transactions/models/patient.dart';
import 'package:panacea_app/features/transactions/models/user.dart';

class WithdrawRecord {
  final Drug drug;
  final double drugAmountWithdrawn;
  final double drugAmountLeft;
  final DrugConsumer drugConsumer;
  final int timestamp;
  final User user;

  WithdrawRecord.fromMap(Map<String, dynamic> map)
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        drugConsumer = DrugConsumer(
            patient: map['patientId'] != null ? Patient(
                patientId: map['patientId'],
                firstname: map['patientFirstname'],
                lastname: map['patientLastname']) : null,
            consumptionDescription: ConsumptionDescription(
                description: map['consumptionDescription'])),
        drugAmountWithdrawn = double.parse(map['drugAmountWithdrawn']),
        drugAmountLeft = double.parse(map['drugAmountLeft']),
        user = User(
            firstname: map['userFirstname'],
            lastname: map['userLastname'],
            userId: map['userId']),
        drug = Drug(
          name: map['drugName'],
          concentration: map['concentration'],
          concentrationUnit: map['concentrationUnit'],
          quantity: map['quantity'],
          dosageForm: map['dosageForm'],
          quantityUnit: map['quantityUnit'],
          routeOfAdministration: map['routeOfAdministration'],
          atc: map['atc'],
        );
}
