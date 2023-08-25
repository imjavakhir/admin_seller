import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class WarehouseCardWidget extends StatelessWidget {
  final VoidCallback? onTapFirst;
  final VoidCallback? onTapSecond;
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
          Row(
            mainAxisSize: MainAxisSize.min,
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
                        style:
                            Styles.headline5M.copyWith(color: AppColors.orange),
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
                        style:
                            Styles.headline5M.copyWith(color: AppColors.green),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              AnimatedFollowIcon(
                isAdded: orderList.map((e) => e.id).contains(id) ||
                    orderModelListWare.map((e) => e.id).contains(id),
                onAddTap: onTapThird,
                isDisabled: !canChange || productStatus != ProductStatus.booked,
              )
            ],
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
          productStatus == ProductStatus.active
              ? LongButton(
                  isBooking: true,
                  isDisabled:
                      !canChange && productStatus == ProductStatus.booked,
                  paddingW: 8,
                  buttonName: 'Бронь',
                  onTap: onTapFirst,
                  height: 36,
                  fontsize: 14,
                )
              : TransparentLongButton(
                  isDisabled:
                      !canChange && productStatus == ProductStatus.booked,
                  paddingW: 8,
                  height: 36,
                  fontsize: 14,
                  buttonName: 'Отменить',
                  onTap: onTapSecond)
        ],
      ),
    );
  }
}

class AnimatedFollowIcon extends StatefulWidget {
  final bool isDisabled;
  final VoidCallback onAddTap;
  final bool isAdded;
  const AnimatedFollowIcon(
      {super.key,
      required this.onAddTap,
      this.isDisabled = false,
      required this.isAdded});

  @override
  State<AnimatedFollowIcon> createState() => _AnimatedFollowIconState();
}

class _AnimatedFollowIconState extends State<AnimatedFollowIcon>
    with TickerProviderStateMixin {
  bool? onTapped = false;

  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
      upperBound: 1.25,
      lowerBound: 1.0);

  @override
  void initState() {
    onTapped = widget.isAdded;
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      padding: EdgeInsets.zero,
      minWidth: 48.w,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: !widget.isDisabled
          ? !onTapped!
              ? () {
                  setState(() {
                    if (onTapped == false) {
                      _animationController
                          .forward()
                          .then((value) => _animationController.reverse());
                    }
                    onTapped = !onTapped!;
                    widget.onAddTap();
                  });
                }
              : null
          : null,
      child: ScaleTransition(
        scale: _animationController,
        child: !onTapped!
            ? Icon(
                CupertinoIcons.add,
                size: 24.h,
              )
            : Icon(
                CupertinoIcons.check_mark,
                size: 24.r,
              ),
      ),
    );
  }
}
