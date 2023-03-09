import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/utils/extensions.dart';

class DepositSummaryPane extends ConsumerWidget {
  const DepositSummaryPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depositRecord = ref.watch(depositRecordStateProvider);

    Widget generateRecord() {
      return depositRecord == null ? Container() : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Läkemedel: ${depositRecord.drug.name} ${depositRecord.drug.concentration.smartRoundToString()}${depositRecord.drug.concentrationUnit}, ${depositRecord.drug.quantity} ${depositRecord.drug.quantityUnit}'),
          Text(
              'Påfylld mängd: ${depositRecord.drugAmountDeposit.smartRoundToString()} x ${depositRecord.drug.quantity.smartRoundToString()} ${depositRecord.drug.quantityUnit}'),
          Text(
              'Tidpunkt: ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(depositRecord.timestamp * 1000))}'),
          Text(
              'Ansvarig: ${depositRecord.user.firstname} ${depositRecord.user.lastname}'),
        ],
      );
    }
    
    return generateRecord();
  }
}
