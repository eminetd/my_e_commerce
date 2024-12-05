import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';

class PQuantity extends StatefulWidget {
  final List? productSize;
  final Function(String) onselected;
  const PQuantity({super.key, this.productSize, required this.onselected});

  @override
  State<PQuantity> createState() => _PQuantityState();
}

class _PQuantityState extends State<PQuantity> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.productSize!.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                widget.onselected("${widget.productSize?[i]}");
                _selected = i;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.10,
              decoration: BoxDecoration(
                color: _selected == i ? colors.myred : colors.mygrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                "${widget.productSize?[i]}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: colors.myblack),
              ),
            ),
          )
      ],
    );
  }
}
