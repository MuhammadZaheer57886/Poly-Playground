import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/ui/video_calls/video_calls.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

const appid = '60ad37e1891f44b4b1a8b94dce0cde24';
const token =
    '007eJxTYEi7827R+fP/zzjrV0s9cr7a+6/kgWe3+bNHdyYt+RV07nmyAoOZQWKKsXmqoYWlYZqJSZJJkmGiRZKlSUpyqkFySqqRye7pMSkNgYwM/7vSWBkZIBDEZ2EoSS0uYWAAAPEyJTE=';
const channelName = 'test';

class AgoraCall extends StatefulWidget {
  const AgoraCall({super.key});

  @override
  State<AgoraCall> createState() => AagoraStateCall();
}

class AagoraStateCall extends State<AgoraCall> {
  int uid = 0; // uid of the local user
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  bool muted = false; // Indicates if the local user is muted
  bool videoEnabled = true; // Indicates if the local user's video is enabled

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVideoSDKEngine();
  }
  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
      appId: appid,
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showSuccessToast(context,
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showSuccessToast(
              context, "Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showSuccessToast(
              context, "Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }
  void join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    try {
      await agoraEngine.joinChannel(
        token: token,
        channelId: channelName,
        options: options,
        uid: uid,
      );
    } catch (e) {
      print(e);
    }
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ 
        return false;
       },
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Center(
              child: Stack(
                children: [
                  _remoteVideo(),
                  _toolbar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 450, 20, 20),
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _localPreview(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 120, 50, 35),
                    child: RawMaterialButton(
                      onPressed: () {
                        agoraEngine.switchCamera();
                      },
                      shape: const CircleBorder(),
                      elevation: 20,
                      fillColor: Colors.pink,
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.sync,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: _isJoined ? null : () => {join()},
                    child: const Text("Join"),
                  ),
                  // ElevatedButton(
                  //     onPressed: _isJoined ? () => {leave()} : null,
                  //     child: const Text("Leave"),
                  // ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

// Display local video preview
  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Join a channel',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      msg = 'Calling';
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(Store().friend!.photoUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _isJoined ? null : () => {join()},
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.green,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.call,
              color: Colors.white,
              size: 35,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                videoEnabled = !videoEnabled;
                userAvatar();
              });
              agoraEngine.muteLocalVideoStream(!videoEnabled);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: videoEnabled
                ? const Color.fromARGB(255, 234, 238, 13)
                : const Color.fromARGB(255, 234, 238, 13),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              videoEnabled ? Icons.videocam : Icons.videocam_off,
              color: videoEnabled ? Colors.white : Colors.white,
              size: 35,
            ),
          ),
          RawMaterialButton(
            onPressed:(){
              leave();
              screenPush(context, const CallListScreen());},
                
                
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: const Color.fromARGB(255, 207, 73, 73),
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              agoraEngine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget userAvatar() {
    return CircleAvatar(
      backgroundImage: NetworkImage(Store().friend!.photoUrl),
    );
  }
}