import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../modules/timeselection/views/timeselection_view.dart';
import 'app_button.dart';

class DateTimeInput extends StatefulWidget {
  final Rx<InputMode> mode = Rx<InputMode>(InputMode.set);
  final TextEditingController teController = TextEditingController();
  final RxBool _updater = RxBool(false);
  final String text;

  DateTimeInput({
    super.key,
    required this.text,
  }) {
    teController.addListener(() {
      _updater.value = !_updater.value;
    });

    mode.listen((p0) {
      _updater.value = !_updater.value;
    });
  }

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();

  void listenChangesForObx() {
    _updater.value;
  }

  int calcValue(int value) {
    String text = teController.text;
    if (text.trim().isEmpty) return value;

    int? inputValue = int.tryParse(text);
    if (inputValue == null) return value;

    if (mode.value == InputMode.set) return inputValue;

    return value + (mode.value == InputMode.add ? 1 : -1) * inputValue;
  }
}

class _DateTimeInputState extends State<DateTimeInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.text,
                style:
                    TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold)),
            SizedBox(height: 5.h),
            _textField(),
            SizedBox(height: 5.h),
            _buttons()
          ],
        ));
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFF0F2F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Center(
        child: TextField(
          controller: widget.teController,
          keyboardType: const TextInputType.numberWithOptions(signed: false),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "Optional value"),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(child: Obx(() {
          Color? color = const Color(0xFFDDDEE1);
          if (widget.mode.value == InputMode.set) color = null;
          return AppButton(
              text: "Set",
              color: color,
              func: () {
                widget.mode(InputMode.set);
              });
        })),
        SizedBox(width: 5.w),
        Expanded(child: Obx(() {
          Color? color = const Color(0xFFDDDEE1);
          if (widget.mode.value == InputMode.add) color = null;

          return AppButton(
              text: "+",
              color: color,
              func: () {
                widget.mode(InputMode.add);
              });
        })),
        SizedBox(width: 5.w),
        Expanded(child: Obx(() {
          Color? color = const Color(0xFFDDDEE1);

          if (widget.mode.value == InputMode.sub) color = null;
          return AppButton(
              text: "-",
              color: color,
              func: () {
                widget.mode.value = InputMode.sub;
              });
        })),
      ],
    );
  }
}
