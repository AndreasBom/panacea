import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/features/transactions/views/complementary_withdraw_view.dart';
import 'package:panacea_app/features/transactions/views/patient_form_view.dart';
import 'package:panacea_app/utils/extensions.dart';
import 'package:panacea_app/utils/helpers.dart';

import '../../../utils/navigate.dart';
import '../models/drug.dart';

class WithdrawView extends ConsumerWidget {
  WithdrawView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final isButtonActive = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drug? drug = ref.watch(chosenDrugStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrera uttag'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addHorizontalSpace(),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: const Icon(Icons.medication),
                  title: Text(
                    '${drug?.name} ${drug?.concentration.smartRoundToString()}${drug?.concentrationUnit}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Text(
                    '${drug?.quantity.smartRoundToString()}${drug?.quantityUnit} ${drug?.dosageForm} ${drug?.concentration.smartRoundToString()}${drug?.concentrationUnit}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              addHorizontalSpace(),
              FormBuilder(
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: FormBuilderTextField(
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric()
                              ]),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              name: 'drugAmountWithdrawn',
                              onChanged: (val) {
                                print(
                                    val); // Print the text value write into TextField
                              },
                              decoration: const InputDecoration(
                                  label: Text('Uthämtad mängd')),
                            ),
                          ),
                          addVerticalSpace(space: 10),
                          Text(
                            'x ${drug?.quantity.smartRoundToString()} ${drug?.quantityUnit}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      addHorizontalSpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: FormBuilderTextField(
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric()
                              ]),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              name: 'drugAmountLeft',
                              onChanged: (val) {
                                print(
                                    val); // Print the text value write into TextField
                              },
                              decoration: const InputDecoration(
                                label: Text('Behållning'),
                              ),
                            ),
                          ),
                          addVerticalSpace(space: 10),
                          Text(
                            'x ${drug?.quantity.smartRoundToString()} ${drug?.quantityUnit}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      addHorizontalSpace(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: ref.watch(isButtonActive)
                            ? () {
                                ref
                                    .read(drugAmountStateProvider.notifier)
                                    .state = _formKey.currentState!.value;
                                Navigate.to(context,
                                    const ComplementaryWithdrawInfoView());
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Nästa'),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
