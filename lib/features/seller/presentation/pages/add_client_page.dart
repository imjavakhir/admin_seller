import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/data/local_datasrc/hive_local.dart';
import 'package:flutter/cupertino.dart';

enum Sold { sold, notSold }

bool _isLoading = false;
Sold soldInfo = Sold.notSold;
bool isSoldInfo = true;

class AddClientpage extends StatelessWidget {
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
  final SellerRepository _sellerRepository = SellerRepository();
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
                          ],
                        ),
                      );
                    }),
                    ScreenUtil().setVerticalSpacing(20),
                    const Spacer(),
                    StatefulBuilder(builder: (context, set) {
                      return LongButton(
                          isloading: _isLoading,
                          buttonName: 'Оформить',
                          onTap: !_isLoading
                              ? () async {
                                  // // final String? reporShareId =
                                  // //     client.shared_seller != null &&
                                  // //             client.shared_seller!.isNotEmpty
                                  // //         ? client.shared_seller
                                  // //         : '';
                                  // // debugPrint(
                                  // //     '${state.isReported}++++++++$reporShareId');

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
                                                sharedid: /* reporShareId */ '',
                                                report: state.isReported,
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
                                  }

                                  if (soldInfo == Sold.sold) {
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
                                      await HiveDataSourceCLient()
                                          .saveClientDetails(
                                        id: client.id!,
                                        phoneNumber: _phoneController.text
                                            .replaceAll('-', '')
                                            .replaceAll('(', '')
                                            .replaceAll(')', '')
                                            .replaceAll(' ', ''),
                                        fullName: _fullNameController.text,
                                        whereFrom:
                                            _textEditingControllerID.text != ''
                                                ? _textEditingControllerID.text
                                                : state.whereFrom!,
                                        details: _detailsController.text,
                                      );
                                      Navigator.of(context)
                                          .pushNamed('/acceptOrder');
                                    }
                                  }
                                }
                              : null);
                    }),
                    ScreenUtil().setVerticalSpacing(20),
                  ],
                ),
              )
            ]),
            appBar: AppBarWidget(
              // actions: [
              //   if (client.shared_seller != null &&
              //       client.shared_seller!.isNotEmpty)
              //     IconButton(
              //         enableFeedback: false,
              //         splashRadius: 24.r,
              //         onPressed: () {
              //           BlocProvider.of<SellerBloc>(context)
              //               .add(ChangeReportStatus());
              //         },
              //         icon: Icon(
              //           state.isReported ? Icons.report : Icons.report,
              //           color:
              //               state.isReported ? AppColors.red : AppColors.green,
              //         )),
              // ],
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




      // final soldSelling = await _sellerRepository
      //                                       .sendSoldSelling(
      //                                           sharedid: /* reporShareId */ '',
      //                                           report: state.isReported,
      //                                           whereFrom:
      //                                               _textEditingControllerID
      //                                                           .text !=
      //                                                       ''
      //                                                   ? _textEditingControllerID
      //                                                       .text
      //                                                   : state.whereFrom!,
      //                                           id: client.id!,
      //                                           details:
      //                                               _detailsController.text,
      //                                           fullName:
      //                                               _fullNameController.text,
      //                                           phoneNumber: _phoneController
      //                                               .text
      //                                               .replaceAll('-', '')
      //                                               .replaceAll('(', '')
      //                                               .replaceAll(')', '')
      //                                               .replaceAll(' ', ''),
      //                                           price: double.parse(
      //                                               _priceController.text
      //                                                   .replaceAll('.', '')));
      //                                   debugPrint(soldSelling!.whereComeFrom!);




      