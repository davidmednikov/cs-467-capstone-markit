import 'package:barcode_scan/barcode_scan.dart';

Future<String> scanBarcode() async {
  ScanResult result = await BarcodeScanner.scan();
  print(result.type); // The result type (barcode, cancelled, failed)
  print(result.rawContent); // The barcode content
  print(result.format); // The barcode format (as enum)
  print(result.formatNote); // If a u
  if (result.type.toString() != 'Barcode') {
    return null;
  }
  return result.rawContent;
}