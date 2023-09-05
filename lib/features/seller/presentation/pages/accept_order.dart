import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class AcceptOrderPage extends StatelessWidget {
  const AcceptOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          IconButton(
              splashRadius: 24.r,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addOrder);
              },
              icon: const Icon(
                CupertinoIcons.cart_badge_plus,
                color: AppColors.black,
              )),
          IconButton(
              splashRadius: 24.r,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addPayment);
              },
              icon: const Icon(
                Icons.payments,
                color: AppColors.black,
              ))
        ],
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.textfieldBackground),
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(10.r),
                enableFeedback: false,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.white),
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      'Заказы',
                      style: Styles.headline5M,
                    ),
                  ),
                  Tab(
                      child: Text(
                    'Оплаты',
                    style: Styles.headline5M,
                  )),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [OrdersTabView(), PaymentsTabView()]),
            )
          ],
        ),
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
            // Container(
            //   height: 56.h,
            //   width: 56.h,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.r),
            //       color: AppColors.primaryColor),
            //   child: MaterialButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(AppRoutes.addOrder);
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.r)),
            //     child: const Icon(
            //       CupertinoIcons.cart_badge_plus,
            //     ),
            //   ),
            // ),
            // ScreenUtil().setHorizontalSpacing(24),
          ],
        ),
      ),
    );
  }
}

class OrdersTabView extends StatefulWidget {
  const OrdersTabView({super.key});

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.h, bottom: 90.h),
      itemCount: orderList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = orderList[index];
        return AcceptOrderCard(
            onEditTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UpdateOrderPage(
                    index: index,
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
    );
  }
}
