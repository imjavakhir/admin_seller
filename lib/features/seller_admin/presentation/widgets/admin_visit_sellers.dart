import 'package:admin_seller/app_const/app_exports.dart';

class AdminSellerVisitSellersWidget extends StatefulWidget {
  final String id;
  final bool isStoredClients;
  const AdminSellerVisitSellersWidget({
    super.key,
    required this.id,
    this.isStoredClients = false,
  });

  @override
  State<AdminSellerVisitSellersWidget> createState() =>
      _AdminSellerVisitSellersWidgetState();
}

class _AdminSellerVisitSellersWidgetState
    extends State<AdminSellerVisitSellersWidget> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    BlocProvider.of<SellerAdminBloc>(context)
        .add(GetAdminVisitSellers(widget.id));
    BlocProvider.of<SellerAdminBloc>(context).add(GetSellerListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAdminBloc, SellerAdminState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 1,
          expand: false,
          builder: (context, scrollController) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ScreenUtil().setVerticalSpacing(24),
                Center(
                  child: Text(
                    state.pageIndex == 0
                        ? 'Уведомленные продавцы'
                        : 'Онлайн продавцы',
                    style: Styles.headline2,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                const Divider(
                  color: AppColors.grey,
                  height: 0,
                ),
                Flexible(
                  child: PageView(
                    onPageChanged: (value) {
                      BlocProvider.of<SellerAdminBloc>(context)
                          .add(ChangePageView(value));
                    },
                    controller: _pageController,
                    children: [
                      //////// visit sellers
                      /////
                      /////
                      state.adminVisitSellers != null
                          ? state.adminVisitSellers!.isEmpty
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
                                        color: AppColors.primaryColor
                                            .withOpacity(0.5)),
                                    child: Text(
                                      'Пока никто не видел это',
                                      style: Styles.headline4,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  controller: scrollController,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  shrinkWrap: true,
                                  itemCount: state.adminVisitSellers!.length,
                                  itemBuilder: (context, index) {
                                    if (state.showLoadingVisitSellers) {
                                      return const SellersShimmer();
                                    }
                                    return SellerTile(
                                      title: state
                                          .adminVisitSellers![index]!.fullname!,
                                      subtitle: state.adminVisitSellers![index]!
                                          .phoneNumber!,
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (!state.adminVisitSellers![index]!
                                                  .isAccepted! &&
                                              !state.adminVisitSellers![index]!
                                                  .isCanceled! &&
                                              !state.adminVisitSellers![index]!
                                                  .isTimeout!)
                                            SvgPicture.asset(
                                              AppIcons.clock,
                                              color: AppColors.orange,
                                              height: 24.h,
                                              width: 24.h,
                                            ),
                                          if (state.adminVisitSellers![index]!
                                              .isAccepted!)
                                            SvgPicture.asset(
                                              AppIcons.tick,
                                              color: AppColors.green,
                                              height: 24.h,
                                              width: 24.h,
                                            ),
                                          if (state.adminVisitSellers![index]!
                                                  .isCanceled! ||
                                              state.adminVisitSellers![index]!
                                                  .isTimeout!)
                                            SvgPicture.asset(
                                              AppIcons.closeCircle,
                                              color: AppColors.red,
                                              height: 24.h,
                                              width: 24.h,
                                            ),
                                        ],
                                      ),
                                    );
                                  })
                          : Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 16.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      100.r,
                                    ),
                                    color: AppColors.primaryColor
                                        .withOpacity(0.5)),
                                child: Text(
                                  'Пока никто не видел это',
                                  style: Styles.headline4,
                                ),
                              ),
                            ),
                      //////// sellerList
                      /////
                      /////
                      if (widget.isStoredClients)
                        state.sellerList != null
                            ? state.sellerList!.isEmpty
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
                                          color: AppColors.primaryColor
                                              .withOpacity(0.5)),
                                      child: Text(
                                        'Пока нет онлайн продавцов',
                                        style: Styles.headline4,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    controller: scrollController,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    shrinkWrap: true,
                                    itemCount: state.sellerList!.length,
                                    itemBuilder: (context, index) {
                                      if (state.showLoading) {
                                        return const SellersShimmer();
                                      }
                                      return SellerTile(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 24.w,
                                                              vertical: 12.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ScreenUtil()
                                                              .setVerticalSpacing(
                                                                  10.h),
                                                          Text(
                                                            'Xотите переадресовать клиента?',
                                                            style: Styles
                                                                .headline3,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          ScreenUtil()
                                                              .setVerticalSpacing(
                                                                  20.h),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColors
                                                                        .blue),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        24.w),
                                                            height: 75.h,
                                                            width: 75.h,
                                                            child: Text(
                                                              state
                                                                  .sellerList![
                                                                      index]!
                                                                  .fullname!
                                                                  .characters
                                                                  .first,
                                                              style: Styles
                                                                  .headline2
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .white),
                                                            ),
                                                          ),
                                                          ScreenUtil()
                                                              .setVerticalSpacing(
                                                                  15.h),
                                                          Text(
                                                            state
                                                                .sellerList![
                                                                    index]!
                                                                .fullname!,
                                                            style: Styles
                                                                .headline3M,
                                                          ),
                                                          Text(
                                                            "+998${state.sellerList![index]!.phoneNumber!}",
                                                            style: Styles
                                                                .headline4,
                                                          ),
                                                          ScreenUtil()
                                                              .setVerticalSpacing(
                                                                  20),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              LongButton(
                                                                paddingW: 0,
                                                                buttonName:
                                                                    'Да',
                                                                fontsize: 12,
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  SocketIOService()
                                                                      .sendnotificationAck(
                                                                          sellerId: state
                                                                              .sellerList![
                                                                                  index]!
                                                                              .id!,
                                                                          clientId: widget
                                                                              .id,
                                                                          receiveAckData:
                                                                              (value) {
                                                                            debugPrint(value.toString());
                                                                          });
                                                                  BlocProvider.of<
                                                                              SellerAdminBloc>(
                                                                          context)
                                                                      .add(
                                                                          GetAdminVisitStored());
                                                                  BlocProvider.of<
                                                                              SellerAdminBloc>(
                                                                          context)
                                                                      .add(GetAdminVisitSellers(
                                                                          widget
                                                                              .id));
                                                                },
                                                                height: 32,
                                                                width: 96,
                                                              ),
                                                              ScreenUtil()
                                                                  .setHorizontalSpacing(
                                                                      20),
                                                              TransparentLongButton(
                                                                paddingW: 0,
                                                                width: 96,
                                                                height: 32,
                                                                fontsize: 12,
                                                                buttonName:
                                                                    'Нет',
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                          ScreenUtil()
                                                              .setVerticalSpacing(
                                                                  10),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        title:
                                            state.sellerList![index]!.fullname!,
                                        subtitle: state
                                            .sellerList![index]!.phoneNumber!,
                                      );
                                    })
                            : Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 16.h),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 12.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      color: AppColors.primaryColor
                                          .withOpacity(0.5)),
                                  child: Text(
                                    'Пока нет онлайн продавцов',
                                    style: Styles.headline4,
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),
              ]),
        );
      },
    );
  }
}




  // onTap: widget.isStoredClients
  //                                         ? () {
  //                                             Navigator.of(context).pop();
  //                                             showDialog(
  //                                                 context: context,
  //                                                 builder: (context) => Dialog(
  //                                                       backgroundColor:
  //                                                           AppColors.white,
  //                                                       shape: RoundedRectangleBorder(
  //                                                           borderRadius:
  //                                                               BorderRadius
  //                                                                   .circular(
  //                                                                       10.r)),
  //                                                       child: Padding(
  //                                                         padding: EdgeInsets
  //                                                             .symmetric(
  //                                                                 horizontal:
  //                                                                     24.w,
  //                                                                 vertical:
  //                                                                     12.h),
  //                                                         child: Column(
  //                                                           crossAxisAlignment:
  //                                                               CrossAxisAlignment
  //                                                                   .center,
  //                                                           mainAxisSize:
  //                                                               MainAxisSize
  //                                                                   .min,
  //                                                           children: [
  //                                                             ScreenUtil()
  //                                                                 .setVerticalSpacing(
  //                                                                     10.h),
  //                                                             Text(
  //                                                               'Xотите переадресовать клиента?',
  //                                                               style: Styles
  //                                                                   .headline3,
  //                                                               textAlign:
  //                                                                   TextAlign
  //                                                                       .center,
  //                                                             ),
  //                                                             ScreenUtil()
  //                                                                 .setVerticalSpacing(
  //                                                                     20.h),
  //                                                             Container(
  //                                                               alignment:
  //                                                                   Alignment
  //                                                                       .center,
  //                                                               decoration: const BoxDecoration(
  //                                                                   shape: BoxShape
  //                                                                       .circle,
  //                                                                   color: AppColors
  //                                                                       .blue),
  //                                                               margin: EdgeInsets
  //                                                                   .symmetric(
  //                                                                       horizontal:
  //                                                                           24.w),
  //                                                               height: 75.h,
  //                                                               width: 75.h,
  //                                                               child: Text(
  //                                                                 state
  //                                                                     .adminVisitSellers![
  //                                                                         index]!
  //                                                                     .fullname!
  //                                                                     .characters
  //                                                                     .first,
  //                                                                 style: Styles
  //                                                                     .headline2
  //                                                                     .copyWith(
  //                                                                         color:
  //                                                                             AppColors.white),
  //                                                               ),
  //                                                             ),
  //                                                             ScreenUtil()
  //                                                                 .setVerticalSpacing(
  //                                                                     15.h),
  //                                                             Text(
  //                                                               state
  //                                                                   .adminVisitSellers![
  //                                                                       index]!
  //                                                                   .fullname!,
  //                                                               style: Styles
  //                                                                   .headline3M,
  //                                                             ),
  //                                                             Text(
  //                                                               "+998${state.adminVisitSellers![index]!.phoneNumber!}",
  //                                                               style: Styles
  //                                                                   .headline4,
  //                                                             ),
  //                                                             ScreenUtil()
  //                                                                 .setVerticalSpacing(
  //                                                                     20),
  //                                                             Row(
  //                                                               mainAxisAlignment:
  //                                                                   MainAxisAlignment
  //                                                                       .center,
  //                                                               children: [
  //                                                                 LongButton(
  //                                                                   paddingW: 0,
  //                                                                   buttonName:
  //                                                                       'Да',
  //                                                                   fontsize:
  //                                                                       12,
  //                                                                   onTap: () {
  //                                                                     Navigator.of(
  //                                                                             context)
  //                                                                         .pop();
  //                                                                     SocketIOService().sendnotificationAck(
  //                                                                         sellerId: state.adminVisitSellers![index]!.id!,
  //                                                                         clientId: widget.id,
  //                                                                         receiveAckData: (value) {
  //                                                                           debugPrint(value.toString());
  //                                                                           // Navigator.of(context).pop();
  //                                                                         });
  //                                                                     BlocProvider.of<SellerAdminBloc>(
  //                                                                             context)
  //                                                                         .add(
  //                                                                             GetAdminVisitStored());
  //                                                                     BlocProvider.of<SellerAdminBloc>(
  //                                                                             context)
  //                                                                         .add(GetAdminVisitSellers(
  //                                                                             widget.id));
  //                                                                   },
  //                                                                   height: 32,
  //                                                                   width: 96,
  //                                                                 ),
  //                                                                 ScreenUtil()
  //                                                                     .setHorizontalSpacing(
  //                                                                         20),
  //                                                                 TransparentLongButton(
  //                                                                   paddingW: 0,
  //                                                                   width: 96,
  //                                                                   height: 32,
  //                                                                   fontsize:
  //                                                                       12,
  //                                                                   buttonName:
  //                                                                       'Нет',
  //                                                                   onTap: () {
  //                                                                     Navigator.of(
  //                                                                             context)
  //                                                                         .pop();
  //                                                                   },
  //                                                                 )
  //                                                               ],
  //                                                             ),
  //                                                             ScreenUtil()
  //                                                                 .setVerticalSpacing(
  //                                                                     10),
  //                                                           ],
  //                                                         ),
  //                                                       ),
  //                                                     ));
  //                                           }
  //                                         : null,