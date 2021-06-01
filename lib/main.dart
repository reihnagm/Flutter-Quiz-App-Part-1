import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int groupValue = 0;
  List<Map<dynamic, dynamic>> answered = [];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose the correct answer by fill circle", 
          style: TextStyle(
            fontSize: 17.0
          ),
        ),
      ),
      body: ListView(
        children: [

          // List of Questions
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  elevation: .8,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1. 1 + 1"),
                        SizedBox(height: 8.0),
                        RadioListTile(
                          value: 1, 
                          groupValue: groupValue, 
                          onChanged: (val) {
                            setState(() {
                              groupValue = val;
                            });
                            answered.add({
                              "answered": true,
                              "sign": 1
                            });
                          },
                          title: Text("2"),
                        ),
                        RadioListTile(
                          value: 2, 
                          groupValue: groupValue, 
                          onChanged: (val) {
                            setState(() {
                              groupValue = val;
                            });
                            answered.add({
                              "answered": false,
                              "sign": 1
                            });
                          },
                          title: Text("4"),
                        ),
                          RadioListTile(
                          value: 3, 
                          groupValue: groupValue, 
                          onChanged: (val) {
                            setState(() {
                              groupValue = val;
                            });
                            answered.add({
                              "answered": false,
                              "sign": 1
                            });
                          },
                          title: Text("6"),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),


          // Submit Button
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {     

              Map<dynamic, dynamic> mp = {};
              for (var item in answered) {
                mp["sign"] = item;
              }
              var filteredList = mp.values.toList();

              var wrongAnswer = filteredList.where((element) => element["answered"] == false).length;
              var correctAnswer = filteredList.where((element) => element["answered"] == true).length;
              var point = (filteredList.where((element) => element["answered"] == true).length / 1 * 100).toStringAsFixed(0);      

              // Show Pop Up
              showModalBottomSheet(
                context: context, 
                builder: (context) {
                  return Container(
                    height: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        if(int.parse(point) > 70)
                          Container(
                            child: Text("YOU PASSED!",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.green
                              ),
                            ),
                          ),
                        if(int.parse(point) < 70) 
                          Container(
                            child: Text("YOU FAIL!",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.red
                              ),
                            ),
                          ),
                        
                        SizedBox(height: 8.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Score : "),
                            ),
                            Container(
                              child: Text(point.toString())
                            )
                          ],
                        ),

                        SizedBox(height: 8.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Correct Answer : ",
                                style: TextStyle(
                                  color: Colors.green
                                ), 
                              ),
                            ),
                            Container(
                              child: Text(correctAnswer.toString())
                            )
                          ],
                        ),

                        SizedBox(height: 8.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Wrong Answer : ",
                                style: TextStyle(
                                  color: Colors.red
                                ), 
                              ),
                            ),
                            Container(
                              child: Text(wrongAnswer.toString())
                            )
                          ],
                        ),

                      ]
                    ),
                  );
                });
              },
              child: Text("Submit"),
            ),
          )


        ],
      )
    );
  }
}
