import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/accept_online/presentation/widgets/accept_widget.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class AcceptOnlineAccept extends StatelessWidget {
  const AcceptOnlineAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Подтверждение'),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.black,
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 3000));
        },
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                AcceptWidget(
                    fullname: 'Javoxir',
                    phoneNumber: '+998909336272',
                    onTapTick: () {},
                    onTapClose: () {}),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
