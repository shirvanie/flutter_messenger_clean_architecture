

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/core/colors/app_color.dart';
import 'package:messenger/main.dart';

import '../blocs/shared_cubit/message_text_field_cubit/message_text_field_cubit.dart';

enum PreviewImageType {
  file,
  preview,
  network
}

class PreviewImageScreen extends StatelessWidget {
  const PreviewImageScreen({
    super.key,
    required this.imageType,
    required this.imageFilePath
  });

  final PreviewImageType imageType;
  final String imageFilePath;


  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();

    onBackspacePressed() {
      textFieldController
        ..text = textFieldController.text.characters.toString()
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: textFieldController.text.length));
    }
  
    return Scaffold(
      body: BlocBuilder<MessageTextFieldCubit, MessageTextFieldState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: AppColor.mainAppBarGradient6.withAlpha(isDark ? 100 : 255),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, state.isShowEmoji && state.isImagePicker ? 325 : 75),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background.withAlpha(200),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      spreadRadius: 0.5,
                      blurRadius: 5.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            SizedBox.fromSize(
                              size: const Size.fromRadius(25),
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                splashRadius: 8,
                                splashColor: const Color(0xff0694d7),
                                iconSize: 25,
                                color: isDark ? Colors.white : Colors.black,
                                icon: const Icon(Iconsax.close_square),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                        child: Center(
                          child: getImageWidget(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: state.isShowEmoji && state.isImagePicker ? 325 : 75,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                constraints: const BoxConstraints(
                                    minHeight: 50
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(30),
                                    borderRadius: const BorderRadius.all(Radius.circular(25))
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        splashRadius: 8,
                                        splashColor: Colors.white,
                                        iconSize: 28,
                                        color: Colors.white,
                                        icon: const Icon(Iconsax.emoji_happy),
                                        onPressed: () async {
                                          if(!state.isShowEmoji) FocusManager.instance.primaryFocus?.unfocus();
                                          context.read<MessageTextFieldCubit>().setState(isShowEmoji: !state.isShowEmoji, isImagePicker: true);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        maxLines: 5,
                                        controller: textFieldController,
                                        onTap: (){
                                          context.read<MessageTextFieldCubit>().setState(isShowEmoji: false, isImagePicker: true);
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        cursorColor: Colors.white,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Message",
                                          hintStyle: TextStyle(fontSize: 18.0,
                                              color: Color(0xffeeeeee)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white.withAlpha(50),
                                  borderRadius: const BorderRadius.all(Radius.circular(25))
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                splashRadius: 8,
                                splashColor: Colors.white,
                                iconSize: 28,
                                color: Colors.white,
                                icon: const Icon(Iconsax.send_1),
                                onPressed: () async {
                                  List<Map> imageMessageData = [];
                                  imageMessageData.add({"imageMessage": imageFilePath});
                                  if(textFieldController.text.toString().trim().isNotEmpty) {
                                    imageMessageData.add({"textMessage": textFieldController.text.toString().trim()});
                                  }
                                  Navigator.pop(context, imageMessageData);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(state.isShowEmoji && state.isImagePicker) SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: textFieldController,
                            onBackspacePressed: onBackspacePressed,
                            config: Config(
                              columns: 7,
                              emojiSizeMax: 32 *
                                  (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                      ? 1.30
                                      : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: Theme.of(context).colorScheme.background,
                              indicatorColor: Theme.of(context).colorScheme.secondary,
                              iconColor: Colors.grey,
                              iconColorSelected: Theme.of(context).colorScheme.secondary,
                              backspaceColor: Theme.of(context).colorScheme.secondary,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              recentTabBehavior: RecentTabBehavior.POPULAR,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Resents',
                                style: TextStyle(fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getImageWidget() {
    if(imageType == PreviewImageType.file || imageType == PreviewImageType.preview){
      return Image.file(File(imageFilePath));
    } else if(imageType == PreviewImageType.network) {
      return Image.network(imageFilePath);
    }
    return Container();
  }
}
