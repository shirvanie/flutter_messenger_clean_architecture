

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/core/colors/app_color.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:messenger/features/presentation/screens/camera_screen.dart';
import 'package:messenger/main.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final double height;
  const MainBottomNavigationBar({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: height,
      padding: const EdgeInsets.all(0),
      color: Colors.red,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: isDark ? AppColor.bottomNavigationBarDividerColorDark : AppColor.bottomNavigationBarDividerColorLight,
                )
            )
        ),
        child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 20,
                    splashColor: const Color(0xff0694d7),
                    color: isDark ? Colors.white : Colors.black,
                    icon: Icon(state.activeIcon == ActiveIcon.icon1 ? Iconsax.message5 : Iconsax.message4),
                    onPressed: () {
                      context.read<BottomNavigationBarCubit>().setActiveIcon(ActiveIcon.icon1);
                    },
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 20,
                    splashColor: const Color(0xff0694d7),
                    color: isDark ? Colors.white : Colors.black,
                    icon: Icon(state.activeIcon == ActiveIcon.icon2 ? CupertinoIcons.phone_fill : CupertinoIcons.phone),
                    onPressed: () {
                      context.read<BottomNavigationBarCubit>().setActiveIcon(ActiveIcon.icon2);
                    },
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 20,
                    splashColor: const Color(0xff0694d7),
                    color: isDark ? Colors.white : Colors.black,
                    icon: Icon(state.activeIcon == ActiveIcon.icon3 ? CupertinoIcons.plus_app_fill : CupertinoIcons.plus_app),
                    onPressed: () {
                      context.read<BottomNavigationBarCubit>().setActiveIcon(ActiveIcon.icon3);
                    },
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 20,
                    splashColor: const Color(0xff0694d7),
                    color: isDark ? Colors.white : Colors.black,
                    icon: Icon(state.activeIcon == ActiveIcon.icon4 ? Iconsax.camera5 :  Iconsax.camera4),
                    onPressed: () async {
                      context.read<BottomNavigationBarCubit>().setActiveIcon(ActiveIcon.icon4);
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        const CameraScreen(),));
                      context.read<BottomNavigationBarCubit>().setActiveIcon(state.activeIcon);
                    },
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    splashRadius: 20,
                    splashColor: const Color(0xff0694d7),
                    color: isDark ? Colors.white : Colors.black,
                    icon: Container(
                      width: state.activeIcon == ActiveIcon.icon5 ? 28 : 26,
                      height: state.activeIcon == ActiveIcon.icon5 ? 28 : 26,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isDark
                                ? AppColor.bottomNavigationBarDividerColorDark
                                : state.activeIcon == ActiveIcon.icon5 ? Colors.black : AppColor.bottomNavigationBarDividerColorLight,
                            width: state.activeIcon == ActiveIcon.icon5 ? 2.0 : 1.0
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset("assets/images/avatar.jpg"),
                      ),
                    ),
                    onPressed: () {
                      context.read<BottomNavigationBarCubit>().setActiveIcon(ActiveIcon.icon5);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
