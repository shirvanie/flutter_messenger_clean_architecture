import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/config/language_detector.dart';
import 'package:messenger/core/themes/theme_detector.dart';
import 'package:messenger/features/data/datasources/db/database_helper.dart';
import 'package:messenger/features/presentation/blocs/group_bloc/group_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_message_bloc/group_message_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_message_type_bloc/group_message_type_bloc.dart';
import 'package:messenger/features/presentation/blocs/group_user_bloc/group_user_bloc.dart';
import 'package:messenger/features/presentation/blocs/message_bloc/message_bloc.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/directionality_cubit/directionality_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_list_cubit/message_list_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_text_field_cubit/message_text_field_cubit.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/theme_cubit/theme_cubit.dart';
import 'package:messenger/features/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:messenger/features/presentation/providers/directionality_provider.dart';
import 'package:messenger/features/presentation/screens/main_wrapper_screen.dart';
import 'package:messenger/injection_container.dart';
import 'package:provider/provider.dart';

// App Theme is Light
bool isDark = false;
// App Direction is left to right
bool isLtr = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DatabaseHelper().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => locator<UserBloc>()),
        BlocProvider<MessageBloc>(create: (context) => locator<MessageBloc>()),
        BlocProvider<GroupBloc>(create: (context) => locator<GroupBloc>()),
        BlocProvider<GroupUserBloc>(create: (context) => locator<GroupUserBloc>()),
        BlocProvider<GroupMessageBloc>(create: (context) => locator<GroupMessageBloc>()),
        BlocProvider<GroupMessageTypeBloc>(create: (context) => locator<GroupMessageTypeBloc>()),
        BlocProvider<ThemeCubit>(create: (context) => locator<ThemeCubit>()),
        BlocProvider<DirectionalityCubit>(create: (context) => locator<DirectionalityCubit>()),
        BlocProvider<BottomNavigationBarCubit>(create: (context) => locator<BottomNavigationBarCubit>()),
        BlocProvider<MessageTextFieldCubit>(create: (context) => locator<MessageTextFieldCubit>()),
        BlocProvider<MessageListCubit>(create: (context) => locator<MessageListCubit>()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DirectionalityProvider()),
        ],
        child: Builder(
          builder: (context) {
            LanguageDetector.init(context);
            return ChangeNotifierProvider<DirectionalityProvider>(
              create: (_) => DirectionalityProvider(),
              child: Consumer<DirectionalityProvider>(
                builder: (context, directionalityProvider, child) {
                  ThemeDetector.init(context);
                  return Directionality(
                      textDirection: directionalityProvider.direction,
                      child: BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (themeContext, themeState) {
                          isDark = themeState.isDark;
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: themeState.themeData,
                            home: Directionality(
                              textDirection: directionalityProvider.direction,
                              child: const MainWrapperScreen(),
                            ),
                          );
                        },
                      )
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }
}


timeStamp() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}