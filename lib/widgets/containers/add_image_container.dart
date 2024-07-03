import 'dart:io';

import 'package:flutter/material.dart';

class AddImageContainer extends StatelessWidget {
  const AddImageContainer({super.key, this.selectedImage});
  final File ? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 200,
                width: 370,
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Image(
                            fit: BoxFit.fill, image: FileImage(selectedImage!)),
                      )
                    : const Center(
                        child: Text(
                          "ADD IMAGE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              );
  }
}