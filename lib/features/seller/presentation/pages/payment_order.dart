import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_payment.dart';
import 'package:admin_seller/features/seller/presentation/widgets/order_tile_widget.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentOrderPage extends StatelessWidget {
  const PaymentOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Предоплаты',
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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
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
            height: 200.h,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderCardTile(
                  leading: 'Вид оплаты',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Предоплата(\$)',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Предоплата(Сум)',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Курс \$100',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Сумма по курсу',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Здачи',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Итого(Сум)',
                  trailing: '950 000 сум',
                ),
                OrderCardTile(
                  leading: 'Остаток',
                  trailing: '950 000 сум',
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 96.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(width: 0, color: AppColors.grey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LongButton(buttonName: 'Подвердить', onTap: () {}),
            ),
            Container(
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 1,
                        maxChildSize: 1,
                        minChildSize: 1,
                        builder: (context, scrollController) =>
                            const AddPaymentPage(),
                      );
                    },
                  );
                  // Navigator.of(context).pushNamed(AppRoutes.addPayment);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                child: const Icon(
                  Icons.payments,
                ),
              ),
            ),
            ScreenUtil().setHorizontalSpacing(24),
          ],
        ),
      ),
    );
  }
}
