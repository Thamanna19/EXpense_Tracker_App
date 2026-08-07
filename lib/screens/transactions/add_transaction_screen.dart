import 'package:flutter/material.dart';
import '../../services/database_service.dart';


class AddTransactionScreen extends StatefulWidget {

  final Map<String, dynamic>? transaction;


  const AddTransactionScreen({

    super.key,

    this.transaction,

  });



  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();

}




class _AddTransactionScreenState
    extends State<AddTransactionScreen> {



  final TextEditingController titleController =
      TextEditingController();



  final TextEditingController amountController =
      TextEditingController();



  String selectedType = "Expense";


  String selectedCategory = "Food";



  final List<String> expenseCategories = [

    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Education",
    "Health",
    "Entertainment",
    "Others",

  ];



  final List<String> incomeCategories = [

    "Salary",
    "Business",
    "Gift",
    "Investment",
    "Others",

  ];



  bool get isEditing =>
      widget.transaction != null;





  @override
  void initState() {

    super.initState();



    if (isEditing) {


      titleController.text =
          widget.transaction!['title'];


      amountController.text =
          widget.transaction!['amount'].toString();



      selectedType =
          widget.transaction!['type'];



      selectedCategory =
          widget.transaction!['category'] ?? "Others";


    }


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
          const Color(0xFF121212),



      appBar: AppBar(

        backgroundColor:
            const Color(0xFF121212),

        elevation: 0,

        foregroundColor:
            Colors.white,

        centerTitle: true,


        title: Text(

          isEditing
              ? "Edit Transaction"
              : "Add Transaction",


          style: const TextStyle(

            fontWeight:
                FontWeight.bold,

          ),

        ),

      ),




      body: Padding(

        padding:
            const EdgeInsets.all(20),



        child: Column(

          children: [



            TextField(

              controller:
                  titleController,


              style:
                  const TextStyle(
                    color: Colors.white,
                  ),


              decoration:
                  inputDecoration("Title"),


            ),





            const SizedBox(height: 20),





            TextField(

              controller:
                  amountController,


              keyboardType:
                  TextInputType.number,


              style:
                  const TextStyle(
                    color: Colors.white,
                  ),


              decoration:
                  inputDecoration("Amount"),


            ),






            const SizedBox(height: 20),






            DropdownButtonFormField<String>(


              value:
                  selectedType,


              dropdownColor:
                  const Color(0xFF1E1E1E),



              style:
                  const TextStyle(
                    color: Colors.white,
                  ),



              decoration:
                  inputDecoration(
                    "Transaction Type",
                  ),



              items: const [


                DropdownMenuItem(

                  value: "Income",

                  child:
                      Text("Income"),

                ),



                DropdownMenuItem(

                  value: "Expense",

                  child:
                      Text("Expense"),

                ),


              ],



              onChanged: (value) {


                setState(() {


                  selectedType =
                      value!;


                  selectedCategory =
                      selectedType == "Expense"
                          ? "Food"
                          : "Salary";


                });


              },


            ),






            const SizedBox(height: 20),





            DropdownButtonFormField<String>(


              value:
                  selectedCategory,



              dropdownColor:
                  const Color(0xFF1E1E1E),



              style:
                  const TextStyle(
                    color: Colors.white,
                  ),



              decoration:
                  inputDecoration(
                    "Category",
                  ),



              items:

                  (selectedType == "Expense"
                      ? expenseCategories
                      : incomeCategories)

                      .map(

                        (category) =>
                            DropdownMenuItem(

                              value:
                                  category,

                              child:
                                  Text(category),

                            ),

                      )

                      .toList(),




              onChanged: (value) {


                setState(() {


                  selectedCategory =
                      value!;


                });


              },


            ),






            const SizedBox(height: 40),






            SizedBox(

              width:
                  double.infinity,


              height:
                  55,



              child:
                  ElevatedButton(


                style:
                    ElevatedButton.styleFrom(


                  backgroundColor:
                      Colors.blue,


                  foregroundColor:
                      Colors.white,



                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(12),

                  ),


                ),




                onPressed: () async {



                  if (titleController.text.isEmpty ||
                      amountController.text.isEmpty) {


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                            Text(
                              "Please fill all fields",
                            ),

                      ),

                    );


                    return;


                  }






                  if (isEditing) {


                    await DatabaseService.updateTransaction(

                      widget.transaction!['key'],


                      titleController.text,


                      double.parse(
                        amountController.text,
                      ),


                      selectedType,


                      selectedCategory,


                    );


                  } else {


                    await DatabaseService.insertTransaction(

                      titleController.text,


                      double.parse(
                        amountController.text,
                      ),


                      selectedType,


                      selectedCategory,


                    );


                  }





                  Navigator.pop(context);



                },





                child:
                    Text(

                  isEditing
                      ? "Update Transaction"
                      : "Save Transaction",



                  style:
                      const TextStyle(

                    fontSize:
                        18,


                    fontWeight:
                        FontWeight.bold,


                  ),


                ),


              ),

            ),


          ],


        ),


      ),


    );


  }






  InputDecoration inputDecoration(String label) {


    return InputDecoration(


      labelText:
          label,


      labelStyle:
          const TextStyle(
            color: Colors.white70,
          ),



      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(12),


        borderSide:
            const BorderSide(
              color: Colors.white,
            ),


      ),




      focusedBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(12),


        borderSide:
            const BorderSide(

              color:
                  Colors.blue,

              width:
                  2,

            ),


      ),


    );


  }



}