import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huz/Responsive/ResponsiveClass.dart';
import 'package:huz/TextStyles/Color.dart';
import 'package:huz/View/Booking/Widgets/Bookingeditecard.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../TextStyles/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final String title;
  final bool isSearch;
  var submite, onselectchanged, initialdate, mindate, endDate;

  CustomDatePicker(
      {super.key,
      this.isSearch = false,
      required this.title,
      required this.submite,
      required this.onselectchanged,
      required this.initialdate,
      this.mindate,
      this.endDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    String _selectedDate = '';
    String _dateCount = '';
    String _range = '';
    String _rangeCount = '';

    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd MMM yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd MMM yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            widget.isSearch
                ? const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.12),

                    blurRadius:
                        10, // Assuming responsive() function returns the responsive blur radius
                  )
                : const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                  )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(responsive(20, context),),
              bottom: Radius.circular(responsive(widget.isSearch ? 20 : 0, context),),

          )),
      // padding: EdgeInsets.symmetric(vertical: responsive(200, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
                  padding: widget.isSearch
                      ? EdgeInsets.only(
                    top: responsive(30, context),

                    right: responsive(20, context),
                    left: responsive(20, context),

                  )
                      :  EdgeInsets.symmetric(
                      horizontal: responsive(10, context),
                      vertical: responsive(5, context)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.isSearch
                          ? const SizedBox()
                          :  IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                      SizedBox(
                        width: responsive(10, context),
                      ),
                      customFonts(
                          text: widget.title,
                          size: 18,
                          fontWeight: FontWeight.w600,
                          context: context),
                      Spacer(),
                      widget.isSearch ? SizedBox() : Padding(
                        padding:
                            EdgeInsets.only(right: responsive(20, context)),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: customFonts(
                              color: AppColors.GlobelColor,
                              text: "Done",
                              size: 18,
                              fontWeight: FontWeight.bold,
                              context: context),
                        ),
                      ),
                    ],
                  ),
                ),

                // widget.isSearch
                // ? Padding(
                //   padding:  EdgeInsets.symmetric(vertical: responsive(10, context), horizontal: responsive(30, context)),
                //   child: customFonts(text: "24 Oct to 26 Oct", size: 16, color: Colors.black, context: context),
                // )
                //     : SizedBox(),
          widget.isSearch
              ? SizedBox()
              : Divider(
                  height: responsive(1, context),
                ),
          Padding(
            padding: widget.isSearch ? EdgeInsets.only(left: responsive(20, context), bottom: responsive(20, context), right: responsive(20, context)) :EdgeInsets.symmetric(horizontal: responsive(20, context)),
            child: SfDateRangePicker(
              headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                      color: AppColors.GlobelColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: responsive(16, context))),
              showActionButtons: false,
              onSubmit: widget.submite,
              // onCancel: () {
              //   Navigator.pop(context);
              // },

              initialDisplayDate: widget.isSearch ? DateTime.now() : widget.endDate,
              enableMultiView: true,
              minDate: widget.mindate,
              selectionMode: DateRangePickerSelectionMode.extendableRange,
              headerHeight: responsive(widget.isSearch ? 60 : 100, context),
              todayHighlightColor: Colors.black,
              startRangeSelectionColor: AppColors.GlobelColor.withOpacity(0.5),
              rangeSelectionColor: Colors.black.withOpacity(0.05),
              selectionColor: Colors.black,
              initialSelectedDate: widget.initialdate,
              backgroundColor: Colors.white,
              initialSelectedRange: widget.isSearch ? PickerDateRange(DateTime.now(), DateTime.now()):
                  PickerDateRange(widget.initialdate, widget.endDate),
              onSelectionChanged: widget.onselectchanged,
            ),
          ),
        ],
      ),
    );
  }
}
