import 'package:flutter/material.dart';
import 'package:rhcs/screen/agregar/agregar_screen.dart';
import 'package:rhcs/screen/buscar/buscar_screen.dart';

import '../constantes/constantes.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RRHH'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('Pressed');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        InkWell(
          onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BuscarScreen()))),
          child: Container(
            height: 100,
            width: 400,
            color: Colors.grey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
              Icon(Icons.search),
              
                   Text('Buscar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AgregarScreen()))),
          child: Container(
            height: 100,
            width: 400,
            color: Colors.grey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
              Icon(Icons.add),
              
                   Text('Agregar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() => print('Pressed')),
          child: Container(
            height: 100,
            width: 400,
            color: Colors.grey,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
              Icon(Icons.search),
              
                   Text('Consultar empleados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ],
              ),
            ),
          ),
        ),

          ],
        ),
      ),
      
    );
  }
}
