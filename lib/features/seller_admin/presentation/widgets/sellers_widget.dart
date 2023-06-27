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
        return Column(
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
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shrinkWrap: true,
                  itemCount: state.sellerList!.length,
                  itemBuilder: (context, index) {
                    if (state.sellerList!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        child: Center(
                          child: Text(
                            'Пока нет онлайн продавцов',
                            style: Styles.headline2,
                          ),
                        ),
                      );
                    }
                    if (state.showLoading) {
                      return const SellersShimmer();
                    }
                    return SellerTile(
                      onTap: () {
                        BlocProvider.of<SellerAdminBloc>(context).add(
                            SelectedSellerEvent(
                                selectedSeller: state.sellerList![index]!));
                        Navigator.of(context).pop();
                      },
                      title: state.sellerList![index]!.fullname!,
                      subtitle: state.sellerList![index]!.phoneNumber!,
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}
