import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller_admin/presentation/pages/accept_clients.dart';
import 'package:admin_seller/features/seller_admin/presentation/pages/stored_clients.dart';
import 'package:flutter/cupertino.dart';

class AdminClientsPage extends StatefulWidget {
  const AdminClientsPage({super.key});

  @override
  State<AdminClientsPage> createState() => _AdminClientsPageState();
}

class _AdminClientsPageState extends State<AdminClientsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBarWidget(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: AppColors.black,
              ),
              splashRadius: 24.r,
            ),
            title: 'Сегодняшние клиенты',
          ),
          body: Column(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.textfieldBackground),
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(10.r),
                  enableFeedback: false,
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white),
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Text(
                        'Все',
                        style: Styles.headline5M,
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Новые',
                      style: Styles.headline5M,
                    )),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      AcceptedWaitingClientsWidget(),
                      StoredClientsWidget()
                    ]),
              )
            ],
          )),
    );
  }
}
