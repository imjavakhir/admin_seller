import 'package:admin_seller/app_const/app_exports.dart';

import 'package:flutter/cupertino.dart';

class AcceptOrderPage extends StatefulWidget {
  const AcceptOrderPage({super.key});

  @override
  State<AcceptOrderPage> createState() => _AcceptOrderPageState();
}

class _AcceptOrderPageState extends State<AcceptOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Приём заказа',
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = orderList[index];
                return AcceptOrderCard(
                    onChangeTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UpdateOrderPage(
                            isNew: false,
                            order: orderList[index],
                          ),
                        ),
                      );
                    },
                    onDeleteTap: () {
                      orderList.removeAt(index);
                      setState(() {});
                    },
                    orderListModelItem: item,
                    id: item.id,
                    category: item.category,
                    idModel: item.idModel,
                    furnitureType: item.furnitureType,
                    furnitureModel: item.furnitureModel,
                    tissue: item.tissue,
                    price: item.price,
                    priceSale: item.priceSale,
                    count: item.count,
                    details: item.details,
                    salePercent: item.salePercent,
                    total: item.total);
              },
            ),
          ),
          ScreenUtil().setVerticalSpacing(96)
        ],
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
              child: LongButton(
                  buttonName: 'Подвердить',
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.checkOrder);
                  }),
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
                  Navigator.of(context).pushNamed(AppRoutes.addOrder);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                child: const Icon(
                  CupertinoIcons.cart_badge_plus,
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
