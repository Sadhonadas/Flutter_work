import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project/widgets/input_field.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ConverterPageState();
  }
}

class _ConverterPageState extends State<ConverterPage>{
  TextEditingController controller = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: 
    AppBar(title : Text("Converter page"),
    backgroundColor: Colors.blue.shade200,
    foregroundColor: Colors.black,
    ),
    body: Center(child: SizedBox(height: 400,width: 300,
    child:Card(color:  Colors.blue.shade200,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Form(
          key: _formKey,
          child: Column(
            children: [
                        InputField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                          hintText: "Enter password",
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                        ),

                        const SizedBox(height: 20),
                        InputField(
                          controller: controller,
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Amount cannot be empty";
                            }
                            return null;
                          },
                          hintText: "Enter amount",
                          labelText: "Amount",
                          prefixIcon: const Icon(Icons.monetization_on),
                        ),
                      ],
                    ),
                  ),

                 SizedBox(height: 30),
       ElevatedButton(onPressed: (){
        if(_formKey.currentState!.validate()){
          result = double.parse(controller.text) * 122.95;
           
        }
        setState(() {});
       }, 
       child: Text("Convert")),
       SizedBox(height: 20),
      Text("BDT:$result"),
        ],
      ),
    ),
    )),
    ),
    );
  }

}