import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/edit_photo_cubit.dart';

class BasePhoto extends StatelessWidget {
  Uint8List? image;
  BasePhoto({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photo = context.read<EditPhotoCubit>().state.photo;
    return Container(
        color: Colors.blueGrey[100],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Image.memory(
          image!,
          fit: BoxFit.fill,
        ));
  }
}
