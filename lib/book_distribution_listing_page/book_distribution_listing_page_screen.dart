import 'dart:async';

import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_bloc.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_event.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_state.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/functionalities/add_remove_book_button.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/functionalities/constants.dart';
import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDistributionPageScreen extends StatelessWidget {
  const BookDistributionPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookBloc = context.read<BookDistributionListingPageBloc>();
    bookBloc.add(LoadBooks());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Book Distribution List Creation'),
      ),
      body: BlocBuilder<BookDistributionListingPageBloc,
          BookDistributionListingPageState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    bookBloc.add(SearchBook(
                      searchName: value,
                    ));
                  },
                  decoration: InputDecoration(
                      hintText: 'Search by book name or shortName(initials)?',
                      border: textFieldKa,
                      enabledBorder: textFieldKa,
                      focusedBorder: textFieldKa),
                ),
              ),
              Expanded(
                flex: 70,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    void addBook() {
                      bookBloc.add(AddToTripList(
                          book: state.books[index], quantityToBeAdded: 1));
                    }

                    final bookInTripList =
                        state.booksInTrip.firstWhere((element) {
                      return element.name == state.books[index].name;
                    },
                            orElse: () => const BookInTripList(
                                  totalPrice: 0.00,
                                  quantity: 0,
                                  name: '',
                                  price: 0,
                                ));
                    return Card(
                      child: ListTile(
                        trailing: SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              AddRemoveBookButton('-', function: () {
                                bookBloc.add(RemoveFromTripList(
                                    book: state.books[index],
                                    quantityToBeRemoved: 1));
                              }),
                              Container(
                                height: buttonSize,
                                width: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: TextEditingController()
                                    ..text = bookInTripList.quantity.toString(),
                                  decoration: InputDecoration(
                                      border: textFieldKa,
                                      enabledBorder: textFieldKa,
                                      focusedBorder: textFieldKa),
                                  onChanged: (value) {
                                    final delayTime =
                                        Duration(milliseconds: 1500);
                                    Timer(delayTime, () {
                                      bookBloc.add(SetQuantity(
                                          book: state.books[index],
                                          quantity: value));
                                    });
                                  },
                                )),
                              ),
                              AddRemoveBookButton('+', function: addBook)
                            ],
                          ),
                        ),
                        title: Text(state.books[index].name),
                        subtitle:
                            Text('Rs. ${state.books[index].price.toString()}'),
                      ),
                    );
                  },
                  itemCount: state.books.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Selected Books"),
              ),
              Expanded(
                  flex: 20,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Text(
                              "Quantity: ${state.booksInTrip[index].quantity.toString()}"),
                          title: Text(state.booksInTrip[index].name),
                          subtitle: Text(
                              "Price/book : ${state.booksInTrip[index].price}"),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: state.booksInTrip.length)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    bookBloc.add(CreatePDF());
                  },
                  child: const Text(
                    'Print PDF',
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

OutlineInputBorder textFieldKa = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  borderSide: BorderSide(
    color: Colors.white,
    width: 3,
  ),
);
