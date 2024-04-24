import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_flutter/config/config.dart';
import 'package:iris_flutter/config/custom_padding.dart';
import 'package:iris_flutter/config/custom_text_style.dart';
import 'package:iris_flutter/view/comm/custom_appbar.dart';
import 'package:iris_flutter/view/page/form/submit_button.dart';

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
        title: '실종자 등록',
      ),
      body: Padding(
        padding: CustomPadding.pageInsets,
        child: Center(
            child: Column(
          children: [
            const Padding(padding: CustomPadding.mediumBottom),
            const Text(
              "잠깐! 실종자 등록 전 확인했나요?",
              style: CustomTextStyle.basicBold,
            ),
            const Padding(padding: CustomPadding.regularBottom),
            Flexible(
              child: Container(
                // color: Theme.of(context).colorScheme.surfaceVariant,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.surfaceVariant)),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: const Padding(
                    padding: CustomPadding.dialogInsets,
                    child: Text(
                        " 개인정보 보호법 제 15조에 따라, 실종자 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우에만 실종자의 동의 없이도 개인정보를 제공할 수 있습니다. \n 개인정보 보호법 제 71조에 따라, 위의 경우가 아님에도 불구하고 실종자의 개인정보를 MissingYou에게 등록한 경우 5년 이하의 징역 또는 5천만원 이하의 벌금에 처할 수 있습니다. \n 또한 개인정보 보호법 제36조(개인정보의 정정ㆍ삭제)에 따라 자신의 개인정보를 열람한 정보주체는 MissingYou에게 그 개인정보의 정정 또는 삭제를 요구할 수 있습니다. \n\n\n • 개인정보 보호법에 따라 실종자의 급박한 생명, 신체, 이익을 위해 필요하다고 인정되지 않은 경우 실종자의 개인정보를 MissingYou앱에 등록할 수 없음을 숙지하였습니다. \n\n 즉 실종자의 생명 또는 신체를 해할 우려가 있거나 실종자의 재산과 그 밖의 이익을 부당하게 침해할 목적으로 실종 정보를 등록하는 경우, 개인정보보호법 위반으로 처벌받을 수 있음을 숙지하였습니다. \n\n • 또한 법적 문제 발생 시 해당 서약서가 작성자의 의도나 동의에 대한 증거로 사용될 수 있음을 숙지하였습니다. \n\n • 개인정보 보호법 제 36조에 따라 정보 주체인 실종자의 요청에 따라, 신고글은 언제든 작성자에게 별도의 통보없이 삭제될 수 있음을 숙지하였습니다. \n\n • 위의 내용을 충분히 숙지하였으며, 실종자의 개인 정보를 적법하게 다룰 것을 엄숙히 서약합니다."),
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
                child: const Text("위의 내용을 확인하였으며, 동의합니다."))
          ],
        )),
      ),
    );
  }
}
