import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/features/seller/presentation/blocs/selling_bloc/selling_bloc.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_order.dart';
import 'package:admin_seller/features/seller/presentation/widgets/warehouse_card.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/shimmers/selling_warehouse_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

DateTime _currentDate = DateTime.now();
List<OrderListModel> orderModelListWare = [];

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
            actions: [
              IconButton(
                  enableFeedback: false,
                  splashRadius: 24.r,
                  iconSize: 24.h,
                  onPressed: () {
                    BlocProvider.of<SellingBloc>(context).add(SearchHasEvent());
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: AppColors.black,
                  )),
            ],
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.isHasSearch)
                  FadeIn(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: true,
                              onChanged: (value) {
                                BlocProvider.of<SellingBloc>(context)
                                    .add(SearchWarehouseProduct(value));
                              },
                              enableSuggestions: false,
                              style: Styles.headline4,
                              decoration: InputDecoration(
                                  constraints: const BoxConstraints(),
                                  hintText: 'Поиск...',
                                  prefixIcon: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: const Icon(
                                      CupertinoIcons.search,
                                      color: AppColors.textfieldText,
                                    ),
                                  ),
                                  hintStyle: Styles.headline4
                                      .copyWith(color: AppColors.textfieldText),
                                  prefixIconConstraints: const BoxConstraints(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  filled: true,
                                  isDense: true,
                                  isCollapsed: true,
                                  enabledBorder: Decorations.enabledBorder,
                                  focusedBorder: Decorations.focusedBorder,
                                  errorBorder: Decorations.errorBorder),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<SellingBloc>(context)
                                      .add(SearchHasEvent());

                                  BlocProvider.of<SellingBloc>(context)
                                      .add(GetWarehouseProducts());
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.r))),
                                child: Text(
                                  'Отменить',
                                  style: Styles.headline4,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: state.sellingWarehouseModel.isNotEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 10.h, bottom: 96.h),
                          itemCount: state.sellingWarehouseModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (state.showLoadingWarehouseProducts) {
                              return const SellingWarehouseCardShimmer();
                            }
                            final item = state.sellingWarehouseModel[index];

                            return WarehouseCardWidget(
                              onTapThird: () {
                                final newItem = OrderListModel(
                                    id: item.order!.orderId!,
                                    salePercent:
                                        double.tryParse(item.order!.sale!)!,
                                    total: double.parse(item.order!.sum!),
                                    category: 'Продажа со склада',
                                    idModel: item.order!.id!,
                                    furnitureType:
                                        item.order!.model!.furnitureType!.name!,
                                    furnitureModel: item.order!.model!.name!,
                                    tissue: item.order!.tissue!,
                                    price: double.parse(item.order!.cost!),
                                    priceSale:
                                        double.tryParse(item.order!.sum!)!,
                                    count: item.order!.qty!,
                                    details: item.order!.title!);
                                debugPrint(newItem.id);
                                debugPrint(newItem.count.toString());
                                debugPrint(newItem.category);
                                debugPrint(newItem.furnitureType);
                                debugPrint(newItem.furnitureModel);
                                debugPrint(newItem.tissue);
                                debugPrint(newItem.price.toString());
                                debugPrint(newItem.priceSale.toString());
                                debugPrint(newItem.details);
                                debugPrint(newItem.salePercent.toString());
                                debugPrint(newItem.total.toString());
                                orderModelListWare.add(newItem);
                                setState(() {});
                              },
                              onTapFirst: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        DateAndTimeWarehouse(item: item));
                              },
                              onTapSecond: () {
                                BlocProvider.of<SellingBloc>(context).add(
                                    UnbookWarehouseProduct(item.order!.id!));
                              },
                              canChange: item!.order!.canChange!,
                              tissue: item.order!.tissue!,
                              details: item.order!.title!,
                              furnitureType: item.order!.model != null
                                  ? item.order!.model!.furnitureType!.name!
                                  : "- - -",
                              furnitureModel: item.order!.model != null
                                  ? item.order!.model!.name!
                                  : "- - -",
                              id: item.order!.orderId!,
                              warehouse: item.warehouse!.name != null
                                  ? item.warehouse!.name!
                                  : '- - -',
                              productStatus: item.order!.status!,
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  100.r,
                                ),
                                color: AppColors.primaryColor.withOpacity(0.5)),
                            child: Text(
                              'Ничего не найдено',
                              style: Styles.headline4,
                            ),
                          ),
                        ),
                ),
              ],
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
              onTap: () {
                orderList.addAll(orderModelListWare);
                Navigator.of(context).pushNamed(AppRoutes.acceptOrder);
                orderModelListWare.clear();
              },
            ),
          ),
        );
      },
    );
  }
}

class DateAndTimeWarehouse extends StatelessWidget {
  const DateAndTimeWarehouse({
    super.key,
    required this.item,
  });

  final Product? item;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
                  initialDateTime: DateTime.now()
                      .add(Duration(minutes: 15 - DateTime.now().minute % 15)),
                  mode: CupertinoDatePickerMode.dateAndTime,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LongButton(
                  paddingW: 0,
                  buttonName: 'Подвердить',
                  fontsize: 12,
                  onTap: () async {
                    BlocProvider.of<SellingBloc>(context).add(
                        BookWarehouseProduct(item!.order!.id!, _currentDate));
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
    );
  }
}
