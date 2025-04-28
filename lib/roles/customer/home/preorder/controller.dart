import 'package:kichikichi/commons/bloc/baseController.dart';

class CustomerHomePreorderController extends BaseController {
  @override
  void validate() {
    require('name');
    require('count');
    require('phone');
    require('pickupTime');
    update();
    super.validate();
  }
}
