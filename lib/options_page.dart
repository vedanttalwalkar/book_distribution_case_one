import 'package:book_distribution_case_one/book_distribution_listing_page/book_distribution_listing_page_main.dart';
import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const BookDistributionListingPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.maxFinite,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.deepPurple),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: const Center(
                    child: Column(
                  children: [
                    Image(image: AssetImage('images/list_icon.png')),
                    Text(
                      "Book List",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
