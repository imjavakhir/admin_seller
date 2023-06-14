import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AcceptOnlineAccept extends StatelessWidget {
  const AcceptOnlineAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Подтверждение'),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.black,
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 3000));
        },
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                AcceptWidget(
                    fullname: 'Javoxir',
                    phoneNumber: '+998909336272',
                    onTapTick: () {},
                    onTapClose: () {}),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class AcceptWidget extends StatelessWidget {
  final String fullname;
  final String phoneNumber;
  final VoidCallback onTapTick;
  final VoidCallback onTapClose;
  const AcceptWidget({
    super.key,
    required this.fullname,
    required this.phoneNumber,
    required this.onTapTick,
    required this.onTapClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.r,
                color: AppColors.cardShadow,
                offset: const Offset(0, 0))
          ]),
      height: 80.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullname,
                    style: Styles.headline4,
                  ),
                  Text(
                    phoneNumber,
                    style: Styles.headline5,
                  )
                ],
              ),
              const Spacer(),
              Material(
                type: MaterialType.button,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r)),
                child: IconButton(
                    splashColor: Colors.transparent,
                    splashRadius: 24,
                    onPressed: onTapTick,
                    icon: SvgPicture.asset(
                      AppIcons.tick,
                      height: 36.h,
                      width: 36.h,
                      color: AppColors.green,
                    )),
              ),
              Material(
                color: Colors.transparent,
                type: MaterialType.button,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r)),
                child: IconButton(
                    splashRadius: 24,
                    onPressed: onTapClose,
                    icon: SvgPicture.asset(
                      AppIcons.closeCircle,
                      height: 36.h,
                      width: 36.h,
                      color: AppColors.red,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
