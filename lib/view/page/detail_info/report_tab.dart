import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/detail_info/map_widget.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  final urlImages = [
    'https://images.unsplash.com/photo-1612825173281-9a193378527e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=499&q=80',
    'https://images.unsplash.com/photo-1580654712603-eb43273aff33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1627916607164-7b20241db935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
    'https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1570829053985-56e661df1ca2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  ];

  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // map()
        const SizedBox(
          height: 300,
          child: MapWidget(),
        ),
        const SizedBox(height: 12),
        Container(
            alignment: Alignment.centerRight,
            color: Colors.white,
            child: SwitchListTile(
                value: isSwitched,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text("정확도 80% 이상"),
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                })),
        Container(
          color: Colors.white,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ImageDialog(urlImages[index]));
                            },
                            child: Image.network(urlImages[index],
                                fit: BoxFit.cover),
                          ))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "이 텍스트는 제목이 됩니다. 이렇게",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Text("8분전", style: TextStyle(fontSize: 12))
                          ],
                        ),
                        const Row(
                          children: [
                            Text("옷차림", style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(child: Text("산들림 비나리 소록소록 가온해 소록소록"))
                          ],
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("당시 상황", style: TextStyle(color: Colors.grey)),
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
                                color: Theme.of(context).colorScheme.primary))
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext ctx, int idx) {
              return const Divider();
            },
          ),
        )
      ]),
    );
  }
}
