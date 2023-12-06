import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_bloc.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_event.dart';
import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDistributionListingPage extends StatelessWidget {
  const BookDistributionListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDistributionListingPageBloc()..add(LoadBooks()),
      child:  const BookDistributionPageScreen(),
    );
  }
}
