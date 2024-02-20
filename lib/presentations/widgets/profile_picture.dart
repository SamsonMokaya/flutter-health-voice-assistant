import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: CachedNetworkImage(
              placeholder: (context, url) {
                return const CupertinoActivityIndicator();
              },
              errorWidget: (context, url, error) =>
                  const Image(image: AssetImage('assets/images/male-user.png')),
              fit: BoxFit.cover,
              imageUrl: imageUrl,
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: InkWell(
          //       onTap: () {},
          //       borderRadius: BorderRadius.circular(20),
          //       child: CircleAvatar(
          //         backgroundColor: Color(0xfff0f3fc),
          //         child: Icon(Icons.edit),
          //       )),
          // )
        ],
      ),
    );
  }
}
