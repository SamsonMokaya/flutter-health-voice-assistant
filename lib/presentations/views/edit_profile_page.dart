import 'package:cached_network_image/cached_network_image.dart';
import 'package:diseases/business_logic/bloc/update_profile/update_profile_bloc.dart';
import 'package:diseases/business_logic/cubit/profile_page_view/profile_view_cubit.dart';
import 'package:diseases/constants/colors.dart';
import 'package:diseases/constants/constants.dart';
import 'package:diseases/presentations/widgets/custom_profile_tf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditClientProfilePage extends StatelessWidget {
  const EditClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController firstNameController =
        TextEditingController(text: currentUser.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: currentUser.lastName);
    TextEditingController emailController =
        TextEditingController(text: currentUser.email);
    TextEditingController passwordController =
        TextEditingController(text: currentUser.password);
    return Column(
      children: [
        // Container(
        //   height: 120,
        //   width: 130,
        //   margin: const EdgeInsetsDirectional.only(bottom: 10),
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Container(
        //         height: 100,
        //         width: 100,
        //         clipBehavior: Clip.antiAlias,
        //         decoration:
        //             BoxDecoration(borderRadius: BorderRadius.circular(10)),
        //         child: CachedNetworkImage(
        //           placeholder: (context, url) {
        //             return const CupertinoActivityIndicator();
        //           },
        //           errorWidget: (context, url, error) => const Image(
        //               image: AssetImage('assets/images/male-user.png')),
        //           fit: BoxFit.cover,
        //           imageUrl: 'assets/images/male-user.png',
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         right: 0,
        //         child: InkWell(
        //             onTap: () => showModalBottomSheet(
        //                 context: context,
        //                 shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.vertical(
        //                         top: Radius.circular(25.0))),
        //                 builder: (_) => ModalBottomSheet()),
        //             borderRadius: BorderRadius.circular(20),
        //             child: const CircleAvatar(
        //                 backgroundColor: Color(0xfff0f3fc),
        //                 child: Icon(Icons.edit))),
        //       )
        //     ],
        //   ),
        // ),
        CustomProfileTextField(
            hintText: 'First Name', controller: firstNameController),
        CustomProfileTextField(
            hintText: 'Last Name', controller: lastNameController),
        CustomProfileTextField(hintText: 'Email', controller: emailController),
        CustomProfileTextField(
          hintText: 'Password',
          controller: passwordController,
          password: true,
          obsecurePassword: false,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (emailController.text.isNotEmpty &&
                lastNameController.text.isNotEmpty &&
                firstNameController.text.isNotEmpty) {
              context.read<UpdateProfileBloc>().add(UpdateClientProfile(
                  userId: currentUser.userId.toString(),
                  email: emailController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  password: passwordController.text));
            } else {}
          },
          style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width * .5, 45),
              backgroundColor: AppColors.primary),
          child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileLoaded) {
                Fluttertoast.showToast(msg: 'Profile Updated!');
                context
                    .read<ProfileViewCubit>()
                    .switchToNextSession(profileIndex: 0);
              }
              if (state is UpdateProfileLoadError) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            builder: (context, state) {
              if (state is UpdateProfileLoading) {
                return const CupertinoActivityIndicator(color: Colors.white);
              } else {
                return const Text('Save');
              }
            },
          ),
        )
      ],
    );
  }
}
