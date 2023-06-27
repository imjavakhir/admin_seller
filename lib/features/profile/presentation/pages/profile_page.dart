// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:admin_seller/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:admin_seller/features/profile/presentation/widgets/online_tile.dart';
import 'package:admin_seller/features/profile/presentation/widgets/profile_tile.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetUserOnlineModelEvent());
    BlocProvider.of<ProfileBloc>(context).add(GetUserRating());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final hiveUserBox = Hive.box<UserModelHive>('User');
        final user = hiveUserBox.values.toList().cast<UserModelHive>();
        return Scaffold(
          appBar: const AppBarWidget(
            title: 'Профиль',
          ),
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.black,
            onRefresh: () async {
              return BlocProvider.of<ProfileBloc>(context)
                  .add(GetUserOnlineModelEvent());
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenUtil().setVerticalSpacing(10.h),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.blue),
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        height: 75.h,
                        width: 75.h,
                        child: Text(
                          user.first.fullName.characters.first,
                          style:
                              Styles.headline2.copyWith(color: AppColors.white),
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(15.h),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            user.first.fullName,
                            style: Styles.headline2,
                          )),
                      ScreenUtil().setVerticalSpacing(24.h),
                      const Divider(
                        height: 0,
                        color: AppColors.grey,
                      ),
                      ProfileTile(
                        title: 'Филиал',
                        subtitle: user.first.branch,
                      ),
                      ProfileTile(
                        title: 'Должность',
                        subtitle: user.first.type == 'seller_admin'
                            ? 'Админ Продавец'
                            : 'Продавец',
                      ),
                      if (user.first.type == 'seller')
                        ProfileTile(
                          title: 'Рейтинг',
                          subtitle: '${state.rating} балл',
                        ),
                      if (user.first.type == 'seller')
                        OnlineTile(
                          isVerified: state.isVerified,
                          value: state.switchValue,
                          onChanged: !state.isVerified
                              ? (value) {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(OnlineChangedEvent(value));
                                }
                              : null,
                        ),
                      const Spacer(),
                      TransparentLongButton(
                          buttonName: 'Выйти',
                          onTap: () async {
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppRoutes.auth, (route) => false);
                            await HiveDataSource().clearUserDetails();
                            await AuthLocalDataSource().removeLogToken();
                            SocketIOService().disconnectSocket();
                            // await AuthLocalDataSource().removeFcmToken();
                          }),
                      ScreenUtil().setVerticalSpacing(30.h)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
