import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: 'Ocurrio un errror',
    content: text,
    optionBuilder: () => {
      'Ok': null,
    },
  );
}
