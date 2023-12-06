import 'package:book_distribution_case_one/book_distribution_listing_page/alert_dialog_list_confirmation.dart';
import 'package:book_distribution_case_one/database/database.dart';
import 'package:flutter/material.dart';

class BookListPreview extends StatefulWidget {
  final function;
  const BookListPreview(this.function, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<BookListPreview> createState() => _BookListPreviewState(function);
}

class _BookListPreviewState extends State<BookListPreview> {
  final function;

  _BookListPreviewState(this.function);
  @override
  Widget build(BuildContext context) {
    double finalPrice = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Preview of Books'),
      ),
      body: FutureBuilder(
          future: Database.database.fetchTripBooks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var element in snapshot.data!) {
                finalPrice += element.totalPrice;
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(
                                "Price Of all Books:${snapshot.data![index].totalPrice}"),
                            title: Text(snapshot.data![index].name),
                            trailing: Text(
                                "Quantity:${snapshot.data![index].quantity}"),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.length),
                  ),
                  Column(
                    children: [
                      Text(
                        "Sum total Cost: ₹${finalPrice.toString()}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmatonAlertDialog(function);
                                });
                          },
                          child: const Text("Print Pdf"))
                    ],
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
