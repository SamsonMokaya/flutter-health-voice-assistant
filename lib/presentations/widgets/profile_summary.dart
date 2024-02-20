import 'package:cached_network_image/cached_network_image.dart';
import 'package:diseases/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diseases/routes.dart' as routes;

import '../../business_logic/bloc/auth_status/auth_status_bloc.dart';
import 'tab_header_bar.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: BlocBuilder<AuthStatusBloc, AuthStatusState>(
          builder: (context, state) {
        if (state is UserAuthenticated) {
          return SafeArea(
            child: SizedBox(
              height: size.height * .1,
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: const BoxDecoration(),
                        height: 100,
                        width: 80,
                        child: CachedNetworkImage(
                          placeholder: (context, url) {
                            return const CupertinoActivityIndicator();
                          },
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage('assets/images/male-user.png')),
                          fit: BoxFit.cover,
                          imageUrl: 'https://picsum.photos/250?image=9',
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${state.user.firstName} ${state.user.lastName.toString().substring(0, 1)}.',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(state.user.email ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: .8,
                              fontWeight: FontWeight.w600)),
                      // ElevatedButton(
                      //   onPressed: () => logOutDialog(context),
                      //   child: Text('Sign Out'),
                      // )
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications, size: 35, color: Colors.grey),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(
            child: TabHeader(
              size: size,
              title: Text(
                'Create Your Profile,',
                style: textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              subtitle: Text('save your important information',
                  style: textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal)),
              button: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                      backgroundColor: AppColors.primary),
                  onPressed: () {
                    Navigator.pushNamed(context, routes.loginScreen);
                  },
                  child: const Text('Sign In')),
              image: Image.asset('assets/images/telehealth.png'),
            ),
          );
        }
      }),
    );
  }
}
