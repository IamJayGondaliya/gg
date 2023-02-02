import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GuessingGame(),
    ),
  );
}

class GuessingGame extends StatefulWidget {
  const GuessingGame({Key? key}) : super(key: key);

  @override
  State<GuessingGame> createState() => _GuessingGameState();
}

class _GuessingGameState extends State<GuessingGame> {
  String animalPath = "assets/images/animals/";

  List<Map<String, dynamic>> animals = [];

  Random r = Random();
  late int i;
  String name = "";

  @override
  void initState() {
    super.initState();
    animals = [
      {
        'id': 1,
        'image': "${animalPath}rhino.png",
        'name': "rhino",
        'chances': 3,
      },
      {
        'id': 2,
        'image': "${animalPath}fish.png",
        'name': "fish",
        'chances': 3,
      },
      {
        'id': 3,
        'image': "${animalPath}fox.png",
        'name': "fox",
        'chances': 3,
      },
    ];

    i = r.nextInt(animals.length);
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Guessing Game"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  i = r.nextInt(animals.length);
                });
              },
              icon: Icon(Icons.change_circle_outlined))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //Chances
            Expanded(
              child: Row(
                children: List.generate(
                  animals[i]['chances'],
                  (index) => Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            //Animal
            Expanded(
              flex: 3,
              child: Image.asset(animals[i]['image']),
            ),
            //Name
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  animals[i]['name'].length,
                  (index) => Container(
                    height: w * 0.1,
                    width: w * 0.1,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            //Options
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    26,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                        width: w * 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
