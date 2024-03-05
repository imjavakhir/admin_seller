import 'package:admin_seller/app_const/app_exports.dart';

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
                              seller: item.seller,
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
                            return state.adminVisist!.length > 9
                                ? Center(
                                    child: state.hasReached
                                        ? Text(
                                            'Больше нет клиентов',
                                            style: Styles.headline4Reg,
                                          )
                                        : Transform.scale(
                                            scale: 0.8,
                                            child:
                                                const CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                              strokeWidth: 2,
                                            ),
                                          ))
                                : const SizedBox();
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
