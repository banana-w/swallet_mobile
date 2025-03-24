import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_6/form_body_5.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';

class Content5 extends StatelessWidget {
  const Content5({
    super.key,
    required this.widget,
    required this.codeController,
  });

  final FormBody5 widget;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 318 * widget.fem,
      height: 100 * widget.hem,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * widget.fem),
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0 * widget.fem, 4 * widget.fem),
            blurRadius: 2.5 * widget.fem,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldDefault(
            hem: widget.hem,
            fem: widget.fem,
            ffem: widget.ffem,
            labelText: 'MÃ GIỚI THIỆU',
            hintText: 'Nhập mã giới thiệu...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mã giới thiệu không được bỏ trống';
              }

              return null;
            },
            textController: codeController,
          ),
        ],
      ),
    );
  }
}
