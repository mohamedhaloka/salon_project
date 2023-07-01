import 'package:easy_localization/easy_localization.dart';

const bookingDate = 'yyyy-MM-dd';

extension FormatDateTime on DateTime {
  String formatDate(String pattern) => DateFormat(pattern).format(this);
}
