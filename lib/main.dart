import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Calculator'),
        //     centerTitle: true,
        //     backgroundColor: Colors.red[600]),
        body: Calculator());
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var buttons;
  String formula = '';
  String result;

  @override
  void initState() {
    super.initState();
    buttons = [
      [
        'C',
        'Del',
        '%',
        '/',
      ],
      [
        '7',
        '8',
        '9',
        '*',
      ],
      [
        '4',
        '5',
        '6',
        '+',
      ],
      ['1', '2', '3', '-'],
      ['0', '.', '=']
    ];
  }

  List<Widget> renderExpressionAndResult() {
    List<Widget> list = [
      Container(
          padding: EdgeInsets.only(right: 20),
          child: Text(formula,
              style: TextStyle(color: Colors.black, fontSize: 40)))
    ];

    if (result != null) {
      list.add(Container(
          padding: EdgeInsets.only(right: 20),
          child: Text(result,
              style: TextStyle(color: Colors.black, fontSize: 70))));
    }
    return list;
  }

  handlePressButton(String chac) {
    setState(() {
      if (chac == 'C') {
        formula = '';
        result = null;
      } else if (chac == 'Del') {
        if(formula != null && formula.length > 0)
          formula = formula.substring(0, formula.length - 1);
      } else if (chac == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(formula);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {}
      } else
        formula += chac;
    });
  }

  Expanded generateButton(String character) {
    return Expanded(
        flex: character == '0' ? 2 : 1,
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(5.0),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color:
                ['C', 'Del', '%', '/', '*', '+', '-', '='].contains(character)
                    ? character == '='
                        ? Colors.orange[800]
                        : Colors.orange[200]
                    : Colors.grey[300],
            onPressed: () {
              handlePressButton(character);
            },
            child: Text(character, style: TextStyle(fontSize: 20)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: renderExpressionAndResult(),
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        Expanded(
          flex: 2,
          child: Column(
              children: buttons
                  .map<Widget>((row) => Expanded(
                        child: Row(
                          children: row
                              .map<Widget>(
                                (character) => generateButton(character),
                              )
                              .toList(),
                        ),
                      ))
                  .toList()),
        )
      ]),
    );
  }
}