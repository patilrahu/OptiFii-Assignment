import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/constant/string_constant.dart';
import 'package:remburshiment_app/widgets/app_text.dart';

class AppDatePicker extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  String? hintTextDate;
  String? defaultDate;
  AppDatePicker(
      {super.key,
      required this.onDateSelected,
      this.hintTextDate,
      this.defaultDate});

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  final TextEditingController _datePickerController = TextEditingController();
  DateTime today = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime defaultFirstDate = DateTime(today.year - 100);
    DateTime defaultLastDate = DateTime(today.year + 50);
    setState(() {
      today = widget.defaultDate != ''
          ? DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.defaultDate!)
          : DateTime.now();
    });

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: defaultFirstDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                      fontFamily: StringConstant.appFontFamily,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: defaultLastDate);

    if (pickedDate != null) {
      setState(() {
        final now = DateTime.now();
        final fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          now.hour,
          now.minute,
          now.second,
        );
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);

        _datePickerController.text = formattedDate;
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(pickedDate);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _datePickerController.text = widget.defaultDate ?? '';
    });
  }

  @override
  void didUpdateWidget(covariant AppDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultDate != widget.defaultDate) {
      _datePickerController.text = widget.defaultDate ?? '';
    }
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
              text: widget.hintTextDate ?? '',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          InkWell(
            onTap: () {
              // dismissKeyBoard(context);
              _selectDate(context);
            },
            child: Container(
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
                controller: _datePickerController,
                enabled: false,
                readOnly: true,
                style: TextStyle(
                    fontFamily: StringConstant.appFontFamily,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                    color: HexColor(ColorCode.lightGreyColor),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: widget.hintTextDate ?? 'YYYY-MM-DD',
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor(ColorCode.borderColor)),
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
        ],
      ),
    );
  }
}
