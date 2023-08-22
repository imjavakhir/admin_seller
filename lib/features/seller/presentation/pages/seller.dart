import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/pause_button.dart';
import 'package:admin_seller/features/seller/presentation/widgets/seller_card.dart';
import 'package:admin_seller/src/shimmers/seller_card_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final isConnected = false;

  @override
  void initState() {
    BlocProvider.of<SellerBloc>(context).add(GetClientsFromApi());
    BlocProvider.of<SellerBloc>(context).add(const ClientInfoListEvent([]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBarWidget(
          leading: PauseButton(
            onTap: () {
              BlocProvider.of<SellerBloc>(context).add(SavePauseInfo());

              Navigator.of(context).pop();
            },
            isPaused: state.isPaused,
          ),
          title: 'Клиенты',
          actions: [
            IconButton(
                splashRadius: 24.r,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.orders);
                },
                icon: const Icon(
                  CupertinoIcons.bag,
                  color: AppColors.black,
                ))
            // IconButton(
            //     enableFeedback: false,
            //     splashRadius: 24.r,
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(AppRoutes.notification);
            //     },
            //     icon: Badge(
            //       smallSize: 14.h,
            //       largeSize: 14.h,

            //       // label: Text(
            //       //   '1',
            //       //   style: Styles.headline6
            //       //       .copyWith(color: AppColors.white, fontSize: 12.sp),
            //       // ),
            //       child: const Icon(
            //         CupertinoIcons.bell,
            //         color: AppColors.black,
            //       ),
            //     ))
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.black,
          onRefresh: () async {
            return BlocProvider.of<SellerBloc>(context)
                .add(GetClientsFromApi());
          },
          child: state.clientInfoList.isEmpty
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
                          'Пока нет клиентов',
                          style: Styles.headline4,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  controller:
                      BlocProvider.of<SellerBloc>(context).scrollController,
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.clientInfoList.length,
                  itemBuilder: (context, index) {
                    if (state.loadingdata) {
                      return const SellerCardShimmer();
                    }

                    return SellerCard(
                      isAcceptedFromApi:
                          state.clientInfoList[index]!.isAccepted!,
                      showLoading: state.showLoading,
                      selectedItem: state.selectedIndex,
                      timestamp: state.clientInfoList[index]!.sentAt.toString(),
                      index: index,
                      dateSec: state.clientInfoList[index]!.sentAt!,
                      param: state.clientInfoList[index]!.details!,
                      onTapAccept: () {
                        BlocProvider.of<SellerBloc>(context).add(
                            AcceptVisitEvent(state.clientInfoList[index]!.id!));
                      },
                      onTapCheckout: () {
                        Navigator.of(context).pushNamed(AppRoutes.addClient,
                            arguments: state.clientInfoList[index]);
                        debugPrint(state.clientInfoList[index]!.details!);
                      },
                      onTapEmpty: () {
                        debugPrint('oustiy');
                        // final bool reportStatus =
                        //     state.clientInfoList[index]!.shared_seller !=
                        //                 null &&
                        //             state.clientInfoList[index]!.shared_seller!
                        //                 .isNotEmpty
                        //         ? true
                        //         : false;

                        // final String? reporShareId =
                        //     state.clientInfoList[index]!.shared_seller !=
                        //                 null &&
                        //             state.clientInfoList[index]!.shared_seller!
                        //                 .isNotEmpty
                        //         ? state.clientInfoList[index]!.shared_seller
                        //         : '';

                        // debugPrint("${reporShareId!}-------reportsharedid");
                        // debugPrint("$reportStatus-------reportstatus");
                        BlocProvider.of<SellerBloc>(context).add(ClearVisits(
                            index,
                            state.clientInfoList[index]!.id!,
                            false,
                            ''));
                        // debugPrint('${reportStatus}ssssssss');
                      },
                      onTapDecline: () {
                        BlocProvider.of<SellerBloc>(context).add(
                            DeclineVisitEvent(
                                state.clientInfoList[index]!.id!));
                      },
                    );
                    // return SellerCard(
                    //   date: DateTime.now()
                    //       .difference(DateTime.fromMillisecondsSinceEpoch(
                    //         state.clientInfoList[index]!.sentAt!,
                    //       ))
                    //       .inSeconds,
                    //   ontapGreen: () {},
                    //   ontapRed: () {},
                    //   isShared: state.isShared,
                    //   shareId:
                    //       /* state.clientInfoList[index]!.shared_seller != null
                    //           ? state.clientInfoList[index]!.shared_seller!
                    //           :  */
                    //       '',
                    //   sharePress: () {
                    //     BlocProvider.of<SellerBloc>(context)
                    //         .add(ShareClientBUtton(index));
                    //   },
                    //   selectedItem: state.selectedIndex,
                    //   index: index,
                    //   showLoading: state.showLoading,
                    //   parametrs: state.clientInfoList[index]!.details!,
                    //   ontapGreenR: () {
                    //     Navigator.of(context).pushNamed(AppRoutes.addClient,
                    //         arguments: state.clientInfoList[index]);
                    //     debugPrint(state.clientInfoList[index]!.details!);
                    //     debugPrint(state.clientInfoList[index]!.details!);
                    //   },
                    //   ontapRedR: () async {
                    //     // final bool reportStatus =
                    //     //     state.clientInfoList[index]!.shared_seller !=
                    //     //                 null &&
                    //     //             state.clientInfoList[index]!.shared_seller!
                    //     //                 .isNotEmpty
                    //     //         ? true
                    //     //         : false;

                    //     // final String? reporShareId =
                    //     //     state.clientInfoList[index]!.shared_seller !=
                    //     //                 null &&
                    //     //             state.clientInfoList[index]!.shared_seller!
                    //     //                 .isNotEmpty
                    //     //         ? state.clientInfoList[index]!.shared_seller
                    //     //         : '';

                    //     // debugPrint("${reporShareId!}-------reportsharedid");
                    //     // debugPrint("$reportStatus-------reportstatus");
                    //     // BlocProvider.of<SellerBloc>(context).add(ClearVisits(
                    //     //     index,
                    //     //     state.clientInfoList[index]!.id!,
                    //     //     reportStatus,
                    //     //     reporShareId));
                    //     // debugPrint('${reportStatus}ssssssss');

                    //     // _sellerRepository
                    //     // .sendEmptySelling(id: state.clientInfoList[index]!.id!);
                    //   },
                    // );
                  }),
        ),
        // bottomSheet: SizedBox(
        //   height: 100.h,
        //   child: LongButton(
        //       buttonName: 'semnt',
        //       onTap: () {
        //         BlocProvider.of<SellerBloc>(context).add(ShareClient(
        //             state.clientInfoList[0]!.id!, '648ac88057999f9229d76284'));
        //       }),
        // ),
      );
    });
  }
}
