
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/theme_cubit/theme_cubit.dart';
import 'package:messenger/features/presentation/providers/directionality_provider.dart';
import 'package:messenger/core/colors/app_color.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/screen_sizes.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:messenger/features/presentation/screens/calls_screen.dart';
import 'package:messenger/features/presentation/screens/camera_screen.dart';
import 'package:messenger/features/presentation/screens/chats_screen.dart';
import 'package:messenger/features/presentation/screens/plus_screen.dart';
import 'package:flutter/services.dart';
import 'package:messenger/features/presentation/widgets/main_app_bar.dart';
import 'package:messenger/features/presentation/widgets/main_bottom_navigation_bar.dart';
import 'package:messenger/main.dart';


class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {

  final BoxController boxController = BoxController();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? AppColor.bottomNavigationBarDark : AppColor.bottomNavigationBarLight,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double bottomNavigationBarHeight = (MediaQuery.of(context).viewInsets.bottom > 0) ? 0 : 50;
    double appBarHeight = ScreenSize.setScreenHeight(context, 0.1);
    if(appBarHeight < 95) appBarHeight = 95;
    double minHeightBox = ScreenSize.setScreenHeight(context, 0.3) - bottomNavigationBarHeight;
    double maxHeightBox = ScreenSize.fullHeightScreen(context) - appBarHeight - bottomNavigationBarHeight;
    textEditingController.addListener(() {
      if(textEditingController.text != "") {
        boxController.setSearchBody(child: Center(child: Text(textEditingController.value.text, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20),),));
      } else {
        boxController.setSearchBody(child: Center(child: Text("Empty", style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20),),));
      }
    });

    return Scaffold(
      body: SlidingBox(
        context: context,
        controller: boxController,
        minHeight: minHeightBox,
        maxHeight: maxHeightBox ,
        color: Theme.of(context).colorScheme.background,
        style: BoxStyle.boxUnderBox,
        body: BlocBuilder<BottomNavigationBarCubit,
            BottomNavigationBarState>(
          builder: (_, bottomNavigationState) {
            if(bottomNavigationState.activeIcon == ActiveIcon.icon1) {
              return const ChatsScreen();
            } else if(bottomNavigationState.activeIcon == ActiveIcon.icon2) {
              return const CallsScreen();
            } else if(bottomNavigationState.activeIcon == ActiveIcon.icon3) {
              return const PlusScreen();
            } else if(bottomNavigationState.activeIcon == ActiveIcon.icon4) {
              return const CameraScreen();
            } else if(bottomNavigationState.activeIcon == ActiveIcon.icon5) {
              return SizedBox(
                height: boxController.maxHeight,
                child: Center(
                  child: Text("The user profile can be found here",
                    style: TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .primary),),
                ),
              );
            }
            return Container();
          },
        ),
        draggableIcon: CupertinoIcons.minus,
        draggableIconColor: Theme.of(context).colorScheme.secondary,
        draggableIconBackColor: Colors.transparent,
        backdrop: Backdrop(
          fading: true,
          backgroundGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.mainAppBarGradient1.withAlpha(isDark ? 100 : 255),
                AppColor.mainAppBarGradient2.withAlpha(isDark ? 120 : 255),
                AppColor.mainAppBarGradient3.withAlpha(isDark ? 120 : 255),
                AppColor.mainAppBarGradient4.withAlpha(isDark ? 100 : 255),
                AppColor.mainAppBarGradient5.withAlpha(isDark ? 100 : 255),
                AppColor.mainAppBarGradient6.withAlpha(isDark ? 100 : 255),
                AppColor.mainAppBarGradient6.withAlpha(isDark ? 100 : 255),
                AppColor.mainAppBarGradient6.withAlpha(isDark ? 100 : 255),
              ]
          ),
          body: const MainAppBar(),
          appBar: BackdropAppBar(
            title: Container(
              margin: const EdgeInsets.only(top: 3, left: 10),
              child: Text("Messenger", style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: Constants.appFontHelveticaBold
              ),),
            ),
            leading: Icon(Iconsax.menu,
              color: Theme.of(context).colorScheme.onPrimary, size: 23,),
            searchBox: SearchBox(
              controller: textEditingController,
              color: Theme.of(context).colorScheme.background,
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 18),
              body: Center(child: Text("Search Result",
                style: TextStyle(color:
                Theme.of(context).colorScheme.onBackground,
                    fontSize: 20),),),
              draggableBody: true,
            ),
            actions: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Iconsax.search_normal_1, color: Theme.of(context).colorScheme.onPrimary,),
                    onPressed: () {
                      textEditingController.text = "";
                      boxController.showSearchBox();
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Iconsax.moon, color: Theme.of(context).colorScheme.onPrimary,),
                    onPressed: () {
                      context.read<ThemeCubit>().switchTheme();
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.language_outlined, color: Theme.of(context).colorScheme.onPrimary,),
                    onPressed: () {
                      context.read<DirectionalityProvider>().switchDirection();
                    },
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(
          height: bottomNavigationBarHeight),
    );
  }

}

