import 'package:flutter/material.dart';

class CardWithTitleAndDetail extends StatelessWidget {
  const CardWithTitleAndDetail(
      {Key? key, required this.title, required this.detail, required this.side})
      : super(key: key);

  final String title;
  final String detail;
  final String side;

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment alignment;

    if (side == "left") {
      alignment = CrossAxisAlignment.start;
    } else {
      alignment = CrossAxisAlignment.end;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignment,
        children: [
          // title
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          // detail
          Text(
            detail,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
