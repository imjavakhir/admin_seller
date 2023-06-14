// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/seller_card.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool _isReady = false;
bool isPaused = false;

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  void initState() {
    ApiService().getSearchedCustomer(searchNumber: '77');
    if (socket == null) {
      SocketIOService().connectSocket();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Клиенты',
        actions: [
          StatefulBuilder(builder: (context, setState) {
            return IconButton(
              splashRadius: 24.r,
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                });
              },
              icon: SvgPicture.asset(
                isPaused ? AppIcons.userTick : AppIcons.userRemove,
                color: isPaused ? AppColors.green : AppColors.red,
                height: 32.h,
                width: 32.w,
              ),
            );
          })
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.black,
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 3000));
        },
        child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    ScreenUtil().setVerticalSpacing(10.h),
                    StatefulBuilder(builder: (context, setState) {
                      return SellerCard(
                        ontapRed: () async {},
                        ontapGreenR: () {
                          Navigator.of(context).pushNamed(AppRoutes.addClient);
                        },
                        ontapRedR: () async {
                          ApiService().sendEmptySelling();
                        },
                        ontapGreen: () {
                          setState(() {
                            _isReady = true;
                          });
                        },
                        isReady: _isReady,
                      );
                    }),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
