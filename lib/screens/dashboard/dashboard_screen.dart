import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/database_service.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_tile.dart';
import '../transactions/add_transaction_screen.dart';


class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});


  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();

}




class _DashboardScreenState
    extends State<DashboardScreen> {


  List<Map<String, dynamic>> transactions = [];


  String selectedCategory = "All";



  final List<String> categories = [

    "All",
    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Education",
    "Health",
    "Entertainment",
    "Others",

  ];





  @override
  void initState() {

    super.initState();

    loadTransactions();

  }





  void loadTransactions() {


    setState(() {

      transactions =
          DatabaseService.getTransactions();

    });


  }






  List<Map<String, dynamic>> get filteredTransactions {


    if (selectedCategory == "All") {

      return transactions;

    }



    return transactions.where((transaction) {


      return transaction['category'] ==
          selectedCategory;


    }).toList();


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
          const Color(0xFFF5F7FA),






      appBar: AppBar(


        backgroundColor:
            Colors.transparent,


        elevation: 0,


        centerTitle: false,



        title: const Text(

          "Expense Tracker",

          style: TextStyle(

            color: Colors.black,

            fontWeight:
                FontWeight.bold,

          ),

        ),





        actions: [



          IconButton(

            onPressed: () {


              Navigator.pushNamed(

                context,

                '/analytics',

              );


            },


            icon: const Icon(

              Icons.analytics_outlined,

              color: Colors.black,

            ),


          ),





          IconButton(

            onPressed: () {},


            icon: const Icon(

              Icons.notifications_none,

              color: Colors.black,

            ),

          ),


        ],


      ),







      body: SingleChildScrollView(


        padding:
            const EdgeInsets.all(20),



        child: Column(


          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [





            const Text(

              "Good Morning 👋",

              style: TextStyle(

                fontSize: 18,

                color: Colors.grey,

              ),

            ),





            const SizedBox(height: 5),






            const Text(

              "Thamanna",

              style: TextStyle(

                fontSize: 30,

                fontWeight:
                    FontWeight.bold,

              ),

            ),





            const SizedBox(height: 25),





            BalanceCard(


              totalBalance:
                  DatabaseService.getTotalBalance(),



              totalIncome:
                  DatabaseService.getTotalIncome(),



              totalExpense:
                  DatabaseService.getTotalExpense(),


            ),






            const SizedBox(height: 25),





            SizedBox(


              height: 45,


              child: ListView.builder(


                scrollDirection:
                    Axis.horizontal,


                itemCount:
                    categories.length,



                itemBuilder:
                    (context, index) {


                  final category =
                      categories[index];




                  return Padding(


                    padding:
                        const EdgeInsets.only(
                          right: 10,
                        ),



                    child: ChoiceChip(


                      label:
                          Text(category),



                      selected:
                          selectedCategory ==
                              category,



                      onSelected: (_) {


                        setState(() {


                          selectedCategory =
                              category;


                        });


                      },


                    ),


                  );


                },


              ),


            ),






            const SizedBox(height: 30),






            const Text(

              "Recent Transactions",


              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),






            const SizedBox(height: 15),







            if (filteredTransactions.isEmpty)



              const Center(


                child: Padding(


                  padding:
                      EdgeInsets.all(20),



                  child: Text(


                    "No transactions found",



                    style: TextStyle(

                      fontSize: 18,

                      color: Colors.grey,

                    ),

                  ),


                ),


              )






            else



              ...filteredTransactions.map((transaction) {



                return TransactionTile(




                  icon:

                      transaction['type'] ==
                              "Income"

                          ? Icons.payments

                          : Icons.shopping_cart,






                  title:

                      transaction['title'],






                  category:

                      transaction['category']
                          ?? "Others",






                  date:

                      transaction['date'] != null

                          ? DateFormat(

                              'dd MMM yyyy • hh:mm a',

                            ).format(

                              DateTime.parse(

                                transaction['date'],

                              ),

                            )

                          : "Today",






                  amount:

                      "${transaction['type'] == "Income" ? "+" : "-"} ₹${transaction['amount']}",






                  income:

                      transaction['type'] ==
                          "Income",







                  onDelete: () async {


                    await DatabaseService.deleteTransaction(

                      transaction['key'],

                    );



                    loadTransactions();




                    if (context.mounted) {


                      ScaffoldMessenger.of(context)
                          .showSnackBar(


                        const SnackBar(

                          content:

                              Text(

                                "Transaction deleted",

                              ),

                        ),


                      );


                    }


                  },







                  onEdit: () async {


                    await Navigator.push(


                      context,


                      MaterialPageRoute(


                        builder: (_) =>

                            AddTransactionScreen(

                              transaction:
                                  transaction,

                            ),


                      ),


                    );



                    loadTransactions();


                  },




                );


              }),




          ],


        ),


      ),








      floatingActionButton:

          FloatingActionButton(



        onPressed: () async {


          await Navigator.push(


            context,


            MaterialPageRoute(


              builder: (_) =>

                  const AddTransactionScreen(),


            ),


          );



          loadTransactions();


        },



        child:

            const Icon(Icons.add),


      ),



    );


  }


}