

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/core/colors/app_color.dart';
import 'package:messenger/core/constants/constants.dart';
import 'package:messenger/core/utils/date_converter.dart';
import 'package:messenger/features/data/models/message_model.dart';
import 'package:messenger/features/data/models/user_model.dart';
import 'package:messenger/features/domain/entities/message_entity.dart';
import 'package:messenger/features/presentation/rx_dart/message_rx_dart.dart';
import 'package:messenger/features/presentation/screens/preview_image_screen.dart';
import 'package:messenger/features/presentation/blocs/shared_cubit/message_text_field_cubit/message_text_field_cubit.dart';
import 'package:messenger/features/presentation/screens/profile_screen.dart';
import 'package:messenger/features/presentation/widgets/blur.dart';
import 'package:messenger/features/presentation/widgets/message_list_item.dart';
import 'package:messenger/injection_container.dart';
import 'package:messenger/main.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user, this.isOnline = false});

  final UserModel user;
  final bool isOnline;



  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  ScrollController scrollController = ScrollController();
  TextEditingController textFieldController = TextEditingController();
  GlobalKey textFieldGlobalKey = GlobalKey();
  final MessageRxDart messageRxDart = locator();
  int messageId = 1;

  _onBackspacePressed() {
    textFieldController
      ..text = textFieldController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textFieldController.text.length));
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: isDark
          ? AppColor.chatPageSystemNavigationBarColorDark
          : AppColor.chatPageSystemNavigationBarColorLight,
    ));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? AppColor.bottomNavigationBarDark : AppColor.bottomNavigationBarLight,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MessageTextFieldCubit, MessageTextFieldState>(
        builder: (context, state) {
          return Stack(
              children: [
                Container(
                  color: AppColor.mainAppBarGradient6.withAlpha(isDark ? 100 : 255),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, state.isShowEmoji && !state.isImagePicker ? 325 : 75),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background.withAlpha(220),
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
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: isDark ? 0.3 : 0.05,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bg_galaxy.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: _messageListBody(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return snapshot.data!;
                          }
                          return const Center(child: CircularProgressIndicator());
                        }
                      ),
                      Blur(
                          sigmaX: 1.2,
                          sigmaY: 1.2,
                          child: Container(
                            height: 85,
                          )
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.background.withAlpha(200),
                              Theme.of(context).colorScheme.background.withAlpha(150),
                              Theme.of(context).colorScheme.background.withAlpha(120),
                              Theme.of(context).colorScheme.background.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 75,
                                child: MaterialButton (
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(CupertinoIcons.left_chevron, color: Theme.of(context).colorScheme.onBackground, size: 25,),
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                              width: 45,
                                              height: 45,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .onBackground
                                                    .withAlpha(60),
                                                borderRadius: const BorderRadius.all(Radius.circular(60)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withAlpha(50),
                                                    spreadRadius: 0.3,
                                                    blurRadius: 4.0,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Image.asset(widget.user.userAvatar!, width: 60, height: 60,)
                                          ),
                                          if(widget.isOnline) Container(
                                            width: 12,
                                            height: 12,
                                            margin: const EdgeInsets.only(right: 2, bottom: 1),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                border: Border.all(
                                                  width: 2,
                                                  color: isDark ? const Color(0xff202020) : const Color(0xffeeeeee),
                                                )
                                            ),
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                              Expanded(
                                child: MaterialButton (
                                  height: 100,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: widget.user),));
                                  },
                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 5),
                                          child: Text(widget.user.fullName!, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 19),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 5, top: 0),
                                          child: Text(
                                            widget.isOnline
                                                ? "online"
                                                : "last seen ${DateConverter.getTimeString(widget.user.lastSeenDateTime!)}",
                                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox.fromSize(
                                    size: const Size.fromRadius(25),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      splashRadius: 8,
                                      splashColor: const Color(0xff0694d7),
                                      iconSize: 25,
                                      color: isDark ? Colors.white : Colors.black,
                                      icon: const Icon(Iconsax.video),
                                      onPressed: () {
                                      },
                                    ),
                                  ),
                                  SizedBox.fromSize(
                                    size: const Size.fromRadius(25),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      splashRadius: 8,
                                      splashColor: const Color(0xff0694d7),
                                      iconSize: 25,
                                      color: isDark ? Colors.white : Colors.black,
                                      icon: const Icon(Iconsax.call),
                                      onPressed: () {
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: state.isShowEmoji && !state.isImagePicker ? 325 : 71,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Row(
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
                                            context.read<MessageTextFieldCubit>().setState(isShowEmoji: !state.isShowEmoji, isImagePicker: false);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          key: textFieldGlobalKey,
                                          keyboardType: TextInputType.multiline,
                                          controller: textFieldController,
                                          onTap: (){
                                            context.read<MessageTextFieldCubit>().setState(isShowEmoji: false, isImagePicker: false);
                                          },
                                          onChanged: (value) {
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
                                          icon: const Icon(Iconsax.attach_square),
                                          onPressed: () async {
                                            context.read<MessageTextFieldCubit>().setState(isShowEmoji: false, isImagePicker: true);
                                            pickImageFile();
                                          },
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
                                  key: const ValueKey("buttonSendMessageKey"),
                                  padding: const EdgeInsets.all(0.0),
                                  splashRadius: 8,
                                  splashColor: Colors.white,
                                  iconSize: 28,
                                  color: Colors.white,
                                  icon: const Icon(Iconsax.send_1),
                                  onPressed: () async {
                                    if(textFieldController.text.toString().trim() == "") return;
                                    await messageRxDart.saveMessageLocal(
                                      getMessageItem(textFieldController.text.toString().trim(), MessageTypeModel.sending, MessageCategoryModel.text),
                                    ).then((_) {
                                      textFieldController.text = "";
                                    });
                                    await messageRxDart.getAllMessagesLocal("09120123456", "09120654321");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(state.isShowEmoji && !state.isImagePicker) SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              textEditingController: textFieldController,
                              onBackspacePressed: _onBackspacePressed,
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

  Future<Widget> _messageListBody() async {
    messageRxDart.getAllMessagesLocal("09120123456", "09120654321");
    return StreamBuilder<List<MessageEntity>>(
        stream: messageRxDart.messagesLocal,

        builder: (BuildContext context, AsyncSnapshot<List<MessageEntity>> snapshot) {
          var data = snapshot.data;
          var length = snapshot.data?.length;
          if(snapshot.hasError) {
            return const Text("Error");
          } else if(snapshot.hasData && snapshot.data!.isNotEmpty) {
            messageId = data!.length + 1;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 100, bottom: 15),
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemCount: length,
              itemBuilder: (__, index) {
                return MessageListItem(messageItem: data.toList()[index]);
              },
            );
          } else if(snapshot.hasData && snapshot.data!.isEmpty) {
            List<MessageModel> messagesList = [
              getMessageItem("Hi dear, how are you?", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("Hi dear, everything's good. How about you?", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("I'm good too. I just wanted to chat with you.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("That's great! I'm happy to talk to you. What's up?", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("Take a look at this picture.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("assets/images/chats/chat_image1.jpg", MessageTypeModel.received, MessageCategoryModel.image),
              getMessageItem("It's from my trip to the forest.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("Wow! What a beautiful view! I really enjoyed it. It seems like you had an amazing trip.", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("Yes, being in nature and its tranquility was truly delightful. I felt a sense of freedom in the fresh air.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("That's awesome that you had a great time. Where else did you go?", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("After the forest, I visited a small village. The people there were very hospitable, and the local food was amazing.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("It sounds like a wonderful experience. I hope I can visit those areas someday.", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("Definitely! I believe you'll also enjoy these beautiful trips. Do you have any plans for another trip?", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("I don't have any specific plans at the moment, but I'd love to go on more trips.", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("assets/images/chats/chat_image2.jpg", MessageTypeModel.sent, MessageCategoryModel.image),
              getMessageItem("Absolutely! I'm always ready for more adventures and exploration. Whenever you want, let's go!", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("Definitely! Traveling together will be fantastic. Anyway, I have to go. Goodbye!", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("Goodbye, dear! I hope you have wonderful days. We'll talk again soon.", MessageTypeModel.received, MessageCategoryModel.text),
              getMessageItem("Thank you! Take care and have a safe return. Goodbye!", MessageTypeModel.sent, MessageCategoryModel.text),
              getMessageItem("Goodbye!", MessageTypeModel.received, MessageCategoryModel.text),
            ];
            for(MessageModel message in messagesList) {
              messageRxDart.saveMessageLocal(message);
            }
            messageRxDart.getAllMessagesLocal("09120123456", "09120654321");
          }
          return const Center(child: CircularProgressIndicator());
        }
    );

  }


  MessageModel getMessageItem(String messageBody,
      String messageType, String messageCategory) {
    return MessageModel.fromJson({
      "id": messageId++,
      "messageId": "123456789",
      "senderPhoneNumber": "09120123456",
      "targetPhoneNumber": "09120654321",
      "messageCategory": messageCategory.toString(),
      "messageBody": messageBody.toString(),
      "messageDateTime": DateTime.now().toString(),
      "messageType": messageType.toString(),
      "messageIsReadByTargetUser": true
    });
  }

  void pickImageFile() {
    try{
      FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      ).then((images) {
        if(images == null || images.count == 0) return "";
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                PreviewImageScreen(imageType: PreviewImageType.file,
                    imageFilePath: images.files.first.path.toString())))
            .then((data) async {
          List<Map> returnData = data as List<Map>;
          //
          if(returnData[0]["imageMessage"] == null) return "";
          await messageRxDart.saveMessageLocal(
              getMessageItem(returnData[0]["imageMessage"], MessageTypeModel.sending, MessageCategoryModel.image)
          );
          if(returnData[1]["textMessage"] != null) {
            await messageRxDart.saveMessageLocal(
                getMessageItem(returnData[1]["textMessage"], MessageTypeModel.send, MessageCategoryModel.text)
            );
          }
          await messageRxDart.getAllMessagesLocal("09120123456", "09120654321");
        });
      });
    } catch(e) { return; }
  }

}

