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

  List nameList = [];

  List<Map<String, dynamic>> animals = [];
  int nameIndex = 0;
  int chances = 0;
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
    chances = animals[i]['chances'];
    nameList = List.generate(animals[i]['name'].length, (index) => null);
  }

  void reload() {
setState(() {
  i = r.nextInt(animals.length);
  chances = animals[i]['chances'];
  nameList = List.generate(animals[i]['name'].length, (index) => null);
});
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
                reload();
              },
              icon: Icon(Icons.change_circle_outlined))
        ],
      ),
      body: Center(
        child: (chances > 0)
            //Game
            ? Column(
                children: [
                  //Chances
                  Expanded(
                    child: Row(
                      children: List.generate(
                        chances,
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
                            image: (nameList[index] == null)
                                ? null
                                : DecorationImage(
                                    image: AssetImage(
                                        "assets/images/pieces/${nameList[index]}.png"),
                                  ),
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
                            child: InkWell(
                              onTap: () {
                                if (animals[i]['name'][nameIndex] ==
                                    String.fromCharCode(index + 97)) {
                                  setState(() {
                                    nameList[nameIndex] =
                                        String.fromCharCode(index + 97);
                                        if(nameIndex < animals[i]['name'].length-1) {
                                          nameIndex++;
                                        }
                                        else {
                                          reload();
                                        }
                                  });
                                } else {
                                  setState(() {
                                    chances -= 1;
                                  });
                                }
                              },
                              child: Image.asset(
                                "assets/images/pieces/${String.fromCharCode(index + 97)}.png",
                                width: w * 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            //Lose
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You Lose",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        i = r.nextInt(animals.length);
                        chances = animals[i]['chances'];
                        nameIndex = 0;
                      });
                    },
                    child: const Text("RESTART"),
                  ),
                ],
              ),
      ),
    );
  }
}
