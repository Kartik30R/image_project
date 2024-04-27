// ImageUpload.dart

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_app/provider/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final _imagePicker = ImagePicker();

    Future<void> selectImage(ImageSource source) async {
      XFile? pickedImage = await _imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        File file = File(pickedImage.path);
        setState(() {
          selectedImage = file;
          // Start timer when the first image is selected

          Provider.of<WImageProvider>(context, listen: false).getUser();
        });
      } else {
        // No Image Selected
      }
      Navigator.pop(context);
    }

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(64),
                child: Text(
                  "Imaze",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(5),
                  shape: MaterialStatePropertyAll(
                    CircleBorder(eccentricity: 0),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: .3 * height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          gradient: const LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            const Center(
                              child: Text(
                                'Choose a option',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectImage(ImageSource.camera);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF5C00),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Camera')
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectImage(ImageSource.gallery);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF5C00),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Gallery')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: selectedImage != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.file(selectedImage!).image,
                          )
                        : null,
                    gradient: const LinearGradient(
                      colors: [Colors.amber, Colors.orange],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: selectedImage != null
                        ? null
                        : const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                  ),
                ),
              ),
            ),
            Consumer<WImageProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: selectedImage != null
                    ? value.images.isNotEmpty
                        ? GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                              crossAxisCount: 2,
                            ),
                            itemCount: value.images.length,
                            itemBuilder: (context, index) {
                              final imageUrl = value.images[index];
                              return Container(
                                padding: EdgeInsets.all(3),
                                height: 200,
                                width: 200,
                                child: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        : const CircularProgressIndicator()
                    : null,
              );
            })
          ],
        ),
      ),
    );
  }
}
