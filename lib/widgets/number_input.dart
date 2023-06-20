import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final int min, max, defaultLength;
  final TextEditingController controller;
  const NumberInput(
      {super.key,
      required this.min,
      required this.max,
      required this.controller,
      this.defaultLength = 2});

  @override
  State<NumberInput> createState() {
    return _NumberInput(
        length: defaultLength, min: min, max: max, controller: controller);
  }
}

class _NumberInput extends State<NumberInput> {
  int length, min, max;
  TextEditingController controller;

  _NumberInput(
      {required this.length,
      required this.min,
      required this.max,
      required this.controller}) {
    controller.text = length.toString();
  }

  void increment() {
    setState(() {
      if (length != max) {
        length += 1;
        controller.text = length.toString();
      }
    });
  }

  void decrement() {
    setState(() {
      if (length != min) {
        length -= 1;
        controller.text = length.toString();
      }
    });
  }

  void handleChange(value) {
    setState(() {
      try {
        int len = int.parse(value);
        setState(() {
          if (len > max) {
            controller.text = max.toString();
          } else if (len < min) {
            controller.text = min.toString();
          }
          length = len;
        });
      } catch (e) {
        controller.text = min.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Length", contentPadding: EdgeInsets.all(0)),
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: handleChange,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                "The length can be a minimum of $min and a maximum of $max",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        )),
        Column(
          children: [
            MaterialButton(
                minWidth: 0.5,
                onPressed: increment,
                padding: const EdgeInsets.all(0),
                height: 1.0,
                child: const Icon(Icons.arrow_drop_up)),
            MaterialButton(
                minWidth: 0.5,
                onPressed: decrement,
                padding: const EdgeInsets.all(0),
                height: 1.0,
                child: const Icon(Icons.arrow_drop_down)),
          ],
        ),
      ],
    );
  }
}
