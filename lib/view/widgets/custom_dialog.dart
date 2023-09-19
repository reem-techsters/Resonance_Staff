import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

class CustomDialog {
// static void openFilterDialog({context,required List dataList,}) async {
//     await FilterListDialog.display(
//       context,
//       listData: dataList,
//       selectedListData: dataList,
//       choiceChipLabel: (user) => user!.name,
//       validateSelectedItem: (list, val) => list!.contains(val),
//       onItemSearch: (user, query) {
//         return user.name!.toLowerCase().contains(query.toLowerCase());
//       },
//       onApplyButtonClick: (list) {
//         setState(() {
//           selectedUserList = List.from(list!);
//         });
//         Navigator.pop(context);
//       },
//     );
//   }

  static void customDialog(
      Widget widget, BuildContext context, VoidCallback func) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // insetPadding:EdgeInsets.all(0),

        // backgroundColor: Color(0x00ffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height / 2;
            var width = MediaQuery.of(context).size.width;

            // return Flexible(
            //   fit: FlexFit.tight,
            //   //This is the important part for you
            //   child:
            return SizedBox(
              width: width,
              child: widget,
            );
          },
        ),
      ),
    ).whenComplete(() => func.call());
  }

  static void showDialogTransperent(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Dialog(
              elevation: 0,
              backgroundColor: Color(0x00ffffff),
              child: Container(
                color: Color(0x00ffffff),
                alignment: FractionalOffset.center,
                height: 80.0,
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  semanticsLabel: 'Circular progress indicator',
                ),
              ),
            ));
  }
}
