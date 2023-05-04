import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

const appID = 1466522659;
const appSign =
    '20713d538f797cb1d036f2ab9445b16a4758241a1db66d7f4c99c31c31176f36';

class ZegoCall extends StatelessWidget {
  const ZegoCall(
      {super.key, required this.callModel, required this.callID,
      });
  final CallModel callModel;
  final String callID;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: callModel.uid,
      userName: callModel.fullName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = () => Navigator.of(context).pop(),
    );
  }
}
