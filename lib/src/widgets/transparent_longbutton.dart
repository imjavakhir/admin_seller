import 'package:admin_seller/app_const/app_exports.dart';

class TransparentLongButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontsize;
  final double paddingW;
  final bool isDisabled;
  const TransparentLongButton({
    Key? key,
    required this.buttonName,
    this.isDisabled = false,
    this.fontsize = 20,
    required this.onTap,
    this.width = double.maxFinite,
    this.height = 56,
    this.paddingW = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: paddingW.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              width: 1,
              color:
                  isDisabled ? AppColors.red.withOpacity(0.2) : AppColors.red)),
      width: width,
      height: height.h,
      child: MaterialButton(
        enableFeedback: false,
        highlightColor: AppColors.red.withOpacity(0.1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        onPressed: isDisabled ? null : onTap,
        child: Text(
          buttonName,
          style: Styles.headline3.copyWith(
              color:
                  isDisabled ? AppColors.red.withOpacity(0.2) : AppColors.red,
              fontSize: fontsize.sp),
        ),
      ),
    );
  }
}
