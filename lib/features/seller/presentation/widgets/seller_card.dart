import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerCard extends StatefulWidget {
  final VoidCallback onTapAccept;
  final VoidCallback onTapDecline;
  final VoidCallback? onTapCheckout;
  final VoidCallback? onTapEmpty;
  final String param;
  final int selectedItem;
  final bool isAcceptedFromApi;
  final bool showLoading;
  final int dateSec;
  final int index;
  final String timestamp;
  const SellerCard({
    super.key,
    required this.onTapAccept,
    required this.onTapDecline,
    required this.param,
    required this.dateSec,
    required this.index,
    required this.timestamp,
    this.onTapCheckout,
    this.onTapEmpty,
    required this.selectedItem,
    required this.showLoading,
    required this.isAcceptedFromApi,
  });

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool timeOut = false;
  int time = 20;
  bool isAccepted = false;
  bool isCancelled = false;
  final CountDownController controller = CountDownController();

  @override
  void initState() {
    if (widget.isAcceptedFromApi) {
      timeOut = true;
      setState(() {});
    }
    if (time -
            DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(widget.dateSec))
                .inSeconds >=
        0) {
      time = time -
          DateTime.now()
              .difference(DateTime.fromMillisecondsSinceEpoch(widget.dateSec))
              .inSeconds;
      setState(() {});
    } else {
      timeOut = true;
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20.r,
                    color: AppColors.cardShadow,
                    offset: const Offset(0, 0))
              ]),
          height: 200.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Параметры клиента',
                        style: Styles.headline4,
                      ),
                      ScreenUtil().setVerticalSpacing(6.h),
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          widget.param,
                          style: Styles.headline6,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (!timeOut)
                    CircularCountDownTimer(
                        initialDuration: 0,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onComplete: () {
                          setState(() {
                            timeOut = true;
                          });
                          debugPrint('Countdown Ended');
                        },
                        onChange: (String timeStamp) {
                          // debugPrint('Countdown Changed $timeStamp');
                        },
                        textFormat: CountdownTextFormat.MM_SS,
                        autoStart: true,
                        controller: controller,
                        isReverse: true,
                        textStyle: const TextStyle(fontSize: 12),
                        width: 40.h,
                        height: 40.h,
                        duration: time,
                        fillColor: AppColors.primaryColor,
                        ringColor: AppColors.primaryColor.withOpacity(0.3))
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LongButton(
                    paddingW: 0,
                    buttonName: !(!isAccepted != widget.isAcceptedFromApi)
                        ? "Оформить"
                        : 'Принимать',
                    fontsize: 12,
                    onTap: !(!isAccepted != widget.isAcceptedFromApi)
                        ? widget.onTapCheckout
                        : () {
                            setState(() {
                              isAccepted = true;
                              controller.reset();
                            });

                            widget.onTapAccept();
                          },
                    height: 32,
                    width: 120,
                  ),
                  ScreenUtil().setHorizontalSpacing(10),
                  TransparentLongButton(
                      paddingW: 0,
                      width: 120,
                      height: 32,
                      fontsize: 12,
                      buttonName: !(!isAccepted != widget.isAcceptedFromApi)
                          ? "Пустой"
                          : 'Отменить',
                      onTap: !(!isAccepted != widget.isAcceptedFromApi)
                          ? widget.onTapEmpty
                          : () {
                              setState(() {
                                isCancelled = true;
                                controller.reset();
                              });

                              widget.onTapDecline();
                            })
                ],
              )
            ],
          ),
        ),
        if (timeOut && !isAccepted != widget.isAcceptedFromApi)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 200.h,
            width: double.maxFinite,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                width: 300.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.primaryColor.withOpacity(0.5)),
                child: Text(
                  isCancelled
                      ? "Вы не приняли"
                      : 'Время истекло, чтобы принять или отменить',
                  textAlign: TextAlign.center,
                  style: Styles.headline5M.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        if (widget.showLoading && widget.selectedItem == widget.index)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 200.h,
            width: double.maxFinite,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
          )
      ],
    );
  }
}
// class SellerCard extends StatefulWidget {
//   final int date;
//   final VoidCallback ontapRed;
//   final VoidCallback ontapGreenR;
//   final VoidCallback ontapRedR;
//   final VoidCallback? sharePress;
//   final String shareId;
//   final bool isShared;
//   final VoidCallback ontapGreen;
//   final bool isReady;
//   final int selectedItem;
//   final int index;
//   final String parametrs;
//   final bool showLoading;
//   const SellerCard(
//       {Key? key,
//       required this.ontapRed,
//       this.isShared = false,
//       required this.ontapGreenR,
//       required this.ontapRedR,
//       this.showLoading = false,
//       required this.selectedItem,
//       required this.ontapGreen,
//       required this.parametrs,
//       required this.index,
//       this.sharePress,
//       required this.shareId,
//       this.isReady = false,
//       required this.date})
//       : super(key: key);

//   @override
//   State<SellerCard> createState() => _SellerCardState();
// }

// class _SellerCardState extends State<SellerCard> {
//   bool timeout = false;
//   String time = "";
//   int secodsRemaining = 120;
//   late Timer timer;
//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         if (secodsRemaining > 0) {
//           secodsRemaining--;
//           int inMinutes = secodsRemaining ~/ 60;
//           int inSecods = secodsRemaining % 60;
//           time =
//               "${inMinutes.toString().padLeft(2, "0")}:${inSecods.toString().padLeft(2, "0")}";
//         } else {
//           setState(() {
//             timeout = true;
//             timer.cancel();
//           });
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     debugPrint(widget.parametrs);
//     debugPrint(widget.date.toString());
//     secodsRemaining = secodsRemaining - widget.date;
//     setState(() {});
//     startTimer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedCrossFade(
//       duration: const Duration(milliseconds: 600),
//       crossFadeState: widget.selectedItem == widget.index && widget.isShared
//           ? CrossFadeState.showSecond
//           : CrossFadeState.showFirst,
//       secondChild: Container(
//         margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(10.r),
//             boxShadow: [
//               BoxShadow(
//                   blurRadius: 20.r,
//                   color: AppColors.cardShadow,
//                   offset: const Offset(0, 0))
//             ]),
//         height: 200.h,
//         width: double.maxFinite,
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Параметры клиента',
//                       style: Styles.headline4,
//                     ),
//                     ScreenUtil().setVerticalSpacing(6.h),
//                     SizedBox(
//                       width: 250.w,
//                       child: Text(
//                         widget.parametrs,
//                         style: Styles.headline6,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: true,
//                         maxLines: 3,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 if (widget.shareId.isEmpty)
//                   Material(
//                     color: AppColors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100.r)),
//                     child: IconButton(
//                         enableFeedback: false,
//                         splashRadius: 24.r,
//                         onPressed: widget.sharePress,
//                         icon: Icon(
//                           CupertinoIcons.chevron_up,
//                           size: 24.h,
//                           color: AppColors.black,
//                         )),
//                   )
//               ],
//             ),
//             const Spacer(),
//             BlocBuilder<SellerBloc, SellerState>(
//               builder: (context, state) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                       border: Border(
//                           top: BorderSide(
//                               width: 0, color: AppColors.borderColor))),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 300.w,
//                         child: Material(
//                           type: MaterialType.transparency,
//                           child: SellerTile(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 backgroundColor: AppColors.white,
//                                 context: (context),
//                                 useSafeArea: true,
//                                 isScrollControlled: true,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.r)),
//                                 builder: (context) => ShareSellerList(
//                                   clientInfoIndex: widget.index,
//                                 ),
//                               );
//                             },
//                             title: state.selectedSeller != null
//                                 ? state.selectedSeller!.fullname!
//                                 : "Не выбрали продавца",
//                             subtitle: state.selectedSeller != null
//                                 ? state.selectedSeller!.phoneNumber!
//                                 : "",
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       Material(
//                         color: AppColors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100.r)),
//                         child: IconButton(
//                             enableFeedback: false,
//                             splashRadius: 24.r,
//                             onPressed: state.selectedSeller != null &&
//                                     state.selectedSeller!.id!.isNotEmpty
//                                 ? () {
//                                     BlocProvider.of<SellerBloc>(context)
//                                         .add(ShareClient(
//                                       state.clientInfoList[widget.index]!.id!,
//                                       state.selectedSeller!.id!,
//                                     ));
//                                     Navigator.of(context)
//                                         .pushNamed(AppRoutes.main);

//                                     // HelpShareClient(
//                                     //     state.clientInfoList[index]!.id!,
//                                     //     state.selectedSeller!.id!));

//                                     // Navigator.of(context).pop();
//                                   }
//                                 : null,
//                             icon: Icon(
//                               CupertinoIcons.paperplane,
//                               color: state.selectedSeller != null &&
//                                       state.selectedSeller!.id!.isNotEmpty
//                                   ? AppColors.black
//                                   : AppColors.borderColor,
//                             )),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//       firstChild: BlocBuilder<SellerBloc, SellerState>(
//         builder: (context, state) {
//           return Stack(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
//                 decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(10.r),
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 20.r,
//                           color: AppColors.cardShadow,
//                           offset: const Offset(0, 0))
//                     ]),
//                 height: 164.h,
//                 width: double.maxFinite,
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Параметры клиента',
//                               style: Styles.headline4,
//                             ),
//                             ScreenUtil().setVerticalSpacing(6.h),
//                             SizedBox(
//                               width: 250.w,
//                               child: Text(
//                                 widget.parametrs,
//                                 style: Styles.headline6,
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: true,
//                                 maxLines: 3,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           time,
//                           style:
//                               Styles.headline5M.copyWith(color: AppColors.grey),
//                         ),
//                         const Spacer(),
//                         if (widget.shareId.isEmpty)
//                           Material(
//                             color: AppColors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(100.r)),
//                             child: IconButton(
//                                 enableFeedback: false,
//                                 splashRadius: 24.r,
//                                 onPressed: widget.sharePress,
//                                 icon: Icon(
//                                   CupertinoIcons.chevron_down,
//                                   size: 24.h,
//                                   color: AppColors.black,
//                                 )),
//                           )
//                       ],
//                     ),
//                     const Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         LongButton(
//                           paddingW: 0,
//                           buttonName:
//                               !widget.isReady ? 'Принимать' : 'Оформить',
//                           fontsize: 12,
//                           onTap: !widget.isReady
//                               ? widget.ontapGreen
//                               : widget.ontapGreenR,
//                           height: 32,
//                           width: 120,
//                         ),
//                         ScreenUtil().setHorizontalSpacing(10),
//                         TransparentLongButton(
//                           paddingW: 0,
//                           width: 120,
//                           height: 32,
//                           fontsize: 12,
//                           buttonName: !widget.isReady ? 'Отменить' : 'Пустой',
//                           onTap: !widget.isReady
//                               ? widget.ontapRed
//                               : widget.ontapRedR,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               if (widget.showLoading && widget.selectedItem == widget.index)
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   height: 164.h,
//                   width: double.maxFinite,
//                   child: const Center(
//                     child: CircularProgressIndicator(color: AppColors.white),
//                   ),
//                 )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

/*  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    height: 22.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: !isReady
                            ? AppColors.orange.withOpacity(0.1)
                            : AppColors.green.withOpacity(0.1)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          !isReady ? AppIcons.clock : AppIcons.tick,
                          height: 14.h,
                          width: 14.h,
                          color: !isReady ? AppColors.orange : AppColors.green,
                        ),
                        ScreenUtil().setHorizontalSpacing(2.w),
                        Text(
                          !isReady ? 'В ожидание' : 'Принято',
                          style: Styles.headline5.copyWith(
                              fontSize: 10.sp,
                              color: !isReady ? AppColors.orange : AppColors.green),
                        ),
                      ],
                    ),
                  ) */

                    /*  Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      height: 22.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: !isReady
                              ? AppColors.orange.withOpacity(0.1)
                              : AppColors.green.withOpacity(0.1)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            !isReady ? AppIcons.clock : AppIcons.tick,
                            height: 14.h,
                            width: 14.h,
                            color: !isReady ? AppColors.orange : AppColors.green,
                          ),
                          ScreenUtil().setHorizontalSpacing(2.w),
                          Text(
                            !isReady ? 'В ожидание' : 'Принято',
                            style: Styles.headline5.copyWith(
                                fontSize: 10.sp,
                                color: !isReady ? AppColors.orange : AppColors.green),
                          ),
                        ],
                      ),
                    ) */