import 'package:flutter/material.dart';


class TransactionTile extends StatelessWidget {


  final IconData icon;

  final String title;

  final String category;

  final String date;

  final String amount;

  final bool income;

  final VoidCallback? onDelete;

  final VoidCallback? onEdit;




  const TransactionTile({

    super.key,

    required this.icon,

    required this.title,

    required this.category,

    required this.date,

    required this.amount,

    required this.income,

    this.onDelete,

    this.onEdit,

  });






  @override
  Widget build(BuildContext context) {


    return Dismissible(


      key: UniqueKey(),


      direction: DismissDirection.endToStart,



      background: Container(


        alignment:
            Alignment.centerRight,


        padding:
            const EdgeInsets.only(
              right: 20,
            ),


        color: Colors.red,



        child: const Icon(


          Icons.delete,


          color: Colors.white,


        ),


      ),




      onDismissed: (_) {


        if (onDelete != null) {


          onDelete!();


        }


      },






      child: Card(


        elevation: 2,



        child: ListTile(



          leading: CircleAvatar(


            child: Icon(icon),


          ),




          title: Text(


            title,


            style: const TextStyle(


              fontWeight:
                  FontWeight.bold,


            ),


          ),





          subtitle: Column(


            crossAxisAlignment:
                CrossAxisAlignment.start,



            children: [



              Text(


                category,


                style: const TextStyle(


                  color: Colors.grey,


                  fontSize: 13,


                ),


              ),




              Text(date),



            ],


          ),





          trailing: Row(


            mainAxisSize:
                MainAxisSize.min,



            children: [



              IconButton(


                icon: const Icon(

                  Icons.edit,

                  color: Colors.blue,

                ),



                onPressed: () {


                  if (onEdit != null) {


                    onEdit!();


                  }


                },


              ),





              Text(


                amount,



                style: TextStyle(


                  color: income
                      ? Colors.green
                      : Colors.red,



                  fontWeight:
                      FontWeight.bold,



                  fontSize: 16,


                ),


              ),



            ],


          ),



        ),


      ),


    );


  }


}