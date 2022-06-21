import 'package:flutter/material.dart';

import '../gialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: 'Sharing',
      content: 'you cannot share an empty note!',
      optionBuilder: () => {
            'OK': null,
          });
}
