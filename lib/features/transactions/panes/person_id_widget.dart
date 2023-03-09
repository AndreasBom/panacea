import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/types/person_id_type.dart';

import '../../../utils/navigate.dart';
import '../../../utils/helpers.dart';

class PersonIdWidget extends ConsumerWidget {
  const PersonIdWidget({Key? key}) : super(key: key);

  String getLabel(PersonIdType idType) {
    switch (idType) {
      case PersonIdType.personnummer:
        return 'Personnummer';
      case PersonIdType.reservnummer:
        return 'Reservnummer';
      case PersonIdType.sammordningsnummer:
        return 'Sammordningsnummer';
      case PersonIdType.noPatient:
        return 'Ingen patient';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personIdType = ref.watch(personIdTypeStateProvider);

    return Row(
      children: [
        SizedBox(
            width: 200,
            child: personIdType == PersonIdType.noPatient ? null : FormBuilderTextField(
              validator: FormBuilderValidators.required(),
              keyboardType: const TextInputType.numberWithOptions(),
              name: 'patientId',
              decoration: InputDecoration(
                label: Text(getLabel(personIdType)),
              ),
            )),
        addVerticalSpace(space: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                ref
                                    .read(personIdTypeStateProvider.notifier)
                                    .state = PersonIdType.personnummer;
                                Navigate.pop(context);
                              },
                              child: ListTile(
                                title:
                                    Text(getLabel(PersonIdType.personnummer)),
                                leading: Radio(
                                  value: PersonIdType.personnummer,
                                  groupValue: personIdType,
                                  onChanged: (PersonIdType? idType) {
                                    ref
                                        .read(
                                            personIdTypeStateProvider.notifier)
                                        .state = PersonIdType.personnummer;
                                    Navigate.pop(context);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(personIdTypeStateProvider.notifier)
                                    .state = PersonIdType.reservnummer;
                                Navigate.pop(context);
                              },
                              child: ListTile(
                                title:
                                    Text(getLabel(PersonIdType.reservnummer)),
                                leading: Radio(
                                  value: PersonIdType.reservnummer,
                                  groupValue: personIdType,
                                  onChanged: (PersonIdType? idType) {
                                    ref
                                        .read(
                                            personIdTypeStateProvider.notifier)
                                        .state = PersonIdType.reservnummer;
                                    Navigate.pop(context);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(personIdTypeStateProvider.notifier)
                                    .state = PersonIdType.sammordningsnummer;
                                Navigate.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                    getLabel(PersonIdType.sammordningsnummer)),
                                leading: Radio(
                                  value: PersonIdType.sammordningsnummer,
                                  groupValue: personIdType,
                                  onChanged: (PersonIdType? idType) {
                                    ref
                                            .read(personIdTypeStateProvider
                                                .notifier)
                                            .state =
                                        PersonIdType.sammordningsnummer;
                                    Navigate.pop(context);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(personIdTypeStateProvider.notifier)
                                    .state = PersonIdType.noPatient;
                                Navigate.pop(context);
                              },
                              child: ListTile(
                                title: Text(getLabel(PersonIdType.noPatient)),
                                leading: Radio(
                                  value: PersonIdType.noPatient,
                                  groupValue: personIdType,
                                  onChanged: (PersonIdType? idType) {
                                    ref
                                        .read(
                                            personIdTypeStateProvider.notifier)
                                        .state = PersonIdType.noPatient;
                                    Navigate.pop(context);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.perm_identity),
                Text('Ändra id-typ'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
