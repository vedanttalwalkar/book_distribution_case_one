import 'package:book_distribution_case_one/database/database.dart';
import 'package:flutter/material.dart';

class ConfirmBookListMain extends StatelessWidget {
  const ConfirmBookListMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: 400,
          child: FutureBuilder(
              future: Database.database.fetchTripBooks(),
              builder: (context, s) {
                if (s.hasData) {
                  return ListView.builder(
                      itemCount: s.data!.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(s.data![index].name),
                        );
                      }));
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
