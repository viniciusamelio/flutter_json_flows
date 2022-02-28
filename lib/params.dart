class DynamicFlowParams {
  DynamicFlowParams({
    required this.brand,
    required this.title,
    required this.pages,
  });
  String title;
  String brand;
  List<DynamicViewParams> pages;
  factory DynamicFlowParams.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> pages = json["pages"];
    return DynamicFlowParams(
      brand: json["brand"],
      title: json["flow"],
      pages: pages
          .map(
            (e) => DynamicViewParams.fromJson(e),
          )
          .toList(),
    );
  }
}

class DynamicViewParams {
  DynamicViewParams({
    required this.title,
    this.subtitle,
    required this.type,
    this.fields,
  });
  String title;
  String? subtitle;
  ViewType type;
  List<DynamicFormFieldsParams>? fields;

  factory DynamicViewParams.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? fields = json['fields'];
    return DynamicViewParams(
      title: json['title'],
      subtitle: json['subtitle'],
      type: viewTypefromString(
        json['type'],
      ),
      fields: fields != null
          ? fields
              .map(
                (e) => DynamicFormFieldsParams.fromJson(e),
              )
              .toList()
          : [],
    );
  }
}

class DynamicFormFieldsParams {
  DynamicFormFieldsParams({
    required this.type,
    this.mask,
    this.rules,
    required this.label,
  });
  String type;
  String label;
  String? mask;
  Map<String, dynamic>? rules;

  factory DynamicFormFieldsParams.fromJson(Map<String, dynamic> json) {
    return DynamicFormFieldsParams(
      label: json['label'],
      type: json["type"],
      rules: json['rules'],
      mask: json['mask'],
    );
  }
}

enum ViewType {
  form,
  message,
}

extension on ViewType {
  // ignore: unused_element
  String stringfy() {
    if (this == ViewType.form) {
      return "form";
    }
    return "message";
  }
}

ViewType viewTypefromString(String value) {
  final Map<String, ViewType> fromTo = {
    "form": ViewType.form,
    "message": ViewType.message,
  };
  return fromTo[value]!;
}
