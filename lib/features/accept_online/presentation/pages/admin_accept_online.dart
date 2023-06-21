import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/accept_online/presentation/blocs/blocs/accept_online_bloc.dart';
import 'package:admin_seller/features/accept_online/presentation/widgets/accept_widget.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:admin_seller/src/shimmers/accept_widget_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/ui_tools/ui_tools.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptOnlineAccept extends StatelessWidget {
  const AcceptOnlineAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcceptOnlineBloc, AcceptOnlineState>(
      builder: (context, state) {
        return RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.black,
          onRefresh: () async {
            return BlocProvider.of<AcceptOnlineBloc>(context)
                .add(GetUsersUnverifiedEvent());
          },
          child: Scaffold(
            appBar: const AppBarWidget(title: 'Подтверждение'),
            body: FutureBuilder(
              future: ApiService().getAllUnverified(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const AcceptWidgetShimmer();
                      });
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => AcceptWidget(
                        fullname: snapshot.data![index]!.fullname!,
                        phoneNumber:
                            '+998${snapshot.data![index]!.phoneNumber!}',
                        onTapTick: () {
                          BlocProvider.of<AcceptOnlineBloc>(context)
                              .add(AcceptUserEvent(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                              UITools.customSnackBar(title: 'Success'));
                        },
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'В настоящее время нет запросов на подтверждение',
                        textAlign: TextAlign.center,
                        style: Styles.headline2,
                      ),
                    ));
                  }
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
