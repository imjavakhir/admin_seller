import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class ModelBottomSheetWidget extends StatelessWidget {
  const ModelBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DraggableScrollableSheet(
            minChildSize: 1,
            maxChildSize: 1,
            initialChildSize: 1,
            builder: (context, scrollController) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScreenUtil().setVerticalSpacing(24),
                Center(
                  child: Text(
                    'Виберите вид мебеля и модель',
                    style: Styles.headline2,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10),
                const Divider(
                  height: 0,
                  color: AppColors.grey,
                ),
                ScreenUtil().setVerticalSpacing(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (value) {
                      BlocProvider.of<SellingBloc>(context)
                          .add(SearchFurnitureTypeModel(value));
                    },
                    enableSuggestions: false,
                    style: Styles.headline4,
                    decoration: InputDecoration(
                        hintText: 'Поиск...',
                        prefixIcon: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: const Icon(
                            CupertinoIcons.search,
                            color: AppColors.textfieldText,
                          ),
                        ),
                        hintStyle: Styles.headline4
                            .copyWith(color: AppColors.textfieldText),
                        prefixIconConstraints: const BoxConstraints(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        filled: true,
                        isDense: true,
                        isCollapsed: true,
                        enabledBorder: Decorations.enabledBorder,
                        focusedBorder: Decorations.focusedBorder,
                        errorBorder: Decorations.errorBorder),
                  ),
                ),
                Flexible(
                  child: Scrollbar(
                    radius: Radius.circular(100.r),
                    thickness: 4,
                    child: state.furnitureModelTypeModelList!.isNotEmpty
                        ? state.showSearchLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                itemCount: state.furnitureModelTypeModelList !=
                                        null
                                    ? state.furnitureModelTypeModelList!.length
                                    : 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    visualDensity:
                                        const VisualDensity(vertical: -2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    onTap: () {
                                      BlocProvider.of<SellingBloc>(context).add(
                                          SelectFurnitureTypeAndModel(
                                              '${state.furnitureModelTypeModelList![index]!.furnitureType!.name}--${state.furnitureModelTypeModelList![index]!.name!}',
                                              state
                                                  .furnitureModelTypeModelList![
                                                      index]!
                                                  .id!));
                                      Navigator.of(context).pop();
                                    },
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                    ),
                                    dense: true,
                                    subtitle: Text(
                                        "Модель: ${state.furnitureModelTypeModelList![index]!.name!}",
                                        style: Styles.headline5M
                                            .copyWith(color: AppColors.black)),
                                    title: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "Вид мебеля: ${state.furnitureModelTypeModelList![index]!.furnitureType!.name}",
                                          style: Styles.headline5M.copyWith(
                                              color: AppColors.textfieldText),
                                        ),
                                      ]),
                                    ),
                                  );
                                },
                              )
                        : Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    100.r,
                                  ),
                                  color:
                                      AppColors.primaryColor.withOpacity(0.5)),
                              child: Text(
                                'Ничего не найдено',
                                style: Styles.headline4,
                              ),
                            ),
                          ),
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
