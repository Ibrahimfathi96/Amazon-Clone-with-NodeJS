import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnakeBar(context,
          "error-msg:${jsonDecode(response.body)['msg']}\nstatus-code:${response.statusCode}");
      break;
    case 500:
      showSnakeBar(context,
          "error-msg:${jsonDecode(response.body)['error']}\nstatus-code:${response.statusCode}");
      break;
    default:
      showSnakeBar(context,
          "server-error:${response.body}\nstatus-code:${response.statusCode}");
  }
}
