// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin_seller/app_const/app_exports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final hiveUserBox = Hive.box<UserModelHive>('User');
  late List<UserModelHive> user;
  @override
  void initState() {
    user = hiveUserBox.values.toList().cast<UserModelHive>();
    if (user.first.type != 'seller_admin') {
      BlocProvider.of<ProfileBloc>(context).add(GetUserOnlineModelEvent());
    }

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
        return Scaffold(
          appBar: const AppBarWidget(
            title: 'Профиль',
          ),
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.black,
            onRefresh: () async {
              if (user.first.type != 'seller_admin') {
                BlocProvider.of<ProfileBloc>(context)
                    .add(GetUserOnlineModelEvent());
              }
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
                      if (user.first.type != 'seller_admin')
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              "+998${state.phoneNumber}",
                              style: Styles.headline4,
                            )),
                      ScreenUtil().setVerticalSpacing(24.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: const Divider(
                          height: 0,
                          color: AppColors.grey,
                        ),
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
                        ProfileTile(
                          title: 'Баланс',
                          subtitle: '${state.balance} сум',
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
                            await AuthLocalDataSource().removeSellingToken();
                            final token =
                                await AuthLocalDataSource().getLogToken();
                            debugPrint(token);

                            if (user.first.type == 'seller') {
                              BlocProvider.of<SellerBloc>(context)
                                  .add(DisconnectSocket());
                            }
                            if (user.first.type == 'seller_admin') {
                              SocketIOService().disconnectSocket();
                              isConnected = false;
                              setState(() {});
                            }
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
