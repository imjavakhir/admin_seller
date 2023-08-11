import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/features/seller_admin/data/admin_seller_visits.dart';
import 'package:admin_seller/features/seller_admin/presentation/blocs/seller_admin_bloc.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/admin_visit_sellers.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AdminVisitsCard extends StatelessWidget {
  const AdminVisitsCard({
    super.key,
    required this.isAccepted,
    required this.isCanceled,
    required this.details,
    required this.dateTime,
    required this.fullname,
    required this.phoneNumber,
    required this.id,
    required this.seller,
    required this.isStored,
    this.isStoredClients = false,
  });
  final bool isStoredClients;
  final String id;
  final bool isStored;
  final SellerAd? seller;
  final String fullname;
  final String phoneNumber;
  final bool isAccepted;
  final bool isCanceled;
  final String details;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      height: 190.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
              width: 1,
              color: (!isAccepted) ? AppColors.orange : AppColors.green),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.r,
                color: AppColors.cardShadow,
                offset: const Offset(0, 0))
          ]),
      child: MaterialButton(
        enableFeedback: false,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: AppColors.white,
              isScrollControlled: true,
              useSafeArea: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              context: context,
              builder: (context) => AdminSellerVisitSellersWidget(
                    id: id,
                    isStoredClients: isStoredClients,
                  )).then((value) =>
              BlocProvider.of<SellerAdminBloc>(context).add(ChangePageView(0)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Параметры клиента',
                  style: Styles.headline4,
                ),
                const Spacer(),
                if ((!isAccepted && !isCanceled))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcons.clock,
                        color: AppColors.orange,
                        height: 18.h,
                        width: 18.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(4),
                      Text(
                        'В ожидание',
                        style:
                            Styles.headline6.copyWith(color: AppColors.orange),
                      ),
                    ],
                  ),
                if (isAccepted)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcons.tick,
                        color: AppColors.green,
                        height: 18.h,
                        width: 18.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(4),
                      Text(
                        'Принято',
                        style:
                            Styles.headline6.copyWith(color: AppColors.green),
                      ),
                    ],
                  )
              ],
            ),
            ScreenUtil().setVerticalSpacing(6.h),
            SizedBox(
              width: 250.w,
              child: Text(
                details,
                style: Styles.headline6,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
              ),
            ),

            const Spacer(),
            const Divider(
              height: 0,
              color: AppColors.grey,
            ),
            ScreenUtil().setVerticalSpacing(6.h),

            Text(
              !isAccepted && !isCanceled
                  ? !isStored
                      ? '$fullname\n+998$phoneNumber'
                      : "Пока в ожидание"
                  : '$fullname\n+998$phoneNumber',
              style: Styles.headline6.copyWith(color: AppColors.black),
            ),
            // Text(
            //   'Sevara\n+998909009090',
            //   style: Styles.headline6.copyWith(color: AppColors.black),
            // ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat('HH:mm  dd/MM').format(dateTime.toLocal()),
                  style: Styles.headline6.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
