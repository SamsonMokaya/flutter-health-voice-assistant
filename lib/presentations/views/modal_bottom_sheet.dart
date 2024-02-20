// // ignore_for_file: must_be_immutable

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_daktari/logic/cubit/update_profile/update_profile_cubit.dart';

// class ModalBottomSheet extends StatelessWidget {
//   ModalBottomSheet({super.key});
//   File _image = File('');
//   @override
//   Widget build(BuildContext context) {
//     Future getImage(ImageSource source) async {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         context
//             .read<UpdateProfileCubit>()
//             .updateImagePath(imagePath: File(pickedFile.path));
//       } else {}
//       return _image;
//     }

//     return Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           const SizedBox(height: 20),
//           Container(
//             height: MediaQuery.of(context).size.height * .2,
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                   leading: Icon(Icons.photo_library),
//                   title: Text('Choose from Gallery'),
//                   onTap: () async {
//                     File image = await getImage(ImageSource.gallery);
//                     // Handle the selected image from the gallery
//                     context
//                         .read<UpdateProfileCubit>()
//                         .updateImagePath(imagePath: image);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.camera_alt),
//                   title: Text('Take a Picture'),
//                   onTap: () async {
//                     File image = await getImage(ImageSource.camera);
//                     // Handle the captured image from the camera
//                     context
//                         .read<UpdateProfileCubit>()
//                         .updateImagePath(imagePath: image);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           )
//         ]));
//   }
// }
