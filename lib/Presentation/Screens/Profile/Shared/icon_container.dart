import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IconOption { chat, call, video, direct }

class IconContainer extends StatelessWidget {
  const IconContainer({Key? key, required this.iconOption}) : super(key: key);
  final IconOption iconOption;

  Icon getIcon() {
    switch (iconOption) {
      case IconOption.direct:
        return const Icon(
          CupertinoIcons.play_arrow,
          color: ColorUtil.primaryColor,
        );
      case IconOption.call:
        return const Icon(
          Icons.call_outlined,
          color: ColorUtil.primaryColor,
        );
      case IconOption.chat:
        return const Icon(
          Icons.chat_bubble_outline,
          color: ColorUtil.primaryColor,
        );
      case IconOption.video:
        return const Icon(
          CupertinoIcons.video_camera,
          color: ColorUtil.primaryColor,
        );
      default:
        return const Icon(CupertinoIcons.play_arrow,
            color: ColorUtil.primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorUtil.primaryColor.withOpacity(.10),
      ),
      height: 48,
      width: 48,
      child: getIcon(),
    );
  }
}
