import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:greenland/src/config/styles/palette.dart';
import 'dart:typed_data';

class AddPlantWidget extends StatefulWidget {
  const AddPlantWidget({required this.plant, super.key});

  final Plant plant;

  @override
  _AddPlantWidgetState createState() => _AddPlantWidgetState();
}

class _AddPlantWidgetState extends State<AddPlantWidget> {
  TextEditingController _dateController = TextEditingController();
  Uint8List? webImage;
  File? _pickedImage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      if (kIsWeb) {
        // Handle web image picking
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var f = await image.readAsBytes();
          setState(() {
            webImage = f;
            _pickedImage = File('a'); // Dummy file as placeholder
          });
        } else {
          print('No image has been picked');
        }
      } else {
        // Handle mobile image picking
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            _pickedImage = File(image.path);
          });
        } else {
          print('No image has been picked');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 16.0, 16.0, 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _pickImage,
              child: SizedBox(
                width: 200,
                height: 200,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: _pickedImage == null
                      ? Center(
                          child: Text(
                            'Drop your file here, or browse\nJPG, PNG (Max 250x250px - 2Mb)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : kIsWeb
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(35.0),
                              child: Image.memory(webImage!, fit: BoxFit.cover),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(35.0),
                              child:
                                  Image.file(_pickedImage!, fit: BoxFit.cover),
                            ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nickname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Water',
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.water_drop,
                            color: index < 3 ? Colors.blue : Colors.grey,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Adoption date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>['Bathroom', 'Outdoor', 'Balcony', 'Garden']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle change
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>['Succulent', 'Fern', 'Cactus', 'Flower']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle change
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Palette.doneColor),
                        foregroundColor:
                            MaterialStateProperty.all(Palette.complete),
                      ),
                      onPressed: () {
                        // Handle save
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
