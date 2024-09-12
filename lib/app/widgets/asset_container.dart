import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetContainer extends StatefulWidget {
  final AssetEntity asset;
  final String newDateStr;

  const AssetContainer(this.asset, this.newDateStr, {super.key});

  @override
  State<AssetContainer> createState() => _AssetContainerState();
}

class _AssetContainerState extends State<AssetContainer>
    with AutomaticKeepAliveClientMixin {
  Uint8List? thumbData;

  @override
  void initState() {
    super.initState();
    widget.asset.thumbnailData.then((value) {
      if (mounted) {
        setState(() {
          thumbData = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Row(
      children: [
        if (thumbData != null)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0x34000000), spreadRadius: 0, blurRadius: 5),
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: Image.memory(thumbData!, fit: BoxFit.cover),
            ),
          ),
        const Spacer(),
        SizedBox(width: 5.w),
        Text(widget.newDateStr),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
