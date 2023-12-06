import 'package:book_distribution_case_one/classes/book.dart';
import 'package:equatable/equatable.dart';

class BookDistributionListingPageEvent extends Equatable {
  const BookDistributionListingPageEvent();
  @override
  List<Object?> get props => [];
}

class LoadBooks extends BookDistributionListingPageEvent {}

class SearchBook extends BookDistributionListingPageEvent {
  final String? searchName;
  const SearchBook({required this.searchName});
  @override
  List<Object?> get props => [searchName];
}

class AddToTripList extends BookDistributionListingPageEvent {
  final int quantityToBeAdded;
  final Book book;
  const AddToTripList({required this.quantityToBeAdded, required this.book});
  @override
  List<Object?> get props => [book, quantityToBeAdded];
}

class RemoveFromTripList extends BookDistributionListingPageEvent {
  final int quantityToBeRemoved;

  final Book book;
  const RemoveFromTripList(
      {required this.quantityToBeRemoved, required this.book});
  @override
  List<Object?> get props => [book];
}

class CreatePDF extends BookDistributionListingPageEvent {}

class SetQuantity extends BookDistributionListingPageEvent {
  final Book book;
  final String quantity;
  const SetQuantity({ required this.book,required this.quantity});
  @override
  List<Object?> get props => [book, quantity];
}
