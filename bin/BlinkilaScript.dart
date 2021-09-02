import "dart:io";
import "dart:async";
import "dart:convert";
import "package:csv/csv.dart";

void main(List<String> args) {
  String sourceURL = "https://raw.githubusercontent.com/IchigoJam/ascii-morse/main/ascii-morse.csv";
  HttpClient client = HttpClient();
  client.getUrl(Uri.parse(sourceURL)).then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.transform(utf8.decoder).listen((contents) {
      List<List<String>> rowsAsListOfValues = contents.split("\n").map((String row)=>row.split(", ")).toList();
      print(rowsAsListOfValues);
    });
  });
}