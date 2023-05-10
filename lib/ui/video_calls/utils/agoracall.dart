import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'agora_id.dart';



class AgoraCall extends StatefulWidget {
  const AgoraCall({super.key});
  
  @override
  State<AgoraCall> createState() => AagoraStateCall();
}

class AagoraStateCall extends State<AgoraCall> {
  
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: appid,
      channelName: channelName,
      tempToken: token,
      uid: uid, 
      // int.tryParse(Store().friend!.uid), 
    ),
    
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    try{
    await client.initialize();  
    } catch(e){
      print(e);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: client,
            layoutType: Layout.floating,
            showAVState: true,
            
            disabledVideoWidget: Container(
              color: AppColors.i.greyColor,
              child: Center(
                child: Text( 
                  'Video Disabled',
                  style: TextStyle(
                    color: AppColors.i.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            
          ),
          AgoraVideoButtons(client: client,)
        ],
      )
    
    );
  }
}
  // final _users = <int>[];
  // final infoString = <String>[];
  // bool muted = false;
  // bool videoPanel = false;
  // late RtcEngine _engine;

  // @override
  // void initState() {
  //   super.initState();
  //   initAgora();
  // }

  // @override
  // void dispose() {
  //   _users.clear();
  //   _engine.leaveChannel();
  //   // _engine.destroy();
  //   super.dispose();
  // }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: appid,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             final info = 'onJoinChannel: $connection, elapsed $elapsed';
//             infoString.add(info);
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             infoString.add('userJoined: $remoteUid');
//             _users.add(remoteUid);
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             infoString.add('userOffline: $remoteUid');
//             _users.remove(remoteUid);
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );
//   }

// // Widget _viewRows(){
// //   fianl List <StatefulWidget> list = [];
// // }
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: () {
//               setState(() {
//                 muted = !muted;
//               });
//               _engine.muteLocalAudioStream(muted);
//             },
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () => Navigator.pop(context),
//             shape: const CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//             child: const Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               _engine.switchCamera();
//             },
//             shape: const CircleBorder(),
//             elevation: 20,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//             child: const Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// Widget _panel(){
//   return Visibility(child: Container(
//     padding: const EdgeInsets.symmetric(vertical: 48),
//     child: ListView.builder(
//       reverse: true,
//       itemCount: infoString.length,
//       itemBuilder: (BuildContext context, int index){
//         if(infoString.isEmpty){
//           return const Text('null');
//         }
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.yellowAccent,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Text(
//                     infoString[index],
//                     style: const TextStyle(color: Colors.blueGrey),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//   ),
//   ),
//   );
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.i.darkBrownColor,
//         title: const Text("Video Call"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 videoPanel = !videoPanel;
//               });
//             },
//             icon: const Icon(Icons.info_outline),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Stack(
//           children: <Widget>[
//             _panel(),
//             _toolbar(),

//           ],
//         ),
//       ),
//     );
//   }
// }
