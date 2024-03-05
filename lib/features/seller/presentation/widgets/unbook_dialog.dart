import 'package:admin_seller/app_const/app_exports.dart';
class UnbookDialog extends StatelessWidget {
  final VoidCallback onTap;
  final String id;
  final String warehouse;
  final String furnitureType;
  final String tissue;
  final String details;
  final String furnitureModel;
  const UnbookDialog({
    super.key,
    required this.onTap,
    required this.id,
    required this.warehouse,
    required this.furnitureType,
    required this.tissue,
    required this.details,
    required this.furnitureModel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScreenUtil().setVerticalSpacing(20.h),
            Center(
              child: Text(
                'Вы хотите разбронировать этот товар?',
                textAlign: TextAlign.center,
                style: Styles.headline2,
              ),
            ),
            ScreenUtil().setVerticalSpacing(20),
            OrderCardTile(
              leading: 'ID',
              trailing: id,
            ),
            OrderCardTile(
              leading: 'Склад',
              trailing: warehouse,
            ),
            OrderCardTile(
              leading: 'Вид мебели',
              trailing: furnitureType,
            ),
            OrderCardTile(
              leading: 'Модель',
              trailing: furnitureModel,
            ),
            OrderCardTile(
              leading: 'Ткань',
              trailing: tissue,
            ),
            OrderCardTile(
              leading: 'Примичение',
              trailing: details,
            ),
            ScreenUtil().setVerticalSpacing(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LongButton(
                  paddingW: 0,
                  buttonName: 'Да',
                  fontsize: 12,
                  onTap: onTap,
                  height: 40,
                  width: 80,
                ),
                ScreenUtil().setHorizontalSpacing(20.w),
                TransparentLongButton(
                  paddingW: 0,
                  width: 80,
                  height: 40,
                  fontsize: 12,
                  buttonName: 'Нет',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            ScreenUtil().setVerticalSpacing(20)
          ],
        ),
      ),
    );
  }
}