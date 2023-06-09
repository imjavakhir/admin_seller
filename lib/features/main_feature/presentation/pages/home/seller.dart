// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/seller_card.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/widgets/appbar_widget.dart';

bool _isReady = false;

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  void initState() {
    SocketIOService().connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Клиенты'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(10.h),
            StatefulBuilder(builder: (context, setState) {
              return SellerCard(
                ontapRed: () {},
                ontapGreenR: () {
                  Navigator.of(context).pushNamed(AppRoutes.addClient);
                },
                ontapRedR: () {},
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
      ),
    );
  }
}
