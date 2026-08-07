import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../services/database_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() =>
      _AnalyticsScreenState();
}


class _AnalyticsScreenState
    extends State<AnalyticsScreen> {


  Map<String, double> categoryData = {};

  double totalIncome = 0;

  double totalExpense = 0;



  final List<Color> chartColors = const [

    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,

  ];



  @override
  void initState() {

    super.initState();

    loadData();

  }



  void loadData() {

    categoryData =
        DatabaseService.getExpenseByCategory();


    totalIncome =
        DatabaseService.getTotalIncome();


    totalExpense =
        DatabaseService.getTotalExpense();



    setState(() {});

  }



  Color getChartColor(int index) {

    return chartColors[
      index % chartColors.length
    ];

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F7FA),


      appBar: AppBar(

        title: const Text(

          "Analytics",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,

          ),

        ),

      ),



      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [



            const Text(

              "Expense Distribution",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(height: 20),




            Container(

              height: 330,

              padding:
                  const EdgeInsets.all(20),


              decoration: BoxDecoration(

                color:
                    Colors.white,


                borderRadius:
                    BorderRadius.circular(20),

              ),




              child: categoryData.isEmpty


                  ? const Center(

                      child: Text(
                        "No expense data",
                      ),

                    )



                  : PieChart(

                      PieChartData(

                        sections:


                            categoryData.entries
                                .toList()
                                .asMap()
                                .entries
                                .map((item) {



                          final index =
                              item.key;


                          final entry =
                              item.value;




                          return PieChartSectionData(

                            value:
                                entry.value,


                            color:
                                getChartColor(index),


                            title:
                                "₹${entry.value.toInt()}",



                            radius:
                                85,



                            titleStyle:
                                const TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  12,

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          );



                        }).toList(),



                      ),

                    ),


            ),




            const SizedBox(height: 25),





            const Text(

              "Category Details",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(height: 10),





            ...categoryData.entries
                .toList()
                .asMap()
                .entries
                .map((item) {



              final index =
                  item.key;


              final entry =
                  item.value;




              return Card(

                elevation: 1,


                child: ListTile(


                  leading:
                      CircleAvatar(

                    backgroundColor:
                        getChartColor(index),

                  ),



                  title:
                      Text(entry.key),




                  trailing:
                      Text(

                    "₹${entry.value.toInt()}",


                    style:
                        const TextStyle(

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),



                ),

              );


            }),





            const SizedBox(height: 30),





            const Text(

              "Income vs Expense",

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),




            const SizedBox(height: 20),






            Container(

              height: 300,


              padding:
                  const EdgeInsets.all(20),



              decoration: BoxDecoration(

                color:
                    Colors.white,


                borderRadius:
                    BorderRadius.circular(20),

              ),




              child: BarChart(


                BarChartData(


                  alignment:
                      BarChartAlignment.spaceAround,



                  maxY:
                      (totalIncome > totalExpense
                              ? totalIncome
                              : totalExpense) +
                          500,



                  gridData:

                      FlGridData(

                    show:
                        true,


                    drawVerticalLine:
                        false,


                  ),




                  borderData:

                      FlBorderData(

                    show:
                        false,

                  ),





                  titlesData:

                      FlTitlesData(



                    topTitles:
                        const AxisTitles(

                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),

                    ),



                    rightTitles:
                        const AxisTitles(

                      sideTitles:
                          SideTitles(
                        showTitles: false,
                      ),

                    ),





                    leftTitles:

                        AxisTitles(

                      sideTitles:

                          SideTitles(

                        showTitles:
                            true,


                        reservedSize:
                            45,



                        getTitlesWidget:
                            (value, meta) {


                          return Text(

                            "₹${value.toInt()}",


                            style:
                                const TextStyle(

                              fontSize:
                                  10,

                            ),

                          );


                        },

                      ),

                    ),





                    bottomTitles:

                        AxisTitles(

                      sideTitles:

                          SideTitles(

                        showTitles:
                            true,



                        getTitlesWidget:
                            (value, meta) {


                          if(value == 0){

                            return const Text(

                              "Income",

                              style:
                                  TextStyle(

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            );

                          }



                          return const Text(

                            "Expense",

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          );


                        },

                      ),

                    ),


                  ),





                  barGroups: [



                    BarChartGroupData(

                      x: 0,


                      barRods: [


                        BarChartRodData(

                          toY:
                              totalIncome,


                          width:
                              45,


                          color:
                              Colors.green,


                          borderRadius:
                              BorderRadius.circular(12),


                        ),

                      ],

                    ),






                    BarChartGroupData(

                      x: 1,


                      barRods: [


                        BarChartRodData(

                          toY:
                              totalExpense,


                          width:
                              45,


                          color:
                              Colors.red,


                          borderRadius:
                              BorderRadius.circular(12),


                        ),


                      ],

                    ),



                  ],


                ),


              ),


            ),



          ],


        ),

      ),

    );

  }

}