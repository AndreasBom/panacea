import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/utils/extensions.dart';

import '../providers/drug_transaction_provider.dart';

class WithdrawSummaryPane extends ConsumerWidget {
  const WithdrawSummaryPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawRecord = ref.watch(withdrawRecordStateProvider);

    Widget generateRecord() {
      return withdrawRecord == null ? Container() : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Läkemedel: ${withdrawRecord.drug.name} ${withdrawRecord.drug.concentration.smartRoundToString()}${withdrawRecord.drug.concentrationUnit}, ${withdrawRecord.drug.quantity} ${withdrawRecord.drug.quantityUnit}'),
          Text(
              'Uthämtad mängd: ${withdrawRecord.drugAmountWithdrawn.smartRoundToString()} x ${withdrawRecord.drug.quantity.smartRoundToString()} ${withdrawRecord.drug.quantityUnit}'),
          Text(
               'Patientuppgifter: ${withdrawRecord.drugConsumer.patient?.firstname} ${withdrawRecord.drugConsumer.patient?.lastname}, ${withdrawRecord.drugConsumer.patient?.patientId}'),
          Text(
              'Tidpunkt: ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(withdrawRecord.timestamp * 1000))}'),
          Text(
              'Ansvarig: ${withdrawRecord.user.firstname} ${withdrawRecord.user.lastname}'),
        ],
      );
    }

    return generateRecord();
  }
}
