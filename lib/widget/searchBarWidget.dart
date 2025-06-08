import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSearch;
  final void Function(String)? onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        Expanded(
          child: Container(
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSearch,
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (onSearch != null) {
              onSearch!(controller.text.trim());
            }
          },
          child: const Text(
            'Tìm kiếm',
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
