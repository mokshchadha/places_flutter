import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(@required this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(File(imageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          margin: const EdgeInsets.all(5),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(_storedImage,
                  fit: BoxFit.cover, width: double.infinity)
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: OutlinedButton.icon(
            icon: const Icon(Icons.camera),
            onPressed: _takePicture,
            label: const Text('Take a picture'),
          ),
        )),
      ],
    );
  }
}
