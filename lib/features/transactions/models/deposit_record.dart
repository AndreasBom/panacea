import 'package:panacea_app/features/transactions/models/drug.dart';
import 'package:panacea_app/features/transactions/models/user.dart';

class DepositRecord {
  final Drug drug;
  final double drugAmountDeposit;
  final double drugAmountLeft;
  final int timestamp;
  final User user;

  DepositRecord.fromMap(Map<String, dynamic> map)
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        drugAmountDeposit = double.parse(map['drugAmountDeposit']),
        drugAmountLeft = double.parse(map['drugAmountLeft']),
        user = User(firstname: map['userFirstname'], lastname: map['userLastname'], userId: map['userId']),
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
