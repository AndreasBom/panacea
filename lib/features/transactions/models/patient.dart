import 'package:panacea_app/types/person_id_type.dart';

class Patient {
  final String patientId;

  //final PersonIdType personIdType;
  final String firstname;
  final String lastname;

  Patient(
      {required this.patientId,
      required this.firstname,
      required this.lastname});

  Patient.fromMap(Map<String, dynamic> map)
      : patientId = map['patientId'],
        firstname = map['patientFirstname'],
        lastname = map['patientLastname'];

  Map<String, dynamic> toMap(){
    return {
      'patientId': patientId,
      'patientFirstname': firstname,
      'patientLastname': lastname
    };
  }
}
