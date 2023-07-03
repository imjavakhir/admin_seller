import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/phone_textfield.dart';
import 'package:admin_seller/features/seller/repository/seller_repo.dart';
import 'package:admin_seller/src/decoration/input_text_mask.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/validators/validators.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Sold { sold, notSold }

bool _isLoading = false;
Sold soldInfo = Sold.notSold;
bool isSoldInfo = true;

class AddClientpage extends StatelessWidget {
  final SellerRepository _sellerRepository = SellerRepository();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final GlobalKey<FormState> paramClientFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> fullnameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> sellKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerID =
      TextEditingController();

  AddClientpage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ClientInfo client =
        ModalRoute.of(context)!.settings.arguments! as ClientInfo;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SellerBloc, SellerState>(
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenUtil().setVerticalSpacing(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Параметры клиента',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        client.details!,
                        style: Styles.headline6.copyWith(fontSize: 18.sp),
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10.h),
                    Form(
                      key: phoneFormKey,
                      child: PhoneField(
                        textEditingControllerID: _textEditingControllerID,
                        valueDrop: state.whereFrom,
                        valueChangedDrop: (value) {
                          _textEditingControllerID.clear();
                          BlocProvider.of<SellerBloc>(context)
                              .add(WhereFromEvent(value));
                        },
                        formState: fullnameFormKey,
                        validatorName: Validators.empty,
                        valueChangedname: (value) {
                          fullnameFormKey.currentState!.validate();
                        },
                        validator: Validators.phoneNumber,
                        valueChanged: (value) {
                          // phoneFormKey.currentState!.validate();
                        },
                        listformater: [MaskFormat.mask],
                        textEditingControllerPhone: _phoneController,
                        textEditingControllerName: _fullNameController,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(20.h),
                    Form(
                      key: paramClientFormKey,
                      child: BigTextFieldWidget(
                        validator: Validators.empty,
                        valueChanged: (value) {
                          paramClientFormKey.currentState!.validate();
                        },
                        hintext: 'Описание',
                        textEditingController: _detailsController,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(20.h),
                    StatefulBuilder(builder: (contex, setState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Состаяние товара',
                              style: Styles.headline4,
                            ),
                            ScreenUtil().setVerticalSpacing(10.h),
                            Row(
                              children: [
                                MyCustomRadioButton(
                                    text: 'Не продано',
                                    value: Sold.notSold,
                                    onChanged: (value) {
                                      setState(() {
                                        soldInfo = value;
                                        isSoldInfo = true;
                                        _priceController.clear();
                                      });
                                    },
                                    groupValue: soldInfo),
                                ScreenUtil().setHorizontalSpacing(10.h),
                                MyCustomRadioButton(
                                    text: 'Продано',
                                    value: Sold.sold,
                                    onChanged: (value) {
                                      setState(() {
                                        soldInfo = value;
                                        isSoldInfo = false;
                                      });
                                    },
                                    groupValue: soldInfo)
                              ],
                            ),
                            ScreenUtil().setVerticalSpacing(10.h),
                            Form(
                              key: sellKey,
                              child: TextfieldWidget(
                                  listFormater: [
                                    ThousandsSeparatorInputFormatter()
                                  ],
                                  validator: Validators.empty,
                                  textInputType: TextInputType.number,
                                  isDisabled: isSoldInfo,
                                  isSoldField: true,
                                  paddingW: 0,
                                  hintext: '0',
                                  textEditingController: _priceController),
                            )
                          ],
                        ),
                      );
                    }),
                    ScreenUtil().setVerticalSpacing(30.h),
                    const Spacer(),
                    StatefulBuilder(builder: (context, set) {
                      return LongButton(
                          isloading: _isLoading,
                          buttonName: 'Оформить',
                          onTap: !_isLoading
                              ? () async {
                                  print(client.id);
                                  if (soldInfo == Sold.notSold) {
                                    final isValidatedPhone =
                                        phoneFormKey.currentState!.validate();
                                    final isValidatedParams = paramClientFormKey
                                        .currentState!
                                        .validate();
                                    final isValidatedName = fullnameFormKey
                                        .currentState!
                                        .validate();
                                    if (isValidatedName &&
                                        isValidatedParams &&
                                        isValidatedPhone) {
                                      set(() {
                                        _isLoading = true;
                                      });
                                      if (_isLoading) {
                                        await _sellerRepository
                                            .sendNotSoldSelling(
                                                id: client.id!,
                                                whereFrom:
                                                    _textEditingControllerID
                                                                .text !=
                                                            ''
                                                        ? _textEditingControllerID
                                                            .text
                                                        : state.whereFrom!,
                                                details:
                                                    _detailsController.text,
                                                phoneNumber: _phoneController
                                                    .text
                                                    .replaceAll('-', '')
                                                    .replaceAll('(', '')
                                                    .replaceAll(')', '')
                                                    .replaceAll(' ', ''),
                                                fullName:
                                                    _fullNameController.text);
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.main);
                                        set(() {
                                          _isLoading = false;
                                        });
                                      } else {
                                        set(() {
                                          _isLoading = false;
                                        });
                                      }
                                    }

                                    // Navigator.of(context)
                                    //     .pushNamed(AppRoutes.addClient);
                                  }

                                  if (soldInfo == Sold.sold) {
                                    final isValidatedSell =
                                        sellKey.currentState!.validate();
                                    final isValidatedPhone =
                                        phoneFormKey.currentState!.validate();
                                    final isValidatedParams = paramClientFormKey
                                        .currentState!
                                        .validate();
                                    final isValidatedName = fullnameFormKey
                                        .currentState!
                                        .validate();
                                    if (isValidatedName &&
                                        isValidatedParams &&
                                        isValidatedPhone &&
                                        isValidatedSell) {
                                      set(() {
                                        _isLoading = true;
                                      });

                                      if (_isLoading) {
                                        final soldSelling = await _sellerRepository
                                            .sendSoldSelling(
                                                whereFrom:
                                                    _textEditingControllerID
                                                                .text !=
                                                            ''
                                                        ? _textEditingControllerID
                                                            .text
                                                        : state.whereFrom!,
                                                id: client.id!,
                                                details:
                                                    _detailsController.text,
                                                fullName:
                                                    _fullNameController.text,
                                                phoneNumber: _phoneController
                                                    .text
                                                    .replaceAll('-', '')
                                                    .replaceAll('(', '')
                                                    .replaceAll(')', '')
                                                    .replaceAll(' ', ''),
                                                price: double.parse(
                                                    _priceController.text
                                                        .replaceAll('.', '')));
                                        debugPrint(soldSelling!.whereComeFrom!);
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.main);
                                        set(() {
                                          _isLoading = false;
                                        });
                                      } else {
                                        set(() {
                                          _isLoading = false;
                                        });
                                      }
                                    }
                                  }

                                  // LoginService().sendSoldSelling();
                                }
                              : null);
                    }),
                    ScreenUtil().setVerticalSpacing(30.h),
                  ],
                ),
              )
            ]),
            appBar: AppBarWidget(
              title: 'Оформить клиента',
              leading: IconButton(
                  enableFeedback: false,
                  splashRadius: 24.r,
                  iconSize: 24.h,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_left,
                    color: AppColors.black,
                  )),
            ),
          );
        },
      ),
    );
  }
}
