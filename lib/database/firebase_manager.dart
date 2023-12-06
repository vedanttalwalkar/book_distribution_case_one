import 'package:book_distribution_case_one/classes/book.dart';
import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseManager {
  final instanceOfFireStore = FirebaseFirestore.instance;
  static final firebaseManager = FirebaseManager._();
  late CollectionReference booksInJson;
  late CollectionReference tripBooks;
  FirebaseManager._() {
    booksInJson = instanceOfFireStore
        .collection("booksSecondList")
        .withConverter<Book>(
            fromFirestore: (snapshot, _) => Book.fromJs(snapshot.data()!),
            toFirestore: (book, _) => book.toJson());

    tripBooks = instanceOfFireStore
        .collection("booksForTrip")
        .withConverter<BookInTripList>(
            fromFirestore: (snapshot, _) =>
                BookInTripList.fromJs(snapshot.data()!),
            toFirestore: (book, _) => book.toJson());
  }
}
