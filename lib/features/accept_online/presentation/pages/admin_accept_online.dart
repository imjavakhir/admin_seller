import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/accept_online/presentation/blocs/blocs/accept_online_bloc.dart';
import 'package:admin_seller/features/accept_online/presentation/widgets/accept_widget.dart';
import 'package:admin_seller/src/shimmers/accept_widget_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptOnlineAccept extends StatefulWidget {
  const AcceptOnlineAccept({super.key});

  @override
  State<AcceptOnlineAccept> createState() => _AcceptOnlineAcceptState();
}

class _AcceptOnlineAcceptState extends State<AcceptOnlineAccept> {
  @override
  void initState() {
    BlocProvider.of<AcceptOnlineBloc>(context).add(GetUsersUnverifiedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcceptOnlineBloc, AcceptOnlineState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarWidget(title: 'Подтверждение'),
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.black,
            onRefresh: () async {
              return BlocProvider.of<AcceptOnlineBloc>(context)
                  .add(GetUsersUnverifiedEvent());
            },
            child: BlocBuilder<AcceptOnlineBloc, AcceptOnlineState>(
                builder: (context, state) {
              if (state is AcceptOnlineStateLoading) {
                return ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const AcceptWidgetShimmer();
                  },
                );
              } else if (state is AcceptOnlineStateLoaded) {
                if (state.userUnverifiedList.isNotEmpty) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.userUnverifiedList.length,
                    itemBuilder: (context, index) => AcceptWidget(
                      isOnline: state.userUnverifiedList[index]!.isOnline!,
                      isVerfied: state.userUnverifiedList[index]!.isVerified!,
                      // selectedItem: state.selectedItem,
                      // index: index,
                      // isLoading: state.loading,
                      fullname:
                          state.userUnverifiedList[index]!.user!.fullname!,
                      phoneNumber:
                          '+998${state.userUnverifiedList[index]!.user!.phoneNumber}',
                      onTapTick: () {
                        BlocProvider.of<AcceptOnlineBloc>(context).add(
                            AcceptUserEvent(
                                state.userUnverifiedList[index]!.user!.id!,
                                index));
                      },
                    ),
                  );
                } else {
                  return ListView(
                    children: [
                      ScreenUtil().setVerticalSpacing(
                          (MediaQuery.of(context).size.height - 56) / 2),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                100.r,
                              ),
                              color: AppColors.primaryColor.withOpacity(0.5)),
                          child: Text(
                            'Пока нет запросов',
                            style: Styles.headline4,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return const SizedBox();
            }),
          ),
        );
      },
    );
  }
}
