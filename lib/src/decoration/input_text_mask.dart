import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class MaskFormat {
  static MaskTextInputFormatter mask =
      MaskTextInputFormatter(mask: '(##) ###-##-##');
       static MaskTextInputFormatter moneyMask =
      MaskTextInputFormatter(mask: '### ## ##');
}
