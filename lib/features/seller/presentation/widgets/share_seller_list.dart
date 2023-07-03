import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/src/shimmers/sellertile_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareSellerList extends StatefulWidget {
  final VoidCallback? onSend;
  const ShareSellerList({
    super.key,
    this.onSend,
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
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 1.0,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) => Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScreenUtil().setVerticalSpacing(24),
                  Center(
                    child: Text(
                      'Выберите продавца',
                      style: Styles.headline2,
                    ),
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
                                },
                                title: state.sellerList[index]!.fullname!,
                                subtitle: state.sellerList[index]!.phoneNumber!,
                              );
                            }),
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 0, color: AppColors.borderColor))),
                    child: SellerTile(
                      title: state.selectedSeller != null
                          ? state.selectedSeller!.fullname!
                          : "Не выбрали продавца",
                      subtitle: state.selectedSeller != null
                          ? state.selectedSeller!.phoneNumber!
                          : "",
                      trailing: Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r)),
                        child: IconButton(
                            disabledColor: AppColors.borderColor,
                            splashRadius: 24.r,
                            onPressed: widget.onSend,
                            icon: const Icon(
                              CupertinoIcons.paperplane,
                              color: AppColors.black,
                            )),
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
