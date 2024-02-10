import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
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
            title: const Text(
              '실종 정보',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0, // 앱 바 뒷 배경색 제거
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
            ],
            bottom: TabBar(
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
                      child: Text("상세 내용"),
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
          body: const Column(
            children: [
              SizedBox(
                // 탭 바와 본문의 여백을 위해
                height: 12,
              ),
              Expanded(
                child: TabBarView(
                  children: [InfoTab(), ReportTab()],
                ),
              )
            ],
          )),
    );
  }
}
