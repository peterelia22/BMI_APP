import 'package:flutter/material.dart';

import 'height_ruler.dart';
import 'height_tittle.dart';

class Height extends StatefulWidget {
  final int height;
  final Function(int) onChanged;
  final bool isHeightSelected;
  const Height({
    super.key,
    required this.onChanged,
    required this.isHeightSelected,
    required this.height,
  });

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  int _height = 0;
  late ScrollController _scrollController;
  int _selectedItem = 0;
  bool _isHeightSelected = false; // Add this flag

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeightTitle(
              isHeightSelected: widget.isHeightSelected,
              height: _height,
            ),
            const SizedBox(height: 10),
            HeightRuler(
              scrollController: _scrollController,
              onChanged: (height) {
                setState(() {
                  _selectedItem = height;
                  _height = _selectedItem;
                  _isHeightSelected = true;
                });
                widget.onChanged(_height);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
