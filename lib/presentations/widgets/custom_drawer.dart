import 'package:diseases/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../routes.dart' as route;
import 'logout.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary.withOpacity(.2),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${currentUser.firstName} ${currentUser.lastName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  route.homeScreen,
                );
              }),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  route.profileScreen,
                );
              }),
          ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Suggestions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, route.suggestionsScreen);
              }),
          // ListTile(
          //     leading: const Icon(Icons.star),
          //     title: const Text('Rate Us'),
          //     onTap: () {}),
          // ListTile(
          //     leading: const Icon(Icons.settings),
          //     title: const Text('Settings'),
          //     onTap: () {
          //       Navigator.pop(context);
          //       Navigator.pushNamed(context, route.settingsScreen);
          //     }),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                logOutDialog(context);
              }),
        ],
      ),
    );
  }
}
