import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_bloc.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_event.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_screen.dart';
import 'package:book_distribution_case_one/classes/book.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class AlertDialogQuantityAdditionRemoval extends StatefulWidget {
  final BookDistributionListingPageBloc bookBloc;
  final Book book;
  const AlertDialogQuantityAdditionRemoval(
      {required this.bookBloc, required this.book, super.key});

  @override
  State<AlertDialogQuantityAdditionRemoval> createState() =>
      // ignore: no_logic_in_create_state
      _AlertDialogQuantityAdditionRemovalState(bookBloc, book: book);
}

class _AlertDialogQuantityAdditionRemovalState
    extends State<AlertDialogQuantityAdditionRemoval> {
  final Book book;

  final BookDistributionListingPageBloc bookBloc;
  _AlertDialogQuantityAdditionRemovalState(this.bookBloc, {required this.book});
  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    return AlertDialog(
      title: const Text("Add How Many Books?"),
      content: SizedBox(
        width: 200,
        child: TextFormField(
          onChanged: (value) {
            if (isNumeric(value)) {
              quantity = int.parse(value);
            }
          },
          decoration: InputDecoration(
              labelText: 'Quantity to Be added or removed',
              border: textFieldKa,
              enabledBorder: textFieldKa,
              focusedBorder: textFieldKa),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (quantity > 0) {
                bookBloc.add(
                    AddToTripList(quantityToBeAdded: quantity, book: book));
                Navigator.pop(context);
              }
            },
            child: const Text("Add")),
        ElevatedButton(
            onPressed: () {
              bookBloc.add(RemoveFromTripList(
                  quantityToBeRemoved: quantity, book: book));
              Navigator.pop(context);
            },
            child: const Text("Remove")),
      ],
    );
  }
}
