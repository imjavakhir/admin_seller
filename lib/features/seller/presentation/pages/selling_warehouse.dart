import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/features/seller/presentation/blocs/selling_bloc/selling_bloc.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/features/seller/repository/selling_repo.dart';
import 'package:admin_seller/src/shimmers/selling_warehouse_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

DateTime _currentDate = DateTime.now();

abstract class ProductStatus {
  static const String booked = 'BOOKED';
  static const String active = 'ACTIVE';
}

class SellingWareHouse extends StatefulWidget {
  const SellingWareHouse({super.key});

  @override
  State<SellingWareHouse> createState() => _SellingWareHouseState();
}

class _SellingWareHouseState extends State<SellingWareHouse> {
  final SellingRepository _sellingRepository = SellingRepository();
  SellingWarehouseModel? sellingWarehouseModel;

  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetWarehouseProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            title: 'Продажа со склада',
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
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.black,
            onRefresh: () async {
              return BlocProvider.of<SellingBloc>(context)
                  .add(GetWarehouseProducts());
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10.h, bottom: 96.h),
              itemCount: state.sellingWarehouseModel != null
                  ? state.sellingWarehouseModel!.products!.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                if (state.showLoadingWarehouseProducts) {
                  return const SellingWarehouseCardShimmer();
                }
                final item = state.sellingWarehouseModel!.products![index];

                return WarehouseCardWidget(
                  onTapThird: () {},
                  onTapFirst: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: StatefulBuilder(builder: (context, set) {
                                return Column(
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
                                          initialDateTime: DateTime.now().add(
                                              Duration(
                                                  minutes: 15 -
                                                      DateTime.now().minute %
                                                          15)),
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                          use24hFormat: true,
                                          backgroundColor: AppColors.white,
                                          onDateTimeChanged: (value) {
                                            set(() {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LongButton(
                                          paddingW: 0,
                                          buttonName: 'Подвердить',
                                          fontsize: 12,
                                          onTap: () async {
                                            BlocProvider.of<SellingBloc>(
                                                    context)
                                                .add(BookWarehouseProduct(
                                                    item.order!.id!,
                                                    _currentDate));
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
                                );
                              }),
                            ));
                  },
                  onTapSecond: () {
                    BlocProvider.of<SellingBloc>(context)
                        .add(UnbookWarehouseProduct(item.order!.id!));
                  },
                  canChange: item.order!.canChange!,
                  tissue: item.order!.tissue!,
                  details: item.order!.title!,
                  furnitureType: item.order!.model != null
                      ? item.order!.model!.furnitureType!.name!
                      : "- - -",
                  furnitureModel: item.order!.model != null
                      ? item.order!.model!.name!
                      : "- - -",
                  id: item.order!.orderId!,
                  warehouse: item.warehouse!.name!,
                  productStatus: item.order!.status!,
                );
              },
            ),
          ),
          bottomSheet: Container(
            alignment: Alignment.center,
            height: 96.h,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: AppColors.white,
                border:
                    Border(top: BorderSide(width: 0, color: AppColors.grey))),
            child: LongButton(
              buttonName: 'Сохранить',
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}

class WarehouseCardWidget extends StatelessWidget {
  final VoidCallback onTapFirst;
  final VoidCallback onTapSecond;
  final VoidCallback onTapThird;
  final String id;
  final String warehouse;
  final String furnitureType;
  final String tissue;
  final String details;
  final String furnitureModel;
  final String productStatus;
  final bool canChange;

  const WarehouseCardWidget({
    this.productStatus = ProductStatus.active,
    super.key,
    required this.id,
    required this.warehouse,
    required this.furnitureType,
    required this.tissue,
    required this.details,
    required this.furnitureModel,
    this.canChange = false,
    required this.onTapFirst,
    required this.onTapSecond,
    required this.onTapThird,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.r,
                color: AppColors.cardShadow,
                offset: const Offset(0, 0))
          ]),
      height: 250.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productStatus == ProductStatus.booked)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100.r)),
              height: 30.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_circle_fill,
                    size: 20.h,
                    color: AppColors.orange,
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  Text(
                    'Забронирована',
                    style: Styles.headline5M.copyWith(color: AppColors.orange),
                  ),
                ],
              ),
            ),
          if (productStatus == ProductStatus.active)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100.r)),
              height: 30.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    size: 20.h,
                    color: AppColors.green,
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  Text(
                    'Готова',
                    style: Styles.headline5M.copyWith(color: AppColors.green),
                  ),
                ],
              ),
            ),
          ScreenUtil().setVerticalSpacing(6),
          OrderCardTile(
            leading: 'ID',
            trailing: id,
          ),
          OrderCardTile(
            leading: 'Склад',
            trailing: warehouse,
          ),
          OrderCardTile(
            leading: 'Вид мебели',
            trailing: furnitureType,
          ),
          OrderCardTile(
            leading: 'Модель',
            trailing: furnitureModel,
          ),
          OrderCardTile(
            leading: 'Ткань',
            trailing: tissue,
          ),
          OrderCardTile(
            leading: 'Примичение',
            trailing: details,
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: LongButton(
                isDisabled: !canChange && productStatus == ProductStatus.booked,
                paddingW: 8,
                buttonName: productStatus == ProductStatus.active
                    ? 'Бронь'
                    : 'Отменить',
                onTap: productStatus == ProductStatus.active
                    ? onTapFirst
                    : onTapSecond,
                height: 36,
                fontsize: 14,
              )),
              Expanded(
                  child: LongButton(
                paddingW: 8,
                isDisabled: !canChange || productStatus != ProductStatus.booked,
                buttonName: 'Выбрать',
                fontsize: 14,
                onTap: onTapThird,
                height: 36,
              )),
            ],
          )
        ],
      ),
    );
  }
}




//////////////
///  showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    //       insetPadding: EdgeInsets.symmetric(
                    //           horizontal: 24.w, vertical: 24.h),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20.r)),
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 16.h, horizontal: 16.w),
                    //         child: CalendarDatePicker2WithActionButtons(
                    //           onValueChanged: (value) {},
                    //           onCancelTapped: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           onOkTapped: () {
                    //             Navigator.of(context).pop();

                              
                    //           },
                    //           config:
                    //               CalendarDatePicker2WithActionButtonsConfig(
                    //                   disableModePicker: true,
                    //                   centerAlignModePicker: true,
                    //                   lastMonthIcon: Icon(
                    //                     CupertinoIcons.chevron_back,
                    //                     size: 20.h,
                    //                   ),
                    //                   nextMonthIcon: Icon(
                    //                     CupertinoIcons.chevron_forward,
                    //                     size: 20.h,
                    //                   ),
                    //                   selectedYearTextStyle: Styles.headline5M,
                    //                   controlsTextStyle: Styles.headline4,
                    //                   firstDate: DateTime.now(),
                    //                   lastDate: DateTime(2099),
                    //                   currentDate: DateTime.now(),
                    //                   firstDayOfWeek: 0,
                    //                   yearTextStyle: Styles.headline5M,
                    //                   yearBorderRadius:
                    //                       BorderRadius.circular(10.r),
                    //                   selectedDayHighlightColor:
                    //                       AppColors.primaryColor,
                    //                   selectedDayTextStyle: Styles.headline6,
                    //                   weekdayLabelTextStyle: Styles.headline6
                    //                       .copyWith(
                    //                           color: AppColors.grey,
                    //                           fontSize: 14.sp),
                    //                   weekdayLabels: [
                    //                     'Пон.',
                    //                     'Вт.',
                    //                     'Ср.',
                    //                     'Чет.',
                    //                     'Пят.',
                    //                     'Суб.',
                    //                     'Вос.'
                    //                   ],
                    //                   dayTextStyle: Styles.headline6),
                    //           value: [DateTime.now()],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );