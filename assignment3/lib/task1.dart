import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.purpleAccent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Counter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  int counter2 = 0;
  int height = 170; // initial value inside slider range
  String? gender;

  void compareScore() {
    String message;
    if (counter > counter2) {
      message = 'Team A won!';
    } else if (counter2 > counter) {
      message = 'Team B won!';
    } else {
      message = 'It is a tie!';
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void calculateBMI() {
    if (height <= 0 || counter <= 0 || gender == null) return;

    double heightMeters = height / 100.0;
    double bmi = counter / (heightMeters * heightMeters);

    String category;
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi < 25) {
      category = "Normal";
    } else if (bmi < 30) {
      category = "Overweight";
    } else {
      category = "Obese";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepPurple,
        content: Text(
          "BMI: ${bmi.toStringAsFixed(1)} ($category)\n"
          "Gender: $gender, Age: $counter2",
          style: TextStyle(fontSize: 30),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: HexColor("#0d0e1e")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#0d0e1e"), HexColor("#111328")],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  color: HexColor("#111328"),
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: const Text(
                    "B.M.I Calculator",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gender = "male";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#1d1e33"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(185, 150),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.male, color: Colors.white, size: 50),
                          SizedBox(height: 10),
                          Text('MALE', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gender = "female";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#1d1e33"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(185, 150),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.female, color: Colors.white, size: 50),
                          SizedBox(height: 10),
                          Text('FEMALE', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: HexColor("#673ab7"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "HEIGHT",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),

                      // Row for number and cm, centered
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$height",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "cm",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),

                      // Slider
                      Slider(
                        value: height.toDouble(),
                        min: 50,
                        max: 250,
                        divisions: 200,
                        activeColor: Colors.white,
                        thumbColor: Colors.pinkAccent,
                        label: "$height cm",
                        onChanged: (value) {
                          setState(() {
                            height = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Weight Box
                    Container(
                      width: 185,
                      height: 150,
                      decoration: BoxDecoration(
                        color: HexColor("#673ab7"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'WEIGHT',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: const Size(50, 50),

                                  backgroundColor: HexColor("#22133e"),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (counter > 0) counter--;
                                  });
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: const Size(50, 50),

                                  backgroundColor: HexColor("#22133e"),
                                ),

                                onPressed: () {
                                  setState(() {
                                    counter++;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // Age Box
                    Container(
                      width: 185,
                      height: 150,
                      decoration: BoxDecoration(
                        color: HexColor("#673ab7"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'AGE',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '$counter2',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: const Size(50, 50),

                                  backgroundColor: HexColor("#22133e"),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (counter2 > 0) counter2--;
                                  });
                                },
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: const Size(50, 50),
                                  backgroundColor: HexColor("#22133e"),
                                ),
                                onPressed: () {
                                  setState(() {
                                    counter2++;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: calculateBMI,
                  child: const Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(400, 50), // width x height
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
