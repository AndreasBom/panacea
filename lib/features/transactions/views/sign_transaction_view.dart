import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:panacea_app/features/home/views/home_view.dart';
import 'package:panacea_app/features/transactions/panes/deposit_summary.dart';
import 'package:panacea_app/features/transactions/panes/withdraw_summary.dart';
import 'package:panacea_app/types/transaction_type.dart';
import 'package:panacea_app/utils/helpers.dart';

import '../../../utils/navigate.dart';
import '../../../mock/user_mock.dart';
import '../models/deposit_record.dart';
import '../models/withdraw_record.dart';
import '../providers/drug_transaction_provider.dart';

class SignTransactionView extends ConsumerWidget {
  SignTransactionView({super.key});

  final _formKey = GlobalKey<FormBuilderState>();
  final isButtonActive = StateProvider<bool>((ref) => false);

  void clearWithdrawFormState(WidgetRef ref){
    ref.invalidate(patientStateProvider);
    ref.invalidate(transactionTypeStateProvider);
    ref.invalidate(drugAmountStateProvider);
    ref.invalidate(chosenDrugStateProvider);
  }

  void signTransaction(WidgetRef ref) {
    final typeOfTransaction = ref.read(transactionTypeStateProvider);
    if (typeOfTransaction == TransactionType.withdraw) {
      final record = ref.read(withdrawRecordStateProvider);
      debugPrint(record.toString());
      clearWithdrawFormState(ref);
    }
    if (typeOfTransaction == TransactionType.deposit) {
      final record = ref.read(depositRecordStateProvider);
      debugPrint(record.toString());
    }
  }

  WithdrawRecord createWithdrawRecord(WidgetRef ref) {
    final Map<String, dynamic> mergedMap = {};
    final drug = ref.watch(chosenDrugStateProvider.notifier).state;
    final amount = ref.watch(drugAmountStateProvider.notifier).state;
    final user = getUser.toMap();
    final patient = ref.watch(patientStateProvider.notifier).state;
    mergedMap.addAll(drug!.toMap());
    mergedMap.addAll(amount);
    if(patient != null){
      mergedMap.addAll(patient.toMap());
    }
    mergedMap.addAll(user);

    return WithdrawRecord.fromMap(mergedMap);
  }

  DepositRecord createDepositRecord(WidgetRef ref) {
    final Map<String, dynamic> mergedMap = {};
    final drug = ref.read(chosenDrugStateProvider.notifier).state;
    final amount = ref.read(drugAmountStateProvider.notifier).state;
    final user = getUser.toMap();
    mergedMap.addAll(drug!.toMap());
    mergedMap.addAll(amount);
    mergedMap.addAll(user);

    return DepositRecord.fromMap(mergedMap);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transactionType = ref.read(transactionTypeStateProvider);
      if (transactionType == TransactionType.withdraw) {
        ref.read(withdrawRecordStateProvider.notifier).state =
            createWithdrawRecord(ref);
      }
      if (transactionType == TransactionType.deposit) {
        ref.read(depositRecordStateProvider.notifier).state =
            createDepositRecord(ref);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signera'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uppgifter att signera',
                style: Theme.of(context).textTheme.headline6,
              ),
              addHorizontalSpace(),
              ref.watch(transactionTypeStateProvider) ==
                      TransactionType.withdraw
                  ? WithdrawSummaryPane()
                  : DepositSummaryPane(),
              addHorizontalSpace(),
              const Divider(),
              addHorizontalSpace(),
              Text(
                'Signera förbrukningsjournalen',
                style: Theme.of(context).textTheme.headline6,
              ),
              addHorizontalSpace(),
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
                    children: [
                      FormBuilderTextField(
                        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                        name: 'username',
                        validator: FormBuilderValidators.required(),
                        decoration: const InputDecoration(
                          label: Text('Användarnamn'),
                        ),
                      ),
                      addHorizontalSpace(),
                      FormBuilderTextField(
                        name: 'password',
                        validator: FormBuilderValidators.required(),
                        decoration: const InputDecoration(
                          label: Text('Lösenord'),
                        ),
                      ),
                    ],
                  )),
              addHorizontalSpace(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: const ContinuousRectangleBorder()),
                  onPressed: ref.watch(isButtonActive)
                      ? () {
                          signTransaction(ref);
                          Navigate.replace(context, const HomeView());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              content: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text('Sparad!',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer)),
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Signera'))
            ],
          ),
        ),
      ),
    );
  }
}
