import 'package:flutter/material.dart';

class HeightRuler extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int) onChanged;

  const HeightRuler({
    super.key,
    required this.scrollController,
    required this.onChanged,
  });

  @override
  State<HeightRuler> createState() => _HeightRulerState();
}

class _HeightRulerState extends State<HeightRuler> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            final int selectedItem =
                (widget.scrollController.offset / 40).round();
            setState(() {
              _selectedItem = selectedItem;
            });
            widget.onChanged(_selectedItem);
            widget.scrollController.animateTo(
              (_selectedItem - 50) * 40.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
          return true;
        },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: widget.scrollController,
          itemCount: 237,
          itemBuilder: (context, index) {
            final int value = index;
            final bool isMajorTick = value % 10 == 0;
            final bool isSelected = value == _selectedItem;

            return Container(
              width: 40,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 2,
                    height: isMajorTick ? 30 : 15,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                  if (isMajorTick)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          padding: const EdgeInsets.only(right: 20), // Add padding to the right
        ),
      ),
    );
  }
}
