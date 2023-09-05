import 'package:admin_seller/app_const/app_exports.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CheckOrderPage extends StatelessWidget {
  final GlobalKey<FormState> statusClientFormKey = GlobalKey<FormState>();
  CheckOrderPage({super.key});

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
            Form(
                key: statusClientFormKey,
                child: const ClientStatusDropDownWidget()),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Дата доставки',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            const CheckOrderDateWidget()
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
            final statusClientFormKeyValidate =
                statusClientFormKey.currentState!.validate();
            if (statusClientFormKeyValidate) {
              Navigator.of(context).pushNamed(AppRoutes.receipt);
            }
          },
        ),
      ),
    );
  }
}

class CheckOrderDateWidget extends StatelessWidget {
  const CheckOrderDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return AddOrderButtonWidget(
          onPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: CalendarDatePicker2(
                      onValueChanged: (value) {
                        BlocProvider.of<SellingBloc>(context).add(
                            CheckOrderDatePick(dateTimeDeliver: value.first));
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
                          weekdayLabelTextStyle: Styles.headline6
                              .copyWith(color: AppColors.grey, fontSize: 14.sp),
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
          isSelected: state.dateTimeDeliver != null,
          hint: state.dateTimeDeliver != null
              ? DateFormat('dd.MM.yyyy')
                  .format(state.dateTimeDeliver!.toLocal())
              : '01.01.2023',
        );
      },
    );
  }
}

class ClientStatusDropDownWidget extends StatelessWidget {
  const ClientStatusDropDownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: DropdownButtonFormField2(
            menuItemStyleData: MenuItemStyleData(
                height: 56.h, padding: EdgeInsets.symmetric(horizontal: 16.w)),
            hint: Text(
              'Выберите статус клиента',
              style: Styles.headline4.copyWith(color: AppColors.borderColor),
            ),
            enableFeedback: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              errorStyle: Styles.headline6.copyWith(color: AppColors.red),
              isCollapsed: true,
              filled: true,
              fillColor: AppColors.textfieldBackground,
              errorBorder: Decorations.errorBorder,
              focusedBorder: Decorations.focusedBorder,
              enabledBorder: Decorations.enabledBorder,
              focusedErrorBorder: Decorations.errorBorder,
            ),
            validator: (value) {
              return Validators.empty(value);
            },
            iconStyleData: IconStyleData(
                iconEnabledColor: AppColors.borderColor,
                iconSize: 24.h,
                icon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Icon(
                    CupertinoIcons.chevron_down,
                  ),
                )),
            buttonStyleData: ButtonStyleData(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              height: 56.h,
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            dropdownStyleData: DropdownStyleData(
              padding: EdgeInsets.zero,
              maxHeight: 280.h,
              offset: const Offset(0, -4),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.white),
            ),
            isExpanded: true,
            value: state.clientStatus,
            onChanged: (value) {
              BlocProvider.of<SellingBloc>(context)
                  .add(ClientStatusChange(clientStatus: value));
            },
            items: [
              DropdownMenuItem(
                value: 'Первая покупка',
                child: Text(
                  'Первая покупка',
                  style: Styles.headline4,
                ),
              ),
              DropdownMenuItem(
                value: 'Постоянный',
                child: Text(
                  'Постоянный',
                  style: Styles.headline4,
                ),
              )
            ],
          ),
        );
      },
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
