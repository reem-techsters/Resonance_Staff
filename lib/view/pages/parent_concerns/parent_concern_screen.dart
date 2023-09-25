import 'package:attendance/controller/model_state/parent_concern_controller.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/parent_concerns/parentconcern_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ParentConcernScreen extends StatefulWidget {
  const ParentConcernScreen({super.key});

  @override
  State<ParentConcernScreen> createState() => _ParentConcernScreenState();
}

class _ParentConcernScreenState extends State<ParentConcernScreen> {
  final ParentConcernGetx controller = Get.put(ParentConcernGetx());
  @override
  void initState() {
    ParentConcernGetx().loadresources();
    ParentConcernGetx().callParentConcernList(
        int.parse(GetUserData().getCurrentUser().userid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ParentConcernGetx());
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ParentConcernGetx>(
          init: controller,
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.loadresources();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Parent Concerns"),
                  controller.showLoader
                      ? Expanded(
                          child: Center(child: CircularProgressIndicator()))
                      : controller.parentConcernlist.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.searchData.clear();
                                            controller.searchCtrl.clear();
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ParentConcernSearchScreen(
                                                      title: 'Parent Concerns'),
                                            ));
                                          },
                                          child: TextFormField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              hintText: 'Search',
                                              prefixIcon: Icon(Icons.search),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .parentConcernlist.length,
                                          itemBuilder: (context, index) {
                                            final data = controller
                                                .parentConcernlist[index];
                                            return ParentConcernCardWidget(
                                              index: index,
                                              data: data,
                                              controller: controller,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
