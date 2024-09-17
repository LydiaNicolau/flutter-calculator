import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lydia Nicolau\'s Calculator',
      home: CalculatorScreen(),
    );
  }
}
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';  
  String _expression = '';  
  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
        _expression = '';
      } else if (value == '=') {
        if (_expression.contains('/0')) {
          _display = 'Undefined';
        } else {
          try {
            final expression = Expression.parse(_expression);
            const evaluator = ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _display = '$_expression = $result';
          } catch (e) {
            _display = 'Error';
          }
        }
      } else {
        _expression += value;
        _display = _expression;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(value),
        child: Text(value, style: TextStyle(fontSize: 24, color: Colors.pink[300])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lydia Nicolau\'s Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 32, color: Colors.pink),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}