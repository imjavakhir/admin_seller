import 'package:admin_seller/app_const/app_exports.dart';

class AcceptWidget extends StatelessWidget {
  final String fullname;
  final String phoneNumber;
  final VoidCallback onTapTick;
  final bool? isLoading;
  final int? selectedItem;
  final int? index;
  final bool isVerfied;
  final bool isOnline;
  const AcceptWidget(
      {super.key,
      required this.fullname,
      required this.phoneNumber,
      required this.onTapTick,
      this.isLoading = false,
      this.selectedItem,
      this.index,
      this.isVerfied = false,
      this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
          decoration: BoxDecoration(
              color: isVerfied
                  ? AppColors.primaryColor.withOpacity(0.3)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20.r,
                    color: AppColors.cardShadow,
                    offset: const Offset(0, 0))
              ]),
          height: 90.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: Styles.headline4,
                      ),
                      Text(
                        phoneNumber,
                        style: Styles.headline5,
                      )
                    ],
                  ),
                  const Spacer(),
                  if (!isVerfied && isOnline)
                    Material(
                      type: MaterialType.button,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r)),
                      child: IconButton(
                          splashColor: Colors.transparent,
                          splashRadius: 24,
                          onPressed: onTapTick,
                          icon: SvgPicture.asset(
                            AppIcons.tick,
                            height: 36.h,
                            width: 36.h,
                            colorFilter: const ColorFilter.mode(
                                AppColors.green, BlendMode.srcIn),
                          )),
                    ),
                ],
              )
            ],
          ),
        ),
        if (isLoading! && selectedItem == index)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 80.h,
            width: double.maxFinite,
            child: Center(
              child: Transform.scale(
                scale: 0.7,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
            ),
          )
      ],
    );
  }
}
