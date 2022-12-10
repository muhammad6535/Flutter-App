import 'package:flutter/material.dart';

class DeliveryTypeBtnWidget extends StatefulWidget {
  final Color bgColor;
  final String icon;
  final String text;
  final bool isSelected;
  const DeliveryTypeBtnWidget({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.text,
    required this.isSelected,
  });

  @override
  State<DeliveryTypeBtnWidget> createState() => _DeliveryTypeBtnWidgetState();
}

class _DeliveryTypeBtnWidgetState extends State<DeliveryTypeBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(children: [
              widget.isSelected
                  ? Container(
                      height: 0,
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 20.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    )
                  : Container()
            ]),
            Image.network(
              widget.icon,
              height: 75,
              color: Colors.white70,
            ),
            Text(widget.text,
                style: const TextStyle(color: Colors.white, fontSize: 16))
          ],
        ));
  }
}
