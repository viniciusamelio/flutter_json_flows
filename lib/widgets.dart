import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import 'params.dart';

class DynamicViewBuilder extends StatefulWidget {
  final DynamicViewParams params;
  final PageController pageController;
  const DynamicViewBuilder({
    Key? key,
    required this.params,
    required this.pageController,
  }) : super(key: key);

  @override
  _DynamicViewBuilderState createState() => _DynamicViewBuilderState();
}

class _DynamicViewBuilderState extends State<DynamicViewBuilder> {
  late final GlobalKey<FormState>? _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.params.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          16,
        ),
        child: _handleBuilding(
          widget.params.type,
        ),
      ),
    );
  }

  Widget _handleBuilding(ViewType type) {
    if (type == ViewType.form) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            DynamicFormBuilder(
              fields: widget.params.fields,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  if (_formKey!.currentState!.validate()) {
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.bounceIn,
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.pinkAccent,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white70,
                  ),
                ),
                child: const Text(
                  "Validar",
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.params.subtitle ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DynamicFormBuilder extends StatefulWidget {
  const DynamicFormBuilder({
    Key? key,
    this.fields,
  }) : super(key: key);

  final List<DynamicFormFieldsParams>? fields;

  @override
  _DynamicFormBuilderState createState() => _DynamicFormBuilderState();
}

class _DynamicFormBuilderState extends State<DynamicFormBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildFields(),
    );
  }

  List<Widget> _buildFields() {
    return widget.fields!
        .map(
          (e) => TextFormField(
            decoration: InputDecoration(
              label: Text(
                e.label,
              ),
            ),
            keyboardType: handleFieldType(e.type),
            inputFormatters: generateMask(e.mask),
            validator: (value) => generateValidators(
              rules: e.rules,
              value: value,
            ),
          ),
        )
        .toList();
  }

  TextInputType handleFieldType(String type) {
    switch (type) {
      case "text":
        return TextInputType.text;
      case "number":
        return TextInputType.number;
      case "email":
        return TextInputType.emailAddress;
      case "password":
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  generateMask(String? mask) {
    if (mask != null) {
      return [
        TextInputMask(
          mask: mask,
        )
      ];
    }
  }

  generateValidators({Map<String, dynamic>? rules, String? value}) {
    if (rules != null && value != null) {
      if (rules.containsKey("minLength")) {
        final int minLength = int.parse(rules["minLength"]);
        if (value.length < minLength) {
          return minLength.toString() + " é o mínimo de caracteres";
        }
      } else if (rules.containsKey("maxLength")) {
        final int maxLength = int.parse(rules["maxLength"]);
        if (value.length < maxLength) {
          return maxLength.toString() + " é o máximo de caracteres";
        }
      }
    }
  }
}
