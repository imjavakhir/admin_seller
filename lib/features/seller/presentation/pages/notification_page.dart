import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/seller_nofication_card.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<SellerBloc>(context).add(const HelpNotifications([]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            title: 'Уведомления',
            leading: IconButton(
                enableFeedback: false,
                splashRadius: 24.r,
                iconSize: 24.h,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  CupertinoIcons.chevron_left,
                  color: AppColors.black,
                )),
          ),
          body: ListView.builder(
            itemCount: state.helpClients.length,
            itemBuilder: (context, index) {
              return SellerNotificationCard(
                onTapRed: () {},
                onTapGreen: () {
                  BlocProvider.of<SellerBloc>(context).add(AcceptNotifEvent(
                      state.helpClients[index]!.notification!.id!,
                      state.helpClients[index]!.sharedSeller!.id!));
                },
                params: state.helpClients[index]!.notification!.details != null
                    ? state.helpClients[index]!.notification!.details!
                    : '',
                fullName:
                    state.helpClients[index]!.sharedSeller!.fullname != null
                        ? state.helpClients[index]!.sharedSeller!.fullname!
                        : '',
              );
            },
          ),
        );
      },
    );
  }
}
