import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/constants.dart';

/// Một dòng "nhãn — giá trị" trong hoá đơn và biên lai giao dịch.
///
/// Dùng chung cho màn thanh toán, màn thành công và màn thất bại, vốn lặp lại
/// đúng một khối `SizedBox > Row(spaceBetween)` cho mỗi dòng.
class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.height,
    required this.label,
    required this.labelStyle,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final double height;
  final String label;
  final TextStyle labelStyle;
  final Widget value;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: crossAxisAlignment,
        children: [Text(label, style: labelStyle), value],
      ),
    );
  }
}

/// Số coin kèm icon đồng xu.
class CoinAmount extends StatelessWidget {
  const CoinAmount({
    super.key,
    required this.amount,
    required this.style,
    required this.iconSize,
    required this.iconPadding,
  });

  final double amount;
  final TextStyle style;
  final double iconSize;
  final EdgeInsets iconPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(formatter.format(amount), style: style),
        Padding(
          padding: iconPadding,
          child: SvgPicture.asset(
            'assets/icons/coin.svg',
            width: iconSize,
            height: iconSize,
          ),
        ),
      ],
    );
  }
}
