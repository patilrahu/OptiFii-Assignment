import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class AppDropdown extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String placeholder;
  String? selectedOption;

  AppDropdown({
    super.key,
    this.selectedOption,
    required this.options,
    required this.onChanged,
    required this.placeholder,
  });

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    // setState(() {
    _controller.text = widget.selectedOption ?? '';
    // });
  }

  @override
  void didUpdateWidget(covariant AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedOption != widget.selectedOption) {
      _controller.text = widget.selectedOption ?? '';
    }
  }

  void _toggleDropdown() {
    // dismissKeyBoard(context);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: AppText(
              text: widget.placeholder,
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          InkWell(
            onTap: () {
              _toggleDropdown();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                enabled: false,
                style: TextStyle(
                    fontFamily: StringConstant.appFontFamily,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: widget.placeholder,
                  suffixIcon: Icon(
                    isSelected
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: HexColor(ColorCode.lightGreyColor),
                  ),
                  hintStyle: TextStyle(
                      fontFamily: StringConstant.appFontFamily,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor(ColorCode.borderColor),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor(ColorCode.borderColor),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ClipRect(
                  child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: isSelected ? 1.0 : 0.0,
                      child: Container(
                          height: widget.options.length > 10 ? 200 : null,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                            border: Border.all(
                                color: HexColor(ColorCode.borderColor),
                                width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.options.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: AppText(
                                    text: widget.options[index],
                                  ),
                                  onTap: () {
                                    widget.onChanged(widget.options[index]);
                                    _controller.text = widget.options[index];
                                    _toggleDropdown();
                                  },
                                );
                              },
                            ),
                          ))))),
        ],
      ),
    );
  }
}
