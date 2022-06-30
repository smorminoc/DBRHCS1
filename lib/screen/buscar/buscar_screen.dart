import 'package:flutter/material.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({Key? key}) : super(key: key);

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text('Jose alberto'),
          trailing: Icon(Icons.flag, color: Colors.green,),
          onTap: () {
            print('Pressed');
          },
        ),
      ),
    );
  }
}