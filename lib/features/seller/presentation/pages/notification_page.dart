import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/widgets/seller_nofication_card.dart';
import 'package:flutter/cupertino.dart';

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
                fullName: state.helpClients[index]!.fullname != null
                    ? state.helpClients[index]!.fullname!
                    : '',
              );
            },
          ),
        );
      },
    );
  }
}
