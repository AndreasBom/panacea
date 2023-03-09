import 'package:flutter/material.dart';

import '../panes/home_meny_pane.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Förrådsidentitet: U323MB',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'Plats: Akuten, Varberg',
                    style: TextStyle(fontSize: 20, height: 2),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Ändra förråd',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        Icon(
                          Icons.change_circle_rounded,
                          color: Theme.of(context).colorScheme.outline,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 10,
          ),
          const HomeMenuPane()
        ],
      ),
    );
  }
}
