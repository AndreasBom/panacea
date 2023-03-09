import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:panacea_app/features/transactions/panes/person_id_widget.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/features/transactions/views/sign_transaction_view.dart';
import 'package:panacea_app/utils/navigate.dart';
import 'package:panacea_app/utils/helpers.dart';

import '../models/patient.dart';

class NoPatientFormView extends ConsumerWidget {
  NoPatientFormView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final isButtonActive = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uppgifter'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            if (_formKey.currentState!.isValid) {
              ref.watch(isButtonActive.notifier).state = true;
            } else {
              ref.watch(isButtonActive.notifier).state = false;
            }
            _formKey.currentState!.save();
          },
          child: Column(
            children: [
              addHorizontalSpace(),
              Text(
                'Ange anledning till uttaget',
                style: Theme.of(context).textTheme.headline6,
              ),
              addHorizontalSpace(),
              const PersonIdWidget(),
              addHorizontalSpace(),
              FormBuilderTextField(
                maxLines: 10,
                validator: FormBuilderValidators.required(),
                name: 'reasonForWithdraw',
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  label: Text('Beskrivning anledningen till förbrukningen'),
                  alignLabelWithHint: true,
                ),
              ),
              addHorizontalSpace(),
              ElevatedButton(
                onPressed: ref.watch(isButtonActive)
                    ? () {
                        final description = _formKey.currentState!.value;
                        //ref.read(patientStateProvider.notifier).state =
                          //  Patient.fromMap(patient);

                        Navigate.to(
                          context,
                          SignTransactionView(),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nästa'),
                    addVerticalSpace(space: 5),
                    const Icon(Icons.navigate_next),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
