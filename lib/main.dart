import 'package:flutter/material.dart';
import 'package:passgen/widgets/number_input.dart';
import "package:passgen/backend.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, primary: Colors.blue.shade600),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController lengthController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Future<void> copyPass() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Icon(Icons.task_alt, color: Colors.white,)),
          Expanded(flex: 9, child: Text("Password copied successfully!"),)
        ],
      ),
      padding: EdgeInsets.all(4.0),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating
    ));

    await api.copyPassword(pass: passController.text);
  }

  Future<void> generatePass() async {
    passController.text =
        await api.generatePassword(len: int.parse(lengthController.text));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await generatePass();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                "Password Generator",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              NumberInput(
                  min: 2,
                  max: 50,
                  defaultLength: 10,
                  controller: lengthController),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.number,
                      controller: passController,
                      readOnly: true,
                    ),
                  ),
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 10),
                      child: IconButton.filled(
                        onPressed: copyPass,
                        icon: const Icon(Icons.copy, size: 20.0),
                      ),
                    ),
                  ]),
                ],
              ),
              FilledButton.icon(
                  onPressed: generatePass,
                  icon: const Icon(
                    Icons.autorenew,
                  ),
                  label: const Text(
                    "Generate",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
