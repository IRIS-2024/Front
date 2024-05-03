import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:intl/intl.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  bool isAgreed = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: Intl.message('reportMissingTitle'),
      ),
      body: Padding(
        padding: CustomPadding.pageInsets,
        child: Center(
            child: Column(
          children: [
            const Padding(padding: CustomPadding.mediumBottom),
            Text(Intl.message('agreementTitle'),
                style: CustomTextStyle.basicBold, textAlign: TextAlign.center),
            const Padding(padding: CustomPadding.regularBottom),
            Flexible(
              child: Container(
                color: Colors.white,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     border: Border.all(
                //         width: 1,
                //         color: Theme.of(context).colorScheme.surfaceVariant)),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Padding(
                    padding: CustomPadding.dialogInsets,
                    child: Text(Intl.message('agreementContent')),
                  ),
                ),
              ),
            ),
            const Padding(padding: CustomPadding.mediumBottom),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer),
                onPressed: () {
                  Get.toNamed(Config.routerPostForm);
                },
                child: Text(Intl.message('agreementCheck'))),
            const Padding(padding: CustomPadding.regularBottom),

          ],
        )),
      ),
    );
  }
}
