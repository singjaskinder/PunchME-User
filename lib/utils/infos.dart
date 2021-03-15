import 'package:punchme/models/requests_m.dart';

import 'currency.dart';

String getServiceInfo(RequestM requestM) {
  return '${getCurrency(requestM.price)} -  ${requestM.doIt} · ${requestM.getIt}';
}
