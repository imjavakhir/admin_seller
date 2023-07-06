import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';

class PauseButton extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onTap;
  const PauseButton({
    super.key,
    required this.isPaused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      enableFeedback: false,
      splashRadius: 24.r,
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          !isPaused
                              ? 'Вы хотите перерыв?'
                              : 'Вы на перерыве, хотите вернуться к работе?',
                          style: Styles.headline3,
                        ),
                        ScreenUtil().setVerticalSpacing(20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LongButton(
                              paddingW: 0,
                              buttonName: 'Да',
                              fontsize: 12,
                              onTap: onTap,
                              height: 32,
                              width: 64,
                            ),
                            ScreenUtil().setHorizontalSpacing(20.w),
                            TransparentLongButton(
                              paddingW: 0,
                              width: 64,
                              height: 32,
                              fontsize: 12,
                              buttonName: 'Нет',
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      },
      icon: SvgPicture.asset(
        !isPaused ? AppIcons.userTick : AppIcons.userRemove,
        color: !isPaused ? AppColors.green : AppColors.red,
        height: 32.h,
        width: 32.w,
      ),
    );
  }
}
