import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/types/transaction_type.dart';

import '../../../utils/navigate.dart';
import '../../transactions/views/cross_check_view.dart';
import '../../transactions/views/deposit_view.dart';
import '../../transactions/views/drug_search_view.dart';
import '../../transactions/views/withdraw_view.dart';

class HomeMenuPane extends ConsumerWidget {
  const HomeMenuPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var widthAndHeight = MediaQuery.of(context).size.width / 3 - 6;
    var buttonColor = Theme.of(context).colorScheme.primary;
    var buttonFaceColor = Theme.of(context).colorScheme.onPrimary;

    return Column(
      children: [
        Container(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                width: widthAndHeight,
                height: widthAndHeight,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: InkWell(
                  onTap: () {
                    ref.read(transactionTypeStateProvider.notifier).state = TransactionType.withdraw;
                    Navigate.to(context, DrugSearchView(viewAfterDrugSearch: WithdrawView(),));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medication_liquid,
                        size: 40,
                        color: buttonFaceColor,
                      ),
                      Text(
                        'Uttag',
                        style: Theme.of(context).textTheme.button?.merge(TextStyle(color: buttonFaceColor)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ref.read(transactionTypeStateProvider.notifier).state = TransactionType.deposit;
                Navigate.to(context, DrugSearchView(viewAfterDrugSearch: DepositView()));
              },
              child: Container(
                width: widthAndHeight,
                height: widthAndHeight,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cabin,
                      size: 40,
                      color: buttonFaceColor,
                    ),
                    Text(
                      'Påfyllning',
                      style: Theme.of(context).textTheme.button?.merge(TextStyle(color: buttonFaceColor)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              width: widthAndHeight,
              height: widthAndHeight,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: InkWell(
                onTap: () {
                  ref.read(transactionTypeStateProvider.notifier).state = TransactionType.crossCheck;
                  Navigate.to(context, DrugSearchView(viewAfterDrugSearch: CrossCheckView()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calculate,
                      size: 40,
                      color: buttonFaceColor,
                    ),
                    Text(
                      'Kontroll',
                      style: Theme.of(context).textTheme.button?.merge(TextStyle(color: buttonFaceColor)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
