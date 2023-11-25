import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController historyController = TextEditingController();
  TextEditingController mainDisplayController = TextEditingController();

  // Mini Display values
  String mainNum = "", historyNum = "", nowNumber = "";
  late double ansValue = 0, currentNumber;
  String currentOperator = "null";
  // Boolean values of different state of the program
  bool firstNumber = true, numTurn = true, onEqual = false;
  double fontSize = 5;

  void onEqualFunction() {

  }

  // When user pressed a number in number pad
  void numberPressed(Object num) {
    numTurn = true;
    fontSize = 5;


    setState(() {
      // Whole number sting displays on the main display
      mainNum += num.toString();
      // Store only the sting of the current number
      nowNumber += num.toString();

      // Activate only when operator is not null position
      if(currentOperator != " null") {
        switch(currentOperator) {
          case "+":
            ansValue = currentNumber + double.parse(nowNumber);
            break;
          case "-":
            ansValue = currentNumber - double.parse(nowNumber);
            break;
          case "x":
            ansValue = currentNumber * double.parse(nowNumber);
            break;
          case "/":
            ansValue = currentNumber / double.parse(nowNumber);
            break;
        }
      } else {
        ansValue = double.parse(nowNumber);
      }
    });
  }

  // Activated when you pressed operator symbol
  void operator(String operator) {
    numTurn = false;

    // Check whether current position is on equal
    if(onEqual) {
      mainNum = currentNumber.toString();
      onEqual = false;
    } else if(firstNumber) {
      currentNumber = double.parse(nowNumber);
      firstNumber = false;
    } else {
      currentNumber = ansValue;
    }
    nowNumber = "";

    setState(() {
      mainNum += operator;
    });
    currentOperator = operator;
  }


  // When user pressed equal sign
  void onEqualPressed() {
    onEqual = true;
    if(!firstNumber && numTurn) {
      fontSize = -5;
      setState(() {
        historyNum += "$mainNum\n";
        mainNum = "";
      });
      currentNumber = ansValue;
    }
  }

  void clearAll() {
    mainNum = "";
    currentOperator = "null";
    firstNumber = true;
    numTurn = true;
    onEqual = false;

  }

  @override
  Widget build(BuildContext context) {
    // Screen height and width
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    double miniScreenH = screenH*0.3;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF261F1F),
      body: Center(
        child: Column(
        children: [
          // Display of the calculator app
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
            width: double.infinity,
            height: miniScreenH,
            decoration: const BoxDecoration(
                color: Color(0xFFD2D2D2),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Column(
              children: [
                // History
                SizedBox(
                  width: double.infinity,
                  height: (miniScreenH-20)*0.70,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Text(historyNum, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF595959)),),
                  ),
                ),


                // Main Display
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  height: (miniScreenH-20)*(0.15+fontSize*0.01),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(mainNum, style: TextStyle(fontSize: (35+fontSize*2), fontWeight: FontWeight.bold, color: Colors.black),)),
                ),

                // Answer display area
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  height: (miniScreenH-20)*(0.15-fontSize*0.01),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text("=$ansValue", style: TextStyle(fontSize: (35-fontSize*2), fontWeight: FontWeight.bold, color: (fontSize < 0)? Colors.black :const Color(0xFF595959)),)),
                ),

              ]
            ),
          ),

          // Pressed Button Container

          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: screenH*0.70-90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              // Upper most row
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    // All clear button
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () {
                        setState(() {
                          mainNum = "";
                          historyNum = "";
                        });
                      },
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF230505),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("AC", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                    SizedBox(
                      width: screenW/4 - 15,
                      height: screenW/4 - 15,
                    ),

                    // Division Sign
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => operator('/'),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("/", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Backspace Button
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () {

                      },
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Icon(Icons.backspace, color: Colors.white, size: 35,),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Number 7
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => numberPressed(7),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("7", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 8
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(8),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("8", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 9
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(9),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("9", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Multiplication Icon
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => operator("x"),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("x", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Number 4
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(4),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("4", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 5
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(5),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("5", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 6
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(6),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("6", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Minus mark
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => operator("-"),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("-", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Number 1
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(1),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("1", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 2
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(2),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("2", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Number 3
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(3),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("3", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Plus mark
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => operator("+"),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("+", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: screenW/4 - 15,
                      height: screenW/4 - 15,
                      ),

                    // Number 0
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed(0),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("0", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Decimal point
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: ()  => numberPressed("."),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text(".", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),

                    // Equal Sign
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.white,
                      onTap: () => onEqualPressed(),
                      child: Ink(
                        width: screenW/4 - 15,
                        height: screenW/4 - 15,
                        decoration: BoxDecoration(
                            color: const Color(0xFF230505),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 3, color: const Color(0xFFF29900))
                        ),
                        child: const Center(child: Text("=", style: TextStyle(color: Colors.white, fontSize: 41, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),),
    );
  }
}
