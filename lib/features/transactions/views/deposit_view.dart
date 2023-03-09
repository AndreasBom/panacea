import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/models/deposit_record.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/features/transactions/views/sign_transaction_view.dart';
import 'package:panacea_app/utils/extensions.dart';
import 'package:panacea_app/utils/helpers.dart';

import '../../../utils/navigate.dart';
import '../../../mock/user_mock.dart';
import '../models/drug.dart';

class DepositView extends ConsumerWidget {
  DepositView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Drug? drug = ref.watch(chosenDrugStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrera påfyllning'),
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
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              name: 'drugAmountDeposit',
                              onChanged: (val) {
                                print(
                                    val); // Print the text value write into TextField
                              },
                              decoration: const InputDecoration(
                                  label: Text('Påfylld mängd')),
                            ),
                          ),
                          addVerticalSpace(space: 10),
                          Text(
                            'x ${drug!.quantity.smartRoundToString()} ${drug.quantityUnit}',
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
                            'x ${drug!.quantity.smartRoundToString()} ${drug.quantityUnit}',
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
                        onPressed: () {
                          ref.read(drugAmountStateProvider.notifier).state =
                              _formKey.currentState!.value;

                          Navigate.to(context, SignTransactionView());
                        },
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
