import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/src/shimmers/my_orders_shimmer.dart';
import 'package:flutter/cupertino.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
            child: state.sellingMyOrders != null &&
                    state.sellingMyOrders!.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: state.sellingMyOrders!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = state.sellingMyOrders![index];
                      if (state.showLoadingSellingMyOrders) {
                        return const MyOrdersCardShimmer();
                      }
                      return MyOrdersCard(
                        idListNames: [
                          for (int i = 0; i < item!.orders!.length; i++)
                            item.orders![i].orderId!
                        ],
                        status: item.copied!,
                        clientName: item.client!.name!,
                        idList: [
                          for (int i = 0; i < item.orders!.length; i++)
                            item.orders![i].orderId!
                        ].join(', '),
                        onTap: () {},
                        rest: item.rest!,
                      );
                    },
                  )
                : const Center(
                    child: Text('Empty'),
                  ),
          ),
        );
      },
    );
  }
}

class MyOrdersCard extends StatelessWidget {
  final String idList;
  final List<String?> idListNames;
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
    required this.idListNames,
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 24.h, horizontal: 16.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Ваш заказ',
                                  style: Styles.headline3M,
                                ),
                              ),
                              ScreenUtil().setVerticalSpacing(10),
                              Text(
                                'ID заказов',
                                style: Styles.headline5M
                                    .copyWith(color: AppColors.grey),
                              ),
                              Wrap(
                                spacing: 4.w,
                                children: List.generate(
                                    idListNames.length,
                                    (index) => Chip(
                                        backgroundColor: AppColors.primaryColor,
                                        label: Text(
                                          idListNames[index]!,
                                          style: Styles.headline5M
                                              .copyWith(fontSize: 12),
                                        ))),
                              ),
                              ScreenUtil().setVerticalSpacing(6),
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
                              ScreenUtil().setVerticalSpacing(20),
                              Center(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity:
                                            const VisualDensity(vertical: -2),
                                        foregroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.r))),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style: Styles.headline5M.copyWith(
                                          color: AppColors.primaryColor),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
