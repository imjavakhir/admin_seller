import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/blocs/selling_bloc/selling_bloc.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/features/seller/repository/selling_repo.dart';
import 'package:admin_seller/src/shimmers/my_orders_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final SellingRepository _sellingRepository = SellingRepository();
  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetSellingMyOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            title: 'Заказы',
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
                  .add(GetSellingMyOrders());
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: state.sellingMyOrders!.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.sellingMyOrders![index];
                if (state.showLoadingSellingMyOrders) {
                  return const MyOrdersCardShimmer();
                }
                return MyOrdersCard(
                  status: item!.copied!,
                  clientName: item.client!.name!,
                  idList: [
                    for (int i = 0; i < item.orders!.length; i++)
                      item.orders![i].orderId!
                  ].join(', '),
                  onTap: () {},
                  rest: item.rest!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class MyOrdersCard extends StatelessWidget {
  final String idList;
  final String clientName;
  final String rest;
  final bool status;
  final VoidCallback onTap;
  const MyOrdersCard({
    super.key,
    required this.idList,
    required this.clientName,
    required this.rest,
    required this.status,
    required this.onTap,
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
      height: 160.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardTile(
            leading: 'ID',
            trailing: idList.toString(),
          ),
          OrderCardTile(
            leading: 'Клиент',
            trailing: clientName,
          ),
          OrderCardTile(
            leading: 'Остаток',
            trailing: '$rest сум',
          ),
          OrderCardTile(
            leading: 'Статус',
            trailing: status ? 'В таблице' : 'Ожидание...',
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(vertical: -2),
                      foregroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r))),
                  onPressed: () {},
                  child: Text(
                    'Подробнее',
                    style: Styles.headline5M
                        .copyWith(color: AppColors.primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
