
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/models/withdraw_record.dart';
import 'package:panacea_app/types/person_id_type.dart';
import 'package:panacea_app/types/transaction_type.dart';

import '../models/deposit_record.dart';
import '../models/drug.dart';
import '../models/patient.dart';


final chosenDrugStateProvider = StateProvider<Drug?>((ref) => null);

final drugAmountStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final withdrawRecordStateProvider = StateProvider<WithdrawRecord?>((ref) => null);

final depositRecordStateProvider = StateProvider<DepositRecord?>((ref) => null);

final patientStateProvider = StateProvider<Patient?>((ref) => null);

final personIdTypeStateProvider = StateProvider<PersonIdType>((ref) => PersonIdType.noPatient);

final transactionTypeStateProvider = StateProvider<TransactionType?>((ref) => null);