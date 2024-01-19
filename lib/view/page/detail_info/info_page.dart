import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/detail_info/info_tab.dart';
import 'package:iris_flutter/view/page/detail_info/report_tab.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: const Text('실종 신고'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back), // 햄버거버튼 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  print('뒤로가기');
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.bookmark_outline), // 장바구니 아이콘 생성
                  onPressed: () {
                    // 아이콘 버튼 실행
                    print('북마크 버튼 실행');
                  },
                ),
              ]),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                // height: 35.0,
                child: TabBar(
                  labelColor: Colors.white, // 배경색
                  unselectedLabelColor: Theme.of(context).colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).colorScheme.primary),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("실종 정보"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("제보"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Expanded(
                child: TabBarView(
                  children: [InfoTab(), ReportTab()],
                ),
              )
            ],
          )),
    );
  }
}
