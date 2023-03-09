import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panacea_app/features/transactions/providers/drug_transaction_provider.dart';
import 'package:panacea_app/utils/extensions.dart';
import 'package:panacea_app/mock/drug_mock.dart';

import '../../../utils/navigate.dart';
import '../models/drug.dart';

class DrugSearchView extends ConsumerWidget {
  DrugSearchView({required this.viewAfterDrugSearch, Key? key})
      : super(key: key);
  final drugFilterStateProvider =
      StateProvider.autoDispose<List<Drug>>((ref) => []);

  final Widget viewAfterDrugSearch;
  static final List<Drug> _drugOptions = getAvailableDrugs;

  static String _displayStringForOption(Drug drug) => drug.name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Välj läkemedel')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            RawAutocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  ref.watch(drugFilterStateProvider.notifier).state = [];
                  return const Iterable<Drug>.empty();
                }
                final drugs = _drugOptions.where((Drug drug) => drug.name
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()));
                ref.read(drugFilterStateProvider.notifier).state =
                    drugs.toList();

                return drugs;
              },
              onSelected: (Drug drug) {
                debugPrint('You selected ${_displayStringForOption(drug)}');
              },
              displayStringForOption: _displayStringForOption,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Sök läkemedel',
                      prefixIcon: Icon(Icons.search)),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  void Function(Drug) onSelected, Iterable<Drug> options) {
                return Container();
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ref.watch(drugFilterStateProvider).length,
                  itemBuilder: (BuildContext context, int index) {
                    final drug = ref.watch(drugFilterStateProvider)[index];
                    return GestureDetector(
                      onTap: () {
                        ref.watch(chosenDrugStateProvider.notifier).state =
                            drug;
                        Navigate.to(context, viewAfterDrugSearch);
                      },
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: const Icon(Icons.medication),
                          title: Text(
                              '${drug.name} ${drug.concentration.smartRoundToString()}${drug.concentrationUnit}'),
                          subtitle: Text(
                              '${drug.quantity.smartRoundToString()}${drug.quantityUnit} ${drug.dosageForm} ${drug.concentration.smartRoundToString()}${drug.concentrationUnit}'),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
