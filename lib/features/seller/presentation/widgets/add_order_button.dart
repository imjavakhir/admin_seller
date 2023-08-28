import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class AddOrderButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String hint;
  final bool isSelected;
  const AddOrderButtonWidget({
    super.key,
    this.isSelected = false,
    required this.hint,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.textfieldBackground,
          border: Border.all(width: 1, color: AppColors.borderColor)),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                hint,
                style: Styles.headline4.copyWith(
                    color:
                        isSelected ? AppColors.black : AppColors.textfieldText),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.chevron_down,
                color: AppColors.borderColor,
                size: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
