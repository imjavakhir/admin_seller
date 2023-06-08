import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/features/main_feature/presentation/blocs/main_feature_bloc.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/home/admin_seller.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/home/seller.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  final bool isAdmin;
  const MainPage({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainFeatureBloc(),
      child: BlocBuilder<MainFeatureBloc, MainFeatureState>(
        builder: (context, state) {
          return Scaffold(
            body: isAdmin
                ? _pagesAdmin[state.selectedIndex]
                : _pagesSeller[state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.selectedIndex,
                onTap: (value) {
                  BlocProvider.of<MainFeatureBloc>(context)
                      .add(OnPageChangedEvent(selectedIndex: value));
                },
                type: BottomNavigationBarType.fixed,
                enableFeedback: false,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                items: List.generate(
                    AppIcons.bottomNavigationItems.length,
                    (index) => BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          AppIcons.bottomNavigationItems.values
                              .elementAt(index)['inactive'],
                          width: 28.h,
                          height: 28.h,
                          color: AppColors.primaryColor,
                        ),
                        label: AppIcons.bottomNavigationItems.keys
                            .elementAt(index),
                        icon: SvgPicture.asset(
                          AppIcons.bottomNavigationItems.values
                              .elementAt(index)['inactive'],
                          width: 28.h,
                          height: 28.h,
                          color: AppColors.greyIcon,
                        )))),
          );
        },
      ),
    );
  }
}

List _pagesSeller = [const SellerPage(),  ProfilePage()];
List _pagesAdmin = [const AdminSellerPage(),  ProfilePage()];
