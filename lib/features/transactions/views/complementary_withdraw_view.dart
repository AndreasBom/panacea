import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/features/transactions/views/no_patient_form_view.dart';
import 'package:panacea_app/features/transactions/views/patient_form_view.dart';
import 'package:panacea_app/types/person_id_type.dart';

class ComplementaryWithdrawInfoView extends ConsumerWidget {
  const ComplementaryWithdrawInfoView({Key? key}) : super(key: key);

  Widget getForm(PersonIdType idType) {
    switch(idType){
      case PersonIdType.noPatient:
        return NoPatientFormView();
    }

    return PatientFormView();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personIdType = ref.watch(personIdTypeStateProvider);

    return getForm(personIdType);
  }
}
