import 'package:book_distribution_case_one/classes/book.dart';
import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';
import 'package:book_distribution_case_one/database/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final firebaseManager = FirebaseManager.firebaseManager;
  static final database = Database._();
  late CollectionReference booksInTripListPath;
  Database._() {
    booksInTripListPath =
        firebaseManager.instanceOfFireStore.collection('booksForTrip');
  }
  Future<List<Book>> fecthBooks() async {
    List<Book> books = [];
    final queryDocumentSnapshot = await firebaseManager.booksInJson.get();
    for (var element in queryDocumentSnapshot.docs) {
      books.add(element.data() as Book);
    }
    return books;
  }

  Future<List<BookInTripList>> fetchTripBooks() async {
    List<BookInTripList> books1 = [];
    final query = await firebaseManager.tripBooks.get();
    for (var element in query.docs) {
      books1.add(element.data() as BookInTripList);
    }

    return books1;
  }

  Future<void> addToList(Book book, int quantityToBeAdded) async {
    final searchBookQuerySnapShot =
        await booksInTripListPath.where('name', isEqualTo: book.name).get();
    if (searchBookQuerySnapShot.docs.isNotEmpty) {
      final bookId = searchBookQuerySnapShot.docs.first.id;
      final searchBook = await booksInTripListPath.doc(bookId).get()
          as DocumentSnapshot<Map<String, dynamic>>;
      final quantity = searchBook.data()!["quantity"];
      final price = searchBook.data()!["price"];
      booksInTripListPath.doc(bookId).update({
        "quantity": quantity + quantityToBeAdded,
        "totalPrice": (quantity + quantityToBeAdded) * price
      });
    } else {
      booksInTripListPath.add(BookInTripList(
              totalPrice: book.price.toDouble() * quantityToBeAdded,
              quantity: quantityToBeAdded,
              name: book.name,
              price: book.price,
              score: book.score,
              multiplier: book.multiplier,
              category: book.category)
          .toJson());
    }
  }

  Future<void> setQuantity(Book book, int quantityToBeAdded) async {
    final searchBookQuerySnapShot =
        await booksInTripListPath.where('name', isEqualTo: book.name).get();
    if (searchBookQuerySnapShot.docs.isNotEmpty) {
      final bookId = searchBookQuerySnapShot.docs.first.id;
      final searchBook = await booksInTripListPath.doc(bookId).get()
          as DocumentSnapshot<Map<String, dynamic>>;

      if (quantityToBeAdded > 0) {
        final price = searchBook.data()!["price"];
        booksInTripListPath.doc(bookId).update({
          "quantity": quantityToBeAdded,
          "totalPrice": (quantityToBeAdded) * price
        });
      } else if (quantityToBeAdded == 0) {
        booksInTripListPath.doc(bookId).delete();
      }
    } else {
      if (quantityToBeAdded > 0) {
        booksInTripListPath.add(BookInTripList(
                totalPrice: book.price.toDouble() * quantityToBeAdded,
                quantity: quantityToBeAdded,
                name: book.name,
                price: book.price,
                score: book.score,
                multiplier: book.multiplier,
                category: book.category)
            .toJson());
      }
    }
  }

  Future<void> clearTheListAftercompletingList() async {
    firebaseManager.instanceOfFireStore
        .collection("booksForTrip")
        .get()
        .then((snapShot) {
      for (DocumentSnapshot ds in snapShot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> removeFromList(Book book, int quantityToBeReduced) async {
    final QuerySnapshot querySnapshot =
        await booksInTripListPath.where('name', isEqualTo: book.name).get();

    if (querySnapshot.docs.isNotEmpty) {
      final bookId = querySnapshot.docs.first.id;
      final searchBook = await booksInTripListPath.doc(bookId).get()
          as DocumentSnapshot<Map<String, dynamic>>;
      final quantity = searchBook.data()!["quantity"];
      final price = searchBook.data()!["price"];
      if (quantityToBeReduced < quantity) {
        booksInTripListPath.doc(bookId).update({
          "quantity": quantity - quantityToBeReduced,
          "totalPrice": (quantity - quantityToBeReduced) * price
        });
      } else if (quantityToBeReduced == quantity) {
        booksInTripListPath.doc(bookId).delete();
      }
    }
  }
}
