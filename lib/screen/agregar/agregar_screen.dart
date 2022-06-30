
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhcs/utils/utils.dart';
import 'package:rhcs/widgets/text_field_input.dart';

import '../../utils/gialogs/error_dialog.dart';


class AgregarScreen extends StatefulWidget {
  const AgregarScreen({Key? key}) : super(key: key);

  @override
  State<AgregarScreen> createState() => _AgregarScreenState();
}

class _AgregarScreenState extends State<AgregarScreen> {
  final TextEditingController _primerNombreController = TextEditingController();
  final TextEditingController _primerApellidoController = TextEditingController();
  String documento = 'CC';
  Uint8List? _image;
  bool _isLoading = false;


  @override
  void dispose() {
    _primerNombreController.dispose();
    _primerApellidoController.dispose();
    super.dispose();
  }

  void selectImage() async{
    dynamic im = await pickImage(ImageSource.gallery);
    if (im != false) {
      setState(() {
        _image = im;
      });
    }
    if (im == false) {
      showErrorDialog(context,'No se pudo seleccionar la imagen');
    }
      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Stack(
                     children: [
                       _image != null
                      ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                      :const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                          ),
                           Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),   
                     ]
                   ),
                 ),
                 const SizedBox(width: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
      
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(
                      width: 200,
                      child: TextFieldInput(
                       textEditingController: _primerNombreController,
                        hintText: 'Primer Nombre',
                           textInputType: TextInputType.text,
                           ),
                    ),
                     const SizedBox(height: 20),
                         SizedBox(
                      width: 200,
                      child: TextFieldInput(
                       textEditingController: _primerNombreController,
                        hintText: 'Primer Apellido',
                           textInputType: TextInputType.text,
                           ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width:200,
                      
                      child: DropdownButton<String>(
                        hint: const Text('Tipo documento'),
                        items: ['CC', 'CE', 'PA'].map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),      
                        onChanged: (String? value) {
                          setState(() {
                            print(value);
                            documento = value!;
                          });
                        },
                    ))
                     
                    ],
                  ),
                )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}