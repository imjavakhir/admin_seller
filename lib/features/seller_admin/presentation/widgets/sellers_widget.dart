import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller_admin/presentation/blocs/seller_admin_bloc.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/src/shimmers/sellertile_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerListWidget extends StatefulWidget {
  const SellerListWidget({
    super.key,
  });

  @override
  State<SellerListWidget> createState() => _SellerListWidgetState();
}

class _SellerListWidgetState extends State<SellerListWidget> {
  @override
  void initState() {
    BlocProvider.of<SellerAdminBloc>(context).add(GetSellerListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAdminBloc, SellerAdminState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 1.0,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) => Column(
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
                child: state.sellerList!.isEmpty
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
                              color: AppColors.primaryColor.withOpacity(0.5)),
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
                        itemCount: state.sellerList!.length,
                        itemBuilder: (context, index) {
                          if (state.showLoading) {
                            return const SellersShimmer();
                          }
                          return SellerTile(
                            onTap: () {
                              BlocProvider.of<SellerAdminBloc>(context).add(
                                  SelectedSellerEvent(
                                      selectedSeller:
                                          state.sellerList![index]!));
                              Navigator.of(context).pop();
                            },
                            title: state.sellerList![index]!.fullname!,
                            subtitle: state.sellerList![index]!.phoneNumber!,
                          );
                        }),
              )
            ],
          ),
        );
      },
    );
  }
}
