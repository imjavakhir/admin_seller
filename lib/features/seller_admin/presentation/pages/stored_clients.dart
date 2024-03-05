import 'package:admin_seller/app_const/app_exports.dart';

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
                            seller: item.seller,
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
