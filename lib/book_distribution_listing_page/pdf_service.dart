import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui';

import 'package:book_distribution_case_one/classes/book_in_trip_list.dart';
import 'package:book_distribution_case_one/database/database.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFService {
  Future<void> printPDF() async {
    PdfDocument document = PdfDocument();
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 5);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    List<String> headerNames = [
      "Sr. No.",
      "Book Name",
      "Price per Book",
      "Quantity",
      "Total Price"
    ];
    for (var i = 0; i < headerNames.length; i++) {
      header.cells[i].value = headerNames[i];
    }
    header.style = PdfGridCellStyle(
        backgroundBrush: PdfBrushes.lightGray,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 14));

    List<BookInTripList> booksInTrip = await Database.database.fetchTripBooks();
    int i = 1;
    double finalPrice = 0.0;
    for (var element in booksInTrip) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = i.toString();
      row.cells[1].value = element.name;
      row.cells[2].value = element.price.toString();
      row.cells[3].value = element.quantity.toString();
      row.cells[4].value = element.totalPrice.toString();
      i++;
      finalPrice += element.totalPrice;
    }
    PdfGridRow row = grid.rows.add();
    row.style = PdfGridCellStyle(
      borders: PdfBorders(
          left: PdfPens.transparent,
          right: PdfPens.transparent,
          top: PdfPens.transparent),
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 15),
    );
    row.cells[0].value = "Total Price";
    row.cells[1].value = finalPrice.toString();
    row.cells[3].value = "Sign : ";

    grid.style = PdfGridStyle(
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 11),
        cellPadding: PdfPaddings(left: 10, right: 3, top: 4, bottom: 5));
    grid.columns[1].width = 200;
    grid.columns[0].width = 60;
    grid.columns[3].width = 80;

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "report.pdf")
      ..click();
    document.dispose();
  }
}
