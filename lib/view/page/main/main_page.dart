import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iris_flutter/view/page/main/main_tab_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const location_name = "용산구";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // my page iconButton
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_outlined),
                ),
              ),
             // location Text
             Align(
               alignment: Alignment.centerLeft,
               child: RichText(
                 text: TextSpan(
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 30,
                     color: Theme.of(context).colorScheme.outline
                   ),
                   children: [
                     TextSpan(text: "${location_name}",
                         style: TextStyle(
                             color: Theme.of(context).colorScheme.primary
                         )),
                     TextSpan(text: "에서 등록된\n실종 정보입니다.",
                       style: TextStyle(
                         color: Colors.black
                       )
                     )
                   ]
                 ),
               ),
             ),
              const Padding(padding: EdgeInsets.only(bottom: 14)),

              // main TabBar
              MainTabWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {

      }, label: Text('신고하기'),
      icon: Icon(Icons.report_gmailerrorred),)
    );
  }
}
