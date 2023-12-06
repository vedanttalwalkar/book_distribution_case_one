import 'package:book_distribution_case_one/classes/book.dart';
import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';
import 'package:equatable/equatable.dart';

class BookDistributionListingPageState extends Equatable {
  final String? searchName;
  final List<Book> books;
  final int value;
  final List<BookInTripList> booksInTrip;
  const BookDistributionListingPageState(this.value,
      {this.searchName, required this.books, required this.booksInTrip});
  @override
  List<Object?> get props => [books, searchName, value];

  BookDistributionListingPageState exchangeWith(
      {final List<Book>? books,
      final String? searchName,
      final List<BookInTripList>? booksInTrip}) {
    return BookDistributionListingPageState(value + 1,
        booksInTrip: booksInTrip ?? this.booksInTrip,
        books: books ?? this.books,
        searchName: searchName ?? this.searchName);
  }
}
