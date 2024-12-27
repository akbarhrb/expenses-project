// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String baseUrl = "flutterapp1.atwebpages.com";

class Income {
  int? amount;
  String? month;

  Income({required this.amount, required this.month});

  static List<Income> incomes = [];
  static final Map<int, String> monthNames = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
  };

  static Future<String> addIncome(int amount, int monthNb) async {
    try {
      final url = Uri.parse("http://flutterapp1.atwebpages.com/addInc.php");
      print(url);
      final response = await http.post(url,
          body: {'amount': amount.toString(), 'monthNb': monthNb.toString()});
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(convert.jsonDecode(response.body));
        final jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse['message'];
      } else {
        print(convert.jsonDecode(response.body));
        final jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse['message'];
      }
    } catch (e) {
      print(e.toString());
      return '=======error=======';
    }
  }

  static Future<List<Income>> getIncomes() async {
    try {
      final url = Uri.http(baseUrl, "getIncomes.php");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        incomes.clear();
        for (var row in jsonResponse) {
          int monthNb = int.tryParse(row['monthNb']) as int;
          String month = monthNames[monthNb] as String;
          int amount = int.tryParse(row['amount']) as int;
          Income income = Income(amount: amount, month: month);
          incomes.add(income);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
    return incomes;
  }
}
