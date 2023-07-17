

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/utils/screen_sizes.dart';

class MainAppBar extends StatelessWidget{
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 70,
        bottom: 35
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          MainAppBarListItem(
              icon: Icon(
                CupertinoIcons.house, size: 21, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Home",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                Icons.person_outline, size: 26, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Contacts",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                CupertinoIcons.camera, size: 22, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Camera",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                Icons.image_outlined, size: 24, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Album",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(Icons.person_add_alt_outlined, size: 25,
                color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Invite Friends",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(Icons.bookmark_border_rounded, size: 26,
                color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Bookmarks",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),

          MainAppBarListItem(
              icon: Icon(
                Icons.alarm, size: 25, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Set Alarm",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                CupertinoIcons.person_2, size: 25, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Add Group",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                Icons.contacts_outlined, size: 25, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Contacts",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(Icons.video_camera_front_outlined, size: 26,
                color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Video Call",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(Icons.add_location_alt_outlined, size: 25,
                color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Add Location",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 25,
                color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Checkout Cart",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {}
          ),
          MainAppBarListItem(
              icon: Icon(
                Icons.settings_outlined, size: 25, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Settings",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
          MainAppBarListItem(
              icon: Icon(
                Icons.help_outline, size: 25, color: Theme.of(context).colorScheme.onPrimary,),
              child: Text("Helps",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
              onPressed: () {

              }
          ),
        ],
      ),
    );
  }
}

class MainAppBarListItem extends StatelessWidget {
  final Icon? icon;
  final Widget child;
  final VoidCallback onPressed;
  const MainAppBarListItem({super.key, this.icon, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double iconSizeHeight = 50;
    return SizedBox(
      height: iconSizeHeight,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        minWidth: ScreenSize.fullWidthScreen(context),
        splashColor: Theme.of(context).colorScheme.onPrimary.withAlpha(80),
        highlightColor: Theme.of(context).colorScheme.onPrimary.withAlpha(80),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed,
        child: Row(
          children: [
            if(icon != null) SizedBox(
              width: iconSizeHeight + 10,
              height: iconSizeHeight,
              child: icon,
            ),
            child,
          ],
        ),
      ),
    );
  }
}

