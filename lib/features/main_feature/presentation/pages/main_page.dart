import 'package:admin_seller/app_const/app_exports.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool? isAdmin;
  checkUser() {
    final user = HiveDataSource().box.values.toList().first;
    debugPrint(user.type);

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
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: isAdmin!
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
                  items: isAdmin!
                      ? List.generate(
                          AppIcons.bottomNavigationItemsAdmin.length,
                          (index) => BottomNavigationBarItem(
                              activeIcon: SvgPicture.asset(
                                AppIcons.bottomNavigationItemsAdmin.values
                                    .elementAt(index)['inactive'],
                                width: 28.h,
                                height: 28.h,
                                color: AppColors.primaryColor,
                              ),
                              label: AppIcons.bottomNavigationItemsAdmin.keys
                                  .elementAt(index),
                              icon: SvgPicture.asset(
                                AppIcons.bottomNavigationItemsAdmin.values
                                    .elementAt(index)['inactive'],
                                width: 28.h,
                                height: 28.h,
                                color: AppColors.greyIcon,
                              )))
                      : List.generate(
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
            ),
          );
        },
      ),
    );
  }
}

List _pagesSeller = [const SellerPage(), const ProfilePage()];
List _pagesAdmin = [
  const AdminSellerPage(),
  const AcceptOnlineAccept(),
  const ProfilePage()
];
