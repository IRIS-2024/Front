import 'package:flutter/material.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/model/missing_info.dart';

class SingleInfo extends StatelessWidget {
  MissingInfo missingInfo;
  SingleInfo({super.key, required this.missingInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.thickBottom,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                missingInfo.images.first,
                height: 170,
                width: 380,
                fit: BoxFit.fitWidth,
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${missingInfo.name} / ${missingInfo.age}세 / ${missingInfo.address}",
                style: CustomTextStyle.title,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_outlined))
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: Theme.of(context).colorScheme.outline,
              ),
              const Padding(padding: CustomPadding.slimRight),
              Text(
                '24분전',
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ],
          )
        ],
      ),
    );
  }
}
