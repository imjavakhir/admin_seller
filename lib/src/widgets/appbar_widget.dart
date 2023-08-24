import 'package:admin_seller/app_const/app_exports.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarContrastEnforced: true,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.black,
          systemNavigationBarIconBrightness: Brightness.dark),
      actions: actions,
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Styles.headline2,
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => child;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, 56.h);
}
