import 'package:admin_seller/app_const/app_exports.dart';

class SellerTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final bool isSeller;
  final Widget? trailing;

  const SellerTile({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle = '',
    this.isSeller = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      enableFeedback: false,
      splashColor: AppColors.blue.withOpacity(0.05),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      onTap: onTap,
      trailing: trailing,
      title: Text(
        title,
        style: Styles.headline4Reg,
      ),
      subtitle: Text(
        isSeller ? subtitle : '+998$subtitle',
        style: Styles.headline6,
      ),
    );
  }
}
