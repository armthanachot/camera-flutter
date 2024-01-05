import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  XFile? _image;
  takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  showImage() {
    if (_image == null) {
      return const Placeholder(
        fallbackHeight: 200,
        fallbackWidth: double.infinity,
      );
    } else {
      return SizedBox(
        child: Image.file(
          File(_image!.path),
          width: 200,
          height: 200,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                IconButton(
                    onPressed: () async {
                      await takePhoto();
                    },
                    icon: const Icon(Icons.camera)),
                const Text("Take a photo"),
                if(_image !=  null)
                IconButton(onPressed: ()=>{
                  setState(() {
                    _image = null;
                  })
                }, icon: const Icon(Icons.delete))
              ],
            ),
          ],
        )
      ],
    );
  }
}
