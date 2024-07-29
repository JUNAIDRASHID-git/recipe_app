import 'dart:math';

import 'package:flutter/material.dart';

Chip ingredientChipWidget(Function()? onDeleted,ingredient) {
    return Chip(
                  backgroundColor:
                      Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.5)),
                  label: Text(ingredient),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onDeleted: onDeleted,
                );
  }