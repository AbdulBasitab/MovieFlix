import 'package:flutter/material.dart';

class CustomMaterial3SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final FocusNode focusNode;

  const CustomMaterial3SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.focusNode,
  });

  @override
  _CustomMaterial3SearchBarState createState() =>
      _CustomMaterial3SearchBarState();
}

class _CustomMaterial3SearchBarState extends State<CustomMaterial3SearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 69,
      child: Material(
        color: Colors.grey.shade800,
        //shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              top: 14,
            ),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isFocused
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      widget.onClear();
                    },
                  )
                : null,
            hintText: 'Search Movies',
            border: InputBorder.none,
          ),
          onTap: () {
            setState(() {
              _isFocused = true;
            });
          },
          onEditingComplete: () {
            setState(() {
              _isFocused = false;
            });
          },
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
