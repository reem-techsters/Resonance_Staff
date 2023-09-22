// import 'package:attendance/controller/model_state/parent_concern_controller.dart';
// import 'package:attendance/model/parent_concern_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchGetx extends GetxController {
//   TextEditingController searchCtrl = TextEditingController();
//   TextEditingController commentCtrl = TextEditingController();
//   // List<Datum> parentConcernlist = [];
//   List<dynamic> SearchData = [];

//   bool showLoader = true;

//   getSearchResult(String value) {
//     SearchData.clear();
//     update();
//     for (var i in ParentConcernGetx().parentConcernlist) {
//       if (i.name.toString().toLowerCase().contains(
//             value.toLowerCase(),
//           )) {
//         update();
//         Datum data = Datum(
//           image: i.image,
//           categoryname: i.categoryname,
//           studentId: i.studentId,
//           concernId: i.concernId,
//           category: i.category,
//           subCategory: i.subCategory,
//           details: i.details,
//           fromTime: i.fromTime,
//           toTime: i.toTime,
//           status: i.status,
//           feedback: i.feedback,
//           feedbackreason: i.feedbackreason,
//           createdDate: i.createdDate,
//           subcategoryname: i.subCategory,
//           name: i.name,
//           applicationnumber: i.applicationnumber,
//           branchname: i.branchname,
//           fathername: i.fathername,
//         );
//         SearchData.add(data);
//         update();
//       }
//     }
//   }
// }
