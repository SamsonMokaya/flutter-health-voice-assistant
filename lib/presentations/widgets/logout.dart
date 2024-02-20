import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../business_logic/bloc/auth_status/auth_status_bloc.dart';
import '../../constants/colors.dart';

Future<dynamic> logOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sign Out',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColors.primary, fontSize: 25)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel,
                        size: 35, color: AppColors.primary))
              ],
            ),
            const Divider(thickness: 2),
            Text('Are you sure you want to sign out? ',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 15)),
          ]),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child:
                    const Text('Stay', style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () {
                context.read<AuthStatusBloc>().add(LoggedOut());
                context
                    .read<AuthBloc>()
                    .emit(const AuthenticationInitial(action: 'login'));
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(100, 40)),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthenticationError) {
                    Fluttertoast.showToast(msg: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is AuthStatusLoding) {
                    return const CupertinoActivityIndicator(
                        color: Colors.white);
                  } else {
                    return const Text('Sign Out',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700));
                  }
                },
              ),
            ),
          ],
        );
      });
}
