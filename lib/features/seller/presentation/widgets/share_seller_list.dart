import 'package:admin_seller/app_const/app_exports.dart';

class ShareSellerList extends StatefulWidget {
  final int clientInfoIndex;

  const ShareSellerList({
    super.key,
    required this.clientInfoIndex,
  });

  @override
  State<ShareSellerList> createState() => _ShareSellerListState();
}

class _ShareSellerListState extends State<ShareSellerList> {
  @override
  void initState() {
    BlocProvider.of<SellerBloc>(context).add(GetSellersEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 1,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScreenUtil().setVerticalSpacing(24),
                  Center(
                    child: Text(
                      'Выберите продавца',
                      style: Styles.headline2,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  const Divider(
                    color: AppColors.grey,
                    height: 0,
                  ),
                  Flexible(
                    child: state.sellerList.isEmpty
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 16.h),
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    100.r,
                                  ),
                                  color:
                                      AppColors.primaryColor.withOpacity(0.5)),
                              child: Text(
                                'Пока нет онлайн продавцов',
                                style: Styles.headline4,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shrinkWrap: true,
                            itemCount: state.sellerList.length,
                            itemBuilder: (context, index) {
                              if (state.showLoadingBottomSheet) {
                                return const SellersShimmer();
                              }

                              return SellerTile(
                                onTap: () {
                                  BlocProvider.of<SellerBloc>(context).add(
                                      ShareSelectedSeller(
                                          selectedSeller:
                                              state.sellerList[index]!));
                                  Navigator.of(
                                    context,
                                  ).pop();
                                },
                                title: state.sellerList[index]!.fullname!,
                                subtitle: state.sellerList[index]!.phoneNumber!,
                              );
                            }),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
