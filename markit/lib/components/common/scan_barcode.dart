import 'package:barcode_scan/barcode_scan.dart';

Future<String> scanBarcode() async {
  ScanResult result = await BarcodeScanner.scan();
  if (result.type.toString() != 'Barcode') {
    return null;
  }
  return result.rawContent;
}