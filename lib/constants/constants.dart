import 'package:diseases/repositories/models/user.dart';

String greetingMessage() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good morning';
  }
  if (hour < 17) {
    return 'Good afternoon';
  }
  return 'Good evening';
}

UserModel currentUser = UserModel.empty;
