import 'package:dynamic_flows/params.dart';
import 'package:dynamic_flows/service.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class DynamicView extends StatefulWidget {
  const DynamicView({Key? key}) : super(key: key);

  @override
  _DynamicViewState createState() => _DynamicViewState();
}

class _DynamicViewState extends State<DynamicView> {
  final MockedService service = MockedService();
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DynamicFlowParams>(
      future: service.fetch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        }
        final data = snapshot.data!;
        return PageView.builder(
          itemCount: data.pages.length,
          controller: pageController,
          itemBuilder: ((context, index) {
            final page = data.pages[index];
            return DynamicViewBuilder(
              pageController: pageController,
              params: DynamicViewParams(
                title: page.title,
                type: page.type,
                fields: page.fields,
                subtitle: page.subtitle,
              ),
            );
          }),
        );
      },
    );
  }
}
