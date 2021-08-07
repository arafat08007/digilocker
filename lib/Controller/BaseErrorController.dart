import 'package:googledriveclone_flutter/helper/dialog_helper.dart';
import 'package:googledriveclone_flutter/services/AppException.dart';

class BaseErrorController {
  static void handleError (error){
    if(error is BadRequestException) {
      var message = error.message;
      DialogHelper.ShowErrDialog(description: message);
    }
    else if (error is FetchdataException) {
      var message = error.message;
      DialogHelper.ShowErrDialog(description: message);
    }
    else if (error is ApiNotRespondingException) {
      var message = error.message;
      DialogHelper.ShowErrDialog(description: message);
    }
    else if (error is UnAutorizedException) {
      var message = error.message;
      DialogHelper.ShowErrDialog(description: message);
    }
    else {
     // var message = error.message;
      DialogHelper.ShowErrDialog(description: "Opps! Undefined error\n Find the error below \n ${error.toString()}");
    }
  }
  showLoading([String message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}