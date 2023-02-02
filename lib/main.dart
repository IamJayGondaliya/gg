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

  int score = 0;

  bool isDone = false;

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
      {
        'id': 4,
        'image': "${animalPath}deer.png",
        'name': "deer",
        'chances': 3,
      },
      {
        'id': 5,
        'image': "${animalPath}kangaroo.png",
        'name': "kangaroo",
        'chances': 3,
      },
      {
        'id': 6,
        'image': "${animalPath}parrot.png",
        'name': "parrot",
        'chances': 3,
      },
      {
        'id': 7,
        'image': "${animalPath}squirrel.png",
        'name': "squirrel",
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
      nameIndex = 0;
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
            icon: const Icon(Icons.change_circle_outlined),
          ),
        ],
      ),
      body: Center(
        child: (chances > 0)
            //Game
            ? Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  children: [
                    //Chances
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(
                              chances,
                              (index) => Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Text("Score: $score",style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),),
                        ],
                      ),
                    ),
                    //Animal
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Image.asset(animals[i]['image']),
                            Image.asset(
                              animals[i]['image'],
                              color: Colors.black.withOpacity(
                                (1 -
                                    (1 -
                                        (1 / ((nameIndex == 0) ? 1 : nameIndex))
                                            .toDouble())),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Name
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          animals[i]['name'].length,
                          (index) => Container(
                            height: w * 0.1,
                            width: w / (animals[i]['name'].length * 1.5),
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
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                                        if (nameIndex <
                                            animals[i]['name'].length - 1) {
                                          nameIndex++;
                                        } else {
                                          isDone = true;
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        chances -= 1;
                                        score-=2;
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isDone) {
                            nameIndex++;
                            score+=10;
                            reload();
                          }
                        },
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                ),
            )
            //Lose
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You Lose",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      reload();
                    },
                    child: const Text("RESTART"),
                  ),
                ],
              ),
      ),
    );
  }
}
