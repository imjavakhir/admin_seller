// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:admin_seller/features/main_feature/presentation/blocs/main_feature_bloc.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/online_tile.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/profile_tile.dart';
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
  bool? isAdmin;
  checkUser() {
    final user = HiveDataSource().box.values.toList().first;
    print(user.type);

    if (user.type == 'seller_admin') {
      setState(() {
        isAdmin = true;
      });
    } else {
      isAdmin = false;
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainFeatureBloc(),
      child: BlocBuilder<MainFeatureBloc, MainFeatureState>(
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
              onRefresh: () {
                return Future.delayed(const Duration(milliseconds: 3000));
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
                            style: Styles.headline2
                                .copyWith(color: AppColors.white),
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
                        if (!isAdmin!)
                          OnlineTile(
                            value: state.switchValue,
                            onChanged: (value) {
                              BlocProvider.of<MainFeatureBloc>(context)
                                  .add(OnlineChangedEvent(value));
                            },
                          ),
                        const Spacer(),
                        TransparentLongButton(
                            buttonName: 'Выйти',
                            onTap: () async {
                              Navigator.of(context).pushNamed(AppRoutes.auth);
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
      ),
    );
  }
}
