import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateAndTimeWarehouse extends StatefulWidget {
  const DateAndTimeWarehouse({
    super.key,
    required this.item, required this.index,
  });

  final Product? item;
  final int index;

  @override
  State<DateAndTimeWarehouse> createState() => _DateAndTimeWarehouseState();
}

class _DateAndTimeWarehouseState extends State<DateAndTimeWarehouse> {
  DateTime _currentDate =
      DateTime.now().add(Duration(minutes: 15 - DateTime.now().minute % 15));
  @override
  Widget build(BuildContext context) {
    debugPrint(DateTime.now()
        .add(Duration(minutes: 10 - DateTime.now().minute % 15))
        .toString());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenUtil().setVerticalSpacing(24),
          Text(
            'Виберите дату и время',
            style: Styles.headline2,
          ),
          SizedBox(
            height: 250.h,
            width: double.maxFinite,
            child: CupertinoDatePicker(
                minuteInterval: 15,
                minimumDate: DateTime.now(),
                initialDateTime: DateTime.now()
                    .add(Duration(minutes: 15 - DateTime.now().minute % 15)),
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: true,
                backgroundColor: AppColors.white,
                onDateTimeChanged: (value) {
                  setState(() {
                    debugPrint(value.toString());
                    _currentDate = value;
                  });
                }),
          ),
          Text(
            "Дата и время: ${DateFormat('HH:mm  dd/MM').format(_currentDate.toLocal())}",
            style: Styles.headline4,
          ),
          ScreenUtil().setVerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LongButton(
                paddingW: 0,
                buttonName: 'Подвердить',
                fontsize: 12,
                onTap: () async {
                  BlocProvider.of<SellingBloc>(context).add(
                      BookWarehouseProduct(
                          widget.item!.order!.id!, _currentDate,widget.index));
                  Navigator.of(context).pop();
                },
                height: 40,
                width: 120,
              ),
              ScreenUtil().setHorizontalSpacing(20),
              TransparentLongButton(
                paddingW: 0,
                width: 120,
                height: 40,
                fontsize: 12,
                buttonName: 'Отменить',
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          ScreenUtil().setVerticalSpacing(24),
        ],
      ),
    );
  }
}
