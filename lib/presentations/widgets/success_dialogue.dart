import 'package:diseases/business_logic/cubit/speech_to_text/speech_to_text_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> successDialog({
  required BuildContext context,
  bool success = false,
  String route = '',
  bool input = false,
  VoidCallback? onPressed,
  bool focusNodes = false,
  required String message,
  required String title,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        FocusNode? focusNode;
        final state = context.watch<SpeechToTextCubit>().state;
        TextEditingController controller = state.controller;

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
              const Divider(thickness: 1)
            ],
          ),
          content: GestureDetector(
            onTap: () {
              if (focusNode != null) {
                FocusScope.of(context).requestFocus(focusNode);
                // scroll down the view
              }
            },
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!input) ...[
                      Icon(success ? Icons.check : Icons.cancel,
                          size: 48,
                          color: success
                              ? Theme.of(context).colorScheme.primary
                              : Colors.red),
                      const SizedBox(height: 16)
                    ],
                    Text(success ? "Success" : "Error",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(message,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center),
                    // if input tag is true, show input field for editing the given message
                    if (input) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller,
                        maxLines: 4,
                        autofocus: true,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: 'Symptoms...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding:
              const EdgeInsets.only(right: 20, left: 20, bottom: 10),
          actions: [
            // cancel button
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: route.isEmpty
                  ? onPressed ?? () => Navigator.pop(context)
                  : () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, route, (Route route) => route.isFirst);
                      Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: state.loading
                  ? const CupertinoActivityIndicator()
                  : const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      });
}
