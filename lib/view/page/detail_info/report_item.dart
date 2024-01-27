import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "이 텍스트는 제목이 됩니다. 이렇게",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text("8분전", style: TextStyle(fontSize: 12))
            ],
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
