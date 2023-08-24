import 'package:admin_seller/app_const/app_exports.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';

class CheckOrderPage extends StatelessWidget {
  const CheckOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Подтверждение',
        leading: IconButton(
            enableFeedback: false,
            splashRadius: 24.r,
            iconSize: 24.h,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.chevron_left,
              color: AppColors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenUtil().setVerticalSpacing(10),
            const CheckPageDetailTile(
              title: 'Имя клиента',
              subtitle: 'Лили',
            ),
            ScreenUtil().setVerticalSpacing(10),
            const CheckPageDetailTile(
              title: 'Номер телефона',
              subtitle: '+998909336666',
            ),
            ScreenUtil().setVerticalSpacing(10),
            const CheckPageDetailTile(
              title: 'Откуда узнал о нас',
              subtitle: 'Telegram',
            ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Статус клиента',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            const ClientStatusDropDownWidget(),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Дата доставки',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            AddOrderButtonWidget(
              onPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 24.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        child: CalendarDatePicker2(
                          onValueChanged: (value) {
                            Navigator.of(context).pop();
                          },
                          config: CalendarDatePicker2Config(
                              disableModePicker: true,
                              centerAlignModePicker: true,
                              lastMonthIcon: Icon(
                                CupertinoIcons.chevron_back,
                                size: 20.h,
                              ),
                              nextMonthIcon: Icon(
                                CupertinoIcons.chevron_forward,
                                size: 20.h,
                              ),
                              selectedYearTextStyle: Styles.headline5M,
                              controlsTextStyle: Styles.headline4,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2099),
                              currentDate: DateTime.now(),
                              firstDayOfWeek: 0,
                              yearTextStyle: Styles.headline5M,
                              yearBorderRadius: BorderRadius.circular(10.r),
                              selectedDayHighlightColor: AppColors.primaryColor,
                              selectedDayTextStyle: Styles.headline6,
                              weekdayLabelTextStyle: Styles.headline6.copyWith(
                                  color: AppColors.grey, fontSize: 14.sp),
                              weekdayLabels: [
                                'Пон.',
                                'Вт.',
                                'Ср.',
                                'Чет.',
                                'Пят.',
                                'Суб.',
                                'Вос.'
                              ],
                              dayTextStyle: Styles.headline6),
                          value: [DateTime.now()],
                        ),
                      ),
                    );
                  },
                );
              },
              hint: '01.01.2023',
            )
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 96.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(width: 0, color: AppColors.grey))),
        child: LongButton(
          buttonName: 'Подвердить',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.paymentOrder);
          },
        ),
      ),
    );
  }
}

class ClientStatusDropDownWidget extends StatelessWidget {
  const ClientStatusDropDownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: DropdownButton2(
        menuItemStyleData: MenuItemStyleData(height: 56.h),
        hint: Text(
          'Выберите статус клиента',
          style: Styles.headline4.copyWith(color: AppColors.borderColor),
        ),
        enableFeedback: false,
        underline: const SizedBox(),
        iconStyleData: IconStyleData(
            iconEnabledColor: AppColors.borderColor,
            iconSize: 24.h,
            icon: const Icon(
              CupertinoIcons.chevron_down,
            )),
        buttonStyleData: ButtonStyleData(
            width: double.maxFinite,
            height: 56.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
                color: AppColors.textfieldBackground,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(width: 1, color: AppColors.borderColor))),
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -4),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
                border: Border.all(width: 1, color: AppColors.borderColor))),
        isExpanded: true,
        onChanged: (value) {},
        items: [
          DropdownMenuItem(
            value: 'first',
            child: Text(
              'Первая покупка',
              style: Styles.headline4,
            ),
          ),
          DropdownMenuItem(
            value: 'always',
            child: Text(
              'Постоянный',
              style: Styles.headline4,
            ),
          )
        ],
      ),
    );
  }
}

class CheckPageDetailTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const CheckPageDetailTile(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.headline4,
          ),
          ScreenUtil().setVerticalSpacing(4),
          Text(
            subtitle,
            style: Styles.headline6.copyWith(fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
