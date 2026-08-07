import 'package:hive_flutter/hive_flutter.dart';


class DatabaseService {


  static final Box _box = Hive.box('transactions');





  // Add Transaction
  static Future insertTransaction(
    String title,
    double amount,
    String type,
    String category,
  ) async {


    await _box.add({

      'title': title,

      'amount': amount,

      'type': type,

      'category': category,

      'date': DateTime.now().toIso8601String(),

    });


  }







  // Get All Transactions
  static List<Map<String, dynamic>> getTransactions() {


    return _box.keys.map((key) {


      final transaction =
          Map<String, dynamic>.from(
            _box.get(key),
          );


      transaction['key'] = key;


      return transaction;


    }).toList().reversed.toList();


  }








  // Delete Transaction
  static Future deleteTransaction(dynamic key) async {


    await _box.delete(key);


  }








  // Update Transaction
  static Future updateTransaction(

    dynamic key,

    String title,

    double amount,

    String type,

    String category,

  ) async {


    await _box.put(key, {


      'title': title,


      'amount': amount,


      'type': type,


      'category': category,


      'date':
          DateTime.now().toIso8601String(),


    });


  }








  // Total Balance
  static double getTotalBalance() {


    double total = 0;



    for (var item in _box.values) {


      final transaction =
          Map<String, dynamic>.from(item);



      if (transaction['type'] == 'Income') {


        total += transaction['amount'];



      } else {


        total -= transaction['amount'];



      }


    }



    return total;


  }








  // Total Income
  static double getTotalIncome() {


    double income = 0;



    for (var item in _box.values) {


      final transaction =
          Map<String, dynamic>.from(item);



      if (transaction['type'] == 'Income') {


        income += transaction['amount'];



      }


    }



    return income;


  }








  // Total Expense
  static double getTotalExpense() {


    double expense = 0;



    for (var item in _box.values) {


      final transaction =
          Map<String, dynamic>.from(item);



      if (transaction['type'] == 'Expense') {


        expense += transaction['amount'];



      }


    }



    return expense;


  }








  // Expense grouped by Category
  static Map<String, double> getExpenseByCategory() {


    Map<String, double> categoryData = {};



    for (var item in _box.values) {


      final transaction =
          Map<String, dynamic>.from(item);



      if (transaction['type'] == 'Expense') {


        String category =
            transaction['category'] ?? "Others";



        double amount =
            transaction['amount'];



        categoryData[category] =
            (categoryData[category] ?? 0) + amount;


      }


    }



    return categoryData;


  }




}