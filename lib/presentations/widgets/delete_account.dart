import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/business_logic/bloc/delete_account/delete_account_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../business_logic/bloc/auth_status/auth_status_bloc.dart';
import '../../constants/colors.dart';

Future<dynamic> deleteAccountDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delete Account',
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
            Text('Are you sure you want to delete your account ',
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
                ),
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () {
                context.read<DeleteAccountBloc>().add(const DeleteAccount());
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: BlocListener<DeleteAccountBloc, DeleteAccountState>(
                listener: (context, state) {
                  if (state is DeleteAccountError) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: state.errorMessage);
                  } else if (state is AccountDeletedSuccess) {
                    context.read<AuthStatusBloc>().add(LoggedOut());
                    context
                        .read<AuthBloc>()
                        .emit(const AuthenticationInitial(action: 'login'));
                    Navigator.pop(context);
                  } else if (state is DeleteAccountLoding) {
                    Fluttertoast.showToast(msg: 'Deleting Account...');
                  } else {
                    Fluttertoast.showToast(msg: state.toString());
                  }
                },
                child: BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                  builder: (context, state) {
                    if (state is DeleteAccountLoding) {
                      return const CupertinoActivityIndicator(
                          color: Colors.white);
                    } else {
                      return const Text('Delete Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700));
                    }
                  },
                ),
              ),
            )
          ],
        );
      });
}
