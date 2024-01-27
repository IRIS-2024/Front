import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/model/missing_info.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/controller/main/main_controller.dart';
import 'package:iris_flutter/view/page/detail_info/report_item.dart';

class WrittenReports extends StatefulWidget {
  const WrittenReports({super.key});

  @override
  State<WrittenReports> createState() => _WrittenReportsState();
}

class _WrittenReportsState extends State<WrittenReports> {
  @override
  void initState() {
    Get.put(MainController()).setTmpData();
    super.initState();
  }

  // urlImages = 댓글 사진 썸네일(대표 이미지)
  final urlImages = [
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainController);
    final mainController = Get.find<MainController>();

    return Scaffold(
      appBar: customAppBar(title: "작성한 제보 댓글"),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: mainController.missingInfoList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  itemCount: mainController.missingInfoList.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // CircleAvatar(child: )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/images/temp_logo.png",
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 10)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Text(
                                      '${mainController.missingInfoList[idx].missingName} / ${mainController.missingInfoList[idx].missingGender} / ${mainController.missingInfoList[idx].missingAge} 세 / ${mainController.missingInfoList[idx].missingLocation}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          itemCount: urlImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "이 텍스트는 제목이 됩니다. 이렇게",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("8분전", style: TextStyle(fontSize: 12))
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                              .size
                                              .width),
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(urlImages[1],
                                            fit: BoxFit.cover),
                                      )),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("옷차림",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "산들림 비나리 소록소록 가온해 소록소록"))
                                          ],
                                        ),
                                        const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("당시 상황",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                                child: Text(
                                                    "근로자는 근로조건의 향상을 위하여 자주적인 단결권·단체교섭권 및 단체행동권을 가진다. 군인은 현역을 면한 후가 아니면 국무위원으로 임명될 수 없다."))
                                          ],
                                        ),
                                        Text("일치율 88%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                          },
                          separatorBuilder: (BuildContext ctx, int idx) {
                            return const Divider();
                          },
                        ),
                      ],
                    );
                  })
              : const Center(
                  child: Text("작성한 제보 댓글이 없습니다."),
                )),
    );
  }
}
