import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller_admin/presentation/blocs/seller_admin_bloc.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/admin_visit_card.dart';
import 'package:admin_seller/src/shimmers/admin_visit_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminClientsPage extends StatefulWidget {
  const AdminClientsPage({super.key});

  @override
  State<AdminClientsPage> createState() => _AdminClientsPageState();
}

class _AdminClientsPageState extends State<AdminClientsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBarWidget(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: AppColors.black,
              ),
              splashRadius: 24.r,
            ),
            title: 'Сегодняшние клиенты',
          ),
          body: Column(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.textfieldBackground),
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: TabBar(
                  enableFeedback: false,
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        'Все',
                        style: Styles.headline5M,
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Новые',
                      style: Styles.headline5M,
                    )),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      AcceptedWaitingClientsWidget(),
                      StoredClientsWidget()
                    ]),
              )
            ],
          )),
    );
  }
}

class AcceptedWaitingClientsWidget extends StatefulWidget {
  const AcceptedWaitingClientsWidget({
    super.key,
  });

  @override
  State<AcceptedWaitingClientsWidget> createState() =>
      _AcceptedWaitingClientsWidgetState();
}

class _AcceptedWaitingClientsWidgetState
    extends State<AcceptedWaitingClientsWidget> {
  @override
  void initState() {
    final bloc = BlocProvider.of<SellerAdminBloc>(context);
    bloc.add(GetAdminVisits());

    bloc.scrollController.addListener(() {
      if (bloc.scrollController.position.maxScrollExtent ==
          bloc.scrollController.offset) {
        bloc.add(LoadMoreAdminVisits());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAdminBloc, SellerAdminState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: AppColors.black,
          backgroundColor: AppColors.primaryColor,
          onRefresh: () async {
            return BlocProvider.of<SellerAdminBloc>(context)
                .add(GetAdminVisits());
          },
          child: state.adminVisist != null
              ? state.adminVisist!.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ScreenUtil().setVerticalSpacing(
                            (MediaQuery.of(context).size.height - 56) / 2),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  100.r,
                                ),
                                color: AppColors.primaryColor.withOpacity(0.5)),
                            child: Text(
                              'Пока сегодня нет клиентов',
                              style: Styles.headline4,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Scrollbar(
                      radius: Radius.circular(100.r),
                      thickness: 4,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        itemCount: state.adminVisist!.length + 1,
                        controller: BlocProvider.of<SellerAdminBloc>(context)
                            .scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          if (state.showLoadingVisits) {
                            return const AdminVisitsShimmer();
                          } else if (index < state.adminVisist!.length) {
                            final item = state.adminVisist![index];
                            return AdminVisitsCard(
                              isStored: item!.isStored!,
                              seller: item.seller != null ? item.seller! : null,
                              id: item.id!,
                              fullname: item.seller != null
                                  ? item.seller!.fullname!
                                  : '',
                              dateTime: item.createdAt!,
                              isAccepted: item.seller != null
                                  ? item.isAccepted!
                                  : false,
                              isCanceled: item.seller != null
                                  ? item.isCanceled!
                                  : false,
                              details: item.details!,
                              phoneNumber: item.seller != null
                                  ? item.seller!.phoneNumber!
                                  : '',
                            );
                          } else {
                            return Center(
                                child: state.hasReached
                                    ? Text(
                                        'Больше нет клиентов',
                                        style: Styles.headline4Reg,
                                      )
                                    : Transform.scale(
                                        scale: 0.8,
                                        child: const CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                          strokeWidth: 2,
                                        ),
                                      ));
                          }
                        },
                      ),
                    )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ScreenUtil().setVerticalSpacing(
                        (MediaQuery.of(context).size.height - 56) / 2),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              100.r,
                            ),
                            color: AppColors.primaryColor.withOpacity(0.5)),
                        child: Text(
                          'Пока сегодня нет клиентов',
                          style: Styles.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class StoredClientsWidget extends StatefulWidget {
  const StoredClientsWidget({
    super.key,
  });

  @override
  State<StoredClientsWidget> createState() => _StoredClientsWidgetState();
}

class _StoredClientsWidgetState extends State<StoredClientsWidget> {
  @override
  void initState() {
    BlocProvider.of<SellerAdminBloc>(context).add(GetAdminVisitStored());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAdminBloc, SellerAdminState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: AppColors.black,
          backgroundColor: AppColors.primaryColor,
          onRefresh: () async {
            return BlocProvider.of<SellerAdminBloc>(context)
                .add(GetAdminVisitStored());
          },
          child: state.adminVisitStored != null
              ? state.adminVisitStored!.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ScreenUtil().setVerticalSpacing(
                            (MediaQuery.of(context).size.height - 56) / 2),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  100.r,
                                ),
                                color: AppColors.primaryColor.withOpacity(0.5)),
                            child: Text(
                              'Пока сегодня нет клиентов',
                              style: Styles.headline4,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Scrollbar(
                      radius: Radius.circular(100.r),
                      thickness: 4,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        itemCount: state.adminVisitStored!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = state.adminVisitStored![index];
                          if (state.showLoadingVisitsStored) {
                            return const AdminVisitsShimmer();
                          }
                          return AdminVisitsCard(
                            isStoredClients: true,
                            isStored: item!.isStored!,
                            seller: item.seller != null ? item.seller! : null,
                            id: item.id!,
                            fullname: item.seller != null
                                ? item.seller!.fullname!
                                : '',
                            dateTime: item.createdAt!,
                            isAccepted:
                                item.seller != null ? item.isAccepted! : false,
                            isCanceled:
                                item.seller != null ? item.isCanceled! : false,
                            details: item.details!,
                            phoneNumber: item.seller != null
                                ? item.seller!.phoneNumber!
                                : '',
                          );
                        },
                      ),
                    )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ScreenUtil().setVerticalSpacing(
                        (MediaQuery.of(context).size.height - 56) / 2),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              100.r,
                            ),
                            color: AppColors.primaryColor.withOpacity(0.5)),
                        child: Text(
                          'Пока сегодня нет клиентов',
                          style: Styles.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
