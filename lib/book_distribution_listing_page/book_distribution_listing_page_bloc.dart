import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_event.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_state.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/pdf_service.dart';
import 'package:book_distribution_case_one/classes/book.dart';
import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';
import 'package:book_distribution_case_one/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class BookDistributionListingPageBloc extends Bloc<
    BookDistributionListingPageEvent, BookDistributionListingPageState> {
  List<Book> books = [];
  List<BookInTripList> booksInTripList = [];
  BookDistributionListingPageBloc()
      : super(const BookDistributionListingPageState(0,
            books: [], booksInTrip: [])) {
    on<LoadBooks>((event, emit) async {
      books = await Database.database.fecthBooks();
      booksInTripList = await Database.database.fetchTripBooks();
      emit(state.exchangeWith(books: books, booksInTrip: booksInTripList));
    });

    on<SearchBook>((event, emit) {
      var filteredBooks = books.where((element) {
        bool meetsFilterCondition = event.searchName == null ||
            element.name
                .toLowerCase()
                .contains(event.searchName!.toLowerCase());
        return meetsFilterCondition;
      }).toList();

      emit(state.exchangeWith(
          searchName: event.searchName, books: filteredBooks));
    });

    on<AddToTripList>((event, emit) {
      int index = state.booksInTrip
          .indexWhere((element) => element.name == event.book.name);
      List<BookInTripList> newBooks = state.booksInTrip;
      if (index != -1) {
        BookInTripList bookInTripList = state.booksInTrip
            .firstWhere((element) => element.name == event.book.name);
        int quantity = bookInTripList.quantity + event.quantityToBeAdded;
        newBooks.removeAt(index);
        newBooks.add(BookInTripList(
            totalPrice: bookInTripList.price * quantity.toDouble(),
            quantity: quantity,
            name: bookInTripList.name,
            price: bookInTripList.price));
      } else {
        newBooks.add(BookInTripList(
            totalPrice: event.book.price.toDouble(),
            quantity: event.quantityToBeAdded,
            name: event.book.name,
            price: event.book.price));
      }
      emit(state.exchangeWith(booksInTrip: newBooks));
      Database.database.addToList(event.book, event.quantityToBeAdded);
    });

    on<RemoveFromTripList>((event, emit) {
      int index = state.booksInTrip
          .indexWhere((element) => element.name == event.book.name);
      List<BookInTripList> newBooks = state.booksInTrip;
      if (index != -1) {
        BookInTripList bookInTripList = state.booksInTrip
            .firstWhere((element) => element.name == event.book.name);

        int quantity = bookInTripList.quantity - event.quantityToBeRemoved;

        if (quantity > 0) {
          newBooks.removeAt(index);
          newBooks.add(BookInTripList(
              totalPrice: bookInTripList.price * quantity.toDouble(),
              quantity: quantity,
              name: bookInTripList.name,
              price: bookInTripList.price));
        } else if (quantity == 0) {
          newBooks.remove(bookInTripList);
        }
      }
      emit(state.exchangeWith(booksInTrip: newBooks));
      Database.database.removeFromList(event.book, event.quantityToBeRemoved);
    });
    on<CreatePDF>((event, emit) async {
      PDFService().printPDF();
      Database.database.clearTheListAftercompletingList();
    });

    on<SetQuantity>((event, emit) {
      int index = state.booksInTrip
          .indexWhere((element) => element.name == event.book.name);
      List<BookInTripList> newBooks = state.booksInTrip;
      if (isNumeric(event.quantity) && (int.parse(event.quantity) > 0)) {
        if (index != -1) {
          newBooks.removeAt(index);
          newBooks.add(BookInTripList(
              totalPrice:
                  event.book.price * int.parse(event.quantity).toDouble(),
              quantity: int.parse(event.quantity),
              name: event.book.name,
              price: event.book.price));
        } else {
          newBooks.add(BookInTripList(
              totalPrice:
                  event.book.price * int.parse(event.quantity).toDouble(),
              quantity: int.parse(event.quantity),
              name: event.book.name,
              price: event.book.price));
        }
        emit(state.exchangeWith(booksInTrip: newBooks));
        Database.database.setQuantity(event.book, int.parse(event.quantity));
      } else if (event.quantity == "") {
        if (index != -1) {
          newBooks.removeAt(index);
          Database.database.setQuantity(event.book, 0);
           emit(state.exchangeWith(booksInTrip: newBooks));
        }
      }
    });
  }
}
