import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:messenger/features/presentation/screens/preview_image_screen.dart';
import 'package:path_provider/path_provider.dart';


class CameraScreen extends StatefulWidget{

 const CameraScreen({super.key});

 @override
 State<StatefulWidget> createState() => CameraScreenState();

}

class CameraScreenState extends State<CameraScreen> {


 late CameraDescription cameraDescription;
 late List<CameraDescription> cameras;
 CameraController? cameraController;

 List<Map> imageFiles = [];

 double shutterButtonWidth = 65;
 double shutterButtonHeight = 65;

 FlashMode flashMode = FlashMode.off;

 bool isShutterTapped = false;
 bool isRecordingVideo = false;
 bool isFrameBorder = false;
 bool isSavingFile = false;

 Timer? recordVideoTimerInterval;
 int recordVideoTimerIntervalValue = 0;

 String imagesFolderPath = "/Pictures/FlutterAlbum";
 String videosFolderPath = "/Movies/FlutterAlbum";
 String videoThumbsFolderPath = "/Movies/FlutterAlbum/thumbs";

 String serverChatImageExtension = ".pdf";
 String saveChatImageExtension = ".jpg";



  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

 @override
 void initState() {
   super.initState();
   initCamera();
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: WillPopScope(
       onWillPop: () async {
         Navigator.pop(context, imageFiles);
         return true;
       },
       child: Container(
         color: Colors.black,
         child: Stack(
           children: [
             cameraPreviewWidget(),
             cameraShutterBorder(),
             cameraBottomSection(),
             videoRecordingTimer(),
           ],
         ),
       ),
     ),
   );
 }

 Future initCamera() async {
   availableCameras().then((cameras) {
     selectCamera(camera: cameras[0]); // Back Camera
   });
 }

 Future selectCamera({required CameraDescription camera}) async {
   cameraController = CameraController(camera, ResolutionPreset.max);
   cameraDescription = camera;

   cameraController?.initialize().then((_) {
     if (!mounted) {
       return;
     }
     setState(() {});
   }).catchError((Object e) {
     if (e is CameraException) {
       showInSnackBar(status: "error", message: (e.description).toString());
     }
   });
 }

 Widget videoRecordingTimer() {
   return isRecordingVideo
     ? Container(
     height: 40,
     margin: const EdgeInsets.only(top: 30),

     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
           decoration: BoxDecoration(
             color: const Color(0x33FF0000),
             border: Border.all(
               width: 1,
               color: const Color(0x55ff0000)
             ),
             borderRadius: BorderRadius.circular(25)
           ),
           child: Row(
             children: [
               Container(
                 margin: const EdgeInsets.only(right:5),
                 child: const Icon(Icons.circle, color: Colors.redAccent,size: 14,),
               ),
               Text(
                 recordVideoTimerIntervalValue < 10
                 ? "00:0$recordVideoTimerIntervalValue"
                 : "00:$recordVideoTimerIntervalValue",
                 style: const TextStyle(color: Colors.white, fontSize: 15),
               )
             ],
           ),
         ),
       ],
     ),
   )
   : const SizedBox.shrink();
 }
 Widget cameraPreviewWidget() {
   if(!(cameraController?.value.isInitialized != null)){
     return Center(
       child: CircularProgressIndicator(color: Theme
         .of(context)
         .colorScheme
         .primary, strokeWidth: 3.0,),
     );
   } else {
     final pageSize = MediaQuery.of(context).size;
     var scale = pageSize.aspectRatio * (cameraController?.value.aspectRatio)!;
     if (scale < 1) scale = 1 / scale;
     return Transform.scale(
       scale: scale,
       child: Center(
         child: CameraPreview(cameraController!),
       ),
     );
   }

 }
 Widget cameraBottomSection() {
   return Align(
     alignment: Alignment.bottomCenter,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         !isRecordingVideo
           ? Container(
           height: 90,
           padding: const EdgeInsets.all(10),
           margin: const EdgeInsets.only(bottom: 15),
           child: ListView.builder(
             itemCount: imageFiles.length,
             scrollDirection: Axis.horizontal,
             itemBuilder: (BuildContext context, int index){
               String fileType = imageFiles[index]["type"];
               String filePath = imageFiles[index]["path"];
               String fileThumb = "";
               if(imageFiles[index]["thumb"] != null){
                 fileThumb = imageFiles[index]["thumb"];
               }
               return Container(
                 width:70,
                 height:70,
                 decoration: BoxDecoration(
                   border: Border.all(
                       width: 1,
                       color: const Color(0xff333333)
                   ),
                 ),
                 margin: const EdgeInsets.only(right: 10),
                 child: GestureDetector(
                   onTapUp: (_) => onTapUpFilePreview(fileType: fileType, file: File(filePath)),
                   child: Stack(
                     fit: StackFit.expand,
                     children: [
                       fileType == "image"
                       ? Container(
                         width: 100,
                         height: 100,
                         padding: const EdgeInsets.all(1),
                         decoration: BoxDecoration(
                           color: Colors.grey[800],
                         ),
                         child: Image.file(File(filePath),fit: BoxFit.cover,),
                       )
                       : Container(
                         padding: const EdgeInsets.all(1),
                         decoration: BoxDecoration(
                           color: Colors.grey[800],
                         ),
                         child: Image.file(File(fileThumb),fit: BoxFit.cover,),
                       ),
                       fileType == "image"
                         ? const SizedBox.shrink()
                         : const Align(
                           alignment: Alignment.bottomLeft,
                           child: Padding(
                             padding: EdgeInsets.only(left: 5, bottom: 3),
                             child: Icon(Icons.videocam_rounded, size: 18, color: Colors.white),
                           ),
                       ),
                     ],
                   )
                 ),
               );
             },
           ),
         )
         : const SizedBox.shrink(),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             IconButton(
               onPressed: flashSwitchToggle,
               icon: !isShutterTapped
                 ? Icon(
                 flashMode == FlashMode.off
                     ? Icons.flash_off_rounded
                     : Icons.flash_on_rounded,
                 size: 36,
                 color: Colors.white,
               )
               : const Icon(null),
             ),
             !isSavingFile
               ? GestureDetector(
               onTapDown: (_) => onTapShutterButton(action: "TapDown"),
               onTapUp: (_) => onTapShutterButton(action: "TapUp"),
               onLongPressDown: (_) => onTapShutterButton(action: "LongPressDown"),
               onLongPress: () => onTapShutterButton(action: "LongPress"),
               onLongPressUp: () => onTapShutterButton(action: "LongPressUp"),


               child: Container(
                 width: shutterButtonWidth,
                 height: shutterButtonHeight,
                 margin:  isShutterTapped
                     ? const EdgeInsets.only(bottom: 10)
                     : const EdgeInsets.all(0),
                 padding: const EdgeInsets.all(5),
                 decoration: BoxDecoration(
                     color: Colors.transparent,
                     borderRadius: BorderRadius.circular(150),
                     border: Border.all(
                         width: 2,
                         color: Colors.white
                     )
                 ),
                 child: isShutterTapped
                     ? Container(
                   decoration: BoxDecoration(
                     color: Colors.redAccent,
                     borderRadius: BorderRadius.circular(150),
                   ),
                 )
                     : Container(),
               ),
             )
               : CircularProgressIndicator(color: Theme
                 .of(context)
                 .colorScheme
                 .primary, strokeWidth: 3.0,),
             IconButton(
               onPressed: cameraSwitchToggle,
               icon: !isShutterTapped
                   ? const Icon(
                 Icons.flip_camera_ios_rounded,
                 size: 36,
                 color: Colors.white,
               )
               : const Icon(null),
             ),

           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             !isShutterTapped
                 ? Container(
               margin: const EdgeInsets.only(top: 15, bottom: 5),
               child: const Text("Hold for video, tap for photo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15),),
             )
                 : const SizedBox.shrink(),
           ],
         ),
       ],
     ),
   );
 }

 Widget cameraShutterBorder() {
   return Container(
     decoration: BoxDecoration(
         border: Border.all(
             width: 5,
             color: isFrameBorder ? Colors.white : Colors.transparent
         )
     ),
   );
 }

 cameraSwitchToggle() {
   if(cameras.length >= 2){
     selectCamera(
         camera: cameraDescription == cameras[0]
             ? cameras[1]
             : cameras[0]
     );
   } else {
     showInSnackBar(status: "message", message: "You not to able change camera !");
   }
 }

 flashSwitchToggle() {
   setState(() {
     flashMode == FlashMode.off
         ? flashMode = FlashMode.torch
         : flashMode = FlashMode.off;
   });
 }

 onTapShutterButton({required String action}){
   try{
     if(action == "TapDown" || action == "LongPressDown") {
       if(!isShutterTapped){
         setState(() {
           shutterButtonWidth = shutterButtonHeight = 105;
           isShutterTapped = true;
           isFrameBorder = false;
         });
       }
     }
     if(action == "TapUp") {
       if(isShutterTapped && !isRecordingVideo){
         setState(() {
           isSavingFile = true;
           shutterButtonWidth = shutterButtonHeight = 65;
           isShutterTapped = false;
           isRecordingVideo = false;
           isFrameBorder = true;
           Future.delayed(const Duration(milliseconds: 100), (){
             setState(() {
               isFrameBorder = false;
             });
           });
         });
         onPressedTakePictureButton();
       }
     }
     if(action == "LongPress") {
       recordVideoTimerInterval = Timer.periodic(const Duration(seconds: 1), (timer) {
         if(recordVideoTimerIntervalValue < 1000) {
           setState(() {
             recordVideoTimerIntervalValue = timer.tick;
           });
         }
       });
       onStartVideoRecording();
       setState(() {
         isRecordingVideo = true;
       });
     }
     if(action == "LongPressUp") {
       if(isRecordingVideo){
         recordVideoTimerInterval?.cancel();
         setState(() {
           isSavingFile = true;
           shutterButtonWidth = shutterButtonHeight = 65;
           isShutterTapped = false;
           isRecordingVideo = false;
         });
         onStopVideoRecording();
       }
     }
   } catch(e) { throw Exception(); }
 }

 onPressedTakePictureButton() async {
   try{
     File? imageFile = await takeCameraPicture();
     if(imageFile.existsSync()){
       setState(() {
         imageFiles.add({
           "type": "image", //image or video
           "path": imageFile.path
         });
         isSavingFile = false;
       });
     }
   } catch(e) { return; }
 }

 Future<File> takeCameraPicture() async {
   try{
     if ((cameraController?.value.isTakingPicture)!) {
       return File("");
     }
     XFile? image = await cameraController?.takePicture(); //Save image to app path cache folder
     if(image == null) return File("");
     Directory imageDirPath = await getExternalPath(directoryName: imagesFolderPath);
     String imageFilePath = "${imageDirPath.path}/${timeStamp()}.${image.path.split("/").last.split(".").last}";
     File imageFile = File(image.path);
     imageFile.copySync(imageFilePath);
     imageFile.deleteSync();
     return File(imageFilePath);
   } catch(e) {
     return File("");
   }
 }

 Future onStartVideoRecording() async{
   if(!(cameraController?.value.isRecordingVideo)!){
     try{
       await cameraController?.startVideoRecording(); //Save image to app path cache folder
     } catch(e) { throw Exception(); }
   }
 }

 Future onStopVideoRecording() async{
   try{
     if((cameraController?.value.isRecordingVideo)!) {
       File? videoFile = await saveRecordedVideo();
       if(videoFile.existsSync()){
         File videoThumb = await getVideoThumbnailPath(videoFile: videoFile);
         setState(() {
           imageFiles.add({
             "type": "video", //image or video
             "path": videoFile.path,
             "thumb": videoThumb.path,
           });
           isSavingFile = false;
         });
       }
     }
   } on CameraException { return; }
 }
 Future<File> saveRecordedVideo() async {
   try{
     try{
       XFile? video = await cameraController?.stopVideoRecording(); //Save video to app path cache folder
       if(video == null) return File("");
       Directory videoDirPath = await getExternalPath(directoryName: videosFolderPath);
       String videoFilePath = "${videoDirPath.path}/${timeStamp()}.${video.path.split("/").last.split(".").last}";
       File videoFile = File(video.path);
       videoFile.copySync(videoFilePath);
       videoFile.deleteSync();
       return File(videoFilePath);
     } catch(e) {
       return File("");
     }
   } on CameraException { throw Exception(); }
 }

 Future<File> getVideoThumbnailPath({required File videoFile}) async {

   Directory? thumbFolder;
   try {
     if (Platform.isAndroid) {
       thumbFolder = Directory("${(await getExternalStorageDirectory())!.path}/video_thumb");
     } else {
       thumbFolder = Directory("${(await getTemporaryDirectory()).path}/video_thumb");
     }
     if(!(thumbFolder.existsSync())){
       thumbFolder.createSync(recursive: true);
     }
   } catch (e) { throw Exception(e); }

   try{
     String thumbFile = "${thumbFolder.path.toString()}/${videoFile.path.split("/").last.split(".").first}.png";
     return File(thumbFile.toString());
   } catch(e) {
     showInSnackBar(status: "message", message: "Error : \n\n$e");
   }
   return File("");
 }

 Future<Directory> getExternalPath({required String directoryName}) async {
   Directory dir = Directory("");
   try {
     if (Platform.isAndroid) {
       /// get android root path
       Directory dirAndroid = (await getExternalStorageDirectory())!;
       String newAndroidPath = "";
       List<String> folders = (dirAndroid.path).toString().split("/");
       for(int i = 1; i < folders.length; i++){
         if(folders[i] != "Android") {
           newAndroidPath += "/${folders[i]}";
         } else {
           break;
         }
       }
       newAndroidPath = newAndroidPath + directoryName;
       dir = Directory(newAndroidPath);
     } else {
       /// get iOS root path
       dir = await getTemporaryDirectory();
     }
     if(!(dir.existsSync())){
       dir.createSync(recursive: true);
     }
     return Directory((dir.path).toString());
   } catch (e) { return Directory(""); }
 }

 timeStamp() {
   return DateTime.now().millisecondsSinceEpoch.toString();
 }

 onTapUpFilePreview({required String fileType, required File file}) {
   try{
     if(fileType.toLowerCase() == "image"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewImageScreen(imageType: PreviewImageType.file, imageFilePath: file.path)));
     } else if(fileType.toLowerCase() == "video") {
     }

   } catch(e) { throw Exception(); }
 }

 showInSnackBar({required String status, required String message}) {
   try{
     if(status == "message") {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: const Color(0xff333333),
         duration: const Duration(seconds: 2),
         content: Text(message),
       ));
     } else if(status == "error") {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: const Color(0xff333333),
         duration: const Duration(seconds: 2),
         content: Text(message, style: TextStyle(color: Theme
             .of(context)
             .colorScheme
             .primary),),
       ));
     }
   } catch(e) { throw Exception(); }

 }

}



