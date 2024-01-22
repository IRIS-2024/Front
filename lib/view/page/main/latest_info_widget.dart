import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LatestInfoWidget extends StatefulWidget {
  const LatestInfoWidget({Key? key}) : super(key: key);

  @override
  State<LatestInfoWidget> createState() => _LatestInfoWidgetState();
}

class _LatestInfoWidgetState extends State<LatestInfoWidget> {
  @override
  Widget build(BuildContext context) {
    const time = '24';

    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/exImage.png', height: 170, width: 380, fit: BoxFit.fitWidth,)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("김말순 / 85세 / 용산구 갈월동",
              style: TextStyle(
                fontSize: 20
              ),),
              IconButton(onPressed: () {
              }, icon: Icon(Icons.bookmark_border_outlined))
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: Theme.of(context).hintColor,),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Text('${time}분전', style: TextStyle(
                color: Theme.of(context).hintColor
              ),),
            ],
          )
        ],
      ),
    );
  }
}
