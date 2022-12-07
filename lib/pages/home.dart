import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculateIMC() {
    double weigth = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weigth / (height * height);

    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(
                Icons.people,
                size: MediaQuery.of(context).size.height * .2,
              ),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Insira o peso!' : null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Peso')),
                controller: weightController,
              ),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Insira a altura!" : null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Altura')),
                controller: heightController,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculateIMC();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.calculate),
                      SizedBox(width: 12),
                      Text(
                        'Calcular',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(_infoText),
            ],
          ),
        ),
      ),
    );
  }
}
