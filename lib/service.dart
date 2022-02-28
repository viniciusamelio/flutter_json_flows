import 'package:dynamic_flows/params.dart';

class MockedService {
  Future<DynamicFlowParams> fetch() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final json = {
      "flow": "Cadastro",
      "brand": "google",
      "pages": [
        {
          "title": "Informações pessoais",
          "type": "form",
          "subtitle":
              "Precisamos das suas informações, mas não se preocupe! Seus dados estão protegidos conosco!",
          "fields": [
            {
              "type": "text",
              "label": "CPF",
              "mask": "999.999.999-99",
              "rules": {
                "digitsOnly": true,
                "minLength": "14",
                "maxLength": "14",
              },
            },
            {
              "type": "text",
              "label": "Nome Completo",
              "rules": {
                "minLength": "2",
                "maxLength": "50",
              },
            }
          ],
        },
        {
          "title": "Obrigado!",
          "type": "message",
          "subtitle":
              "Analisaremos seu cadastro e entraremos em contato logo, com sua resposta."
        }
      ],
    };
    return DynamicFlowParams.fromJson(json);
  }
}
