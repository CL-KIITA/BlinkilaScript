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
      List<List<String>> rowsAsListOfValues = contents.split("\n").map((String row)=>row.split(",")).toList();
      List<List<String>> rowsAsListOfValuesFd = rowsAsListOfValues.skip(1).where((List<String> row)=>row.length==3).map((List<String> row){
        if(row[0].contains("\"\"\"\"")){
          row[0]="\"";
        }
        return row;
      }).toList();
      List<String> asciiList = rowsAsListOfValuesFd.map((List<String> row)=>row[0]).toList();
      List<List<String>> morseList = rowsAsListOfValuesFd.map((List<String> row)=>row.take(2).toList()).toList();
      print(asciiList.toString()+"\n\n"+morseList.toString()+"\n\n");
    });
  });
}