import 'package:voice_doctor/auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({required Key keyText}) : super(key: keyText);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: Center(
          child: VerifyBody(title: 'title', VerifyKey: Key("VerifyKey"),),
        ),
      ),
    );
  }
}

class VerifyBody extends StatelessWidget {
  VerifyBody({required Key VerifyKey, required this.title}) : super(key: VerifyKey);

  final String title;
  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of<UserModel>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: <TextSpan>[
                        TextSpan(text: "お送りした6桁のコードを入力してください:"),
                        TextSpan(
                          text: "992914950",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: PinInputTextField(
              pinLength: 6,
              controller: PinEditingController(pinLength: 6, text: 'PinEditingController'),
              autoFocus: true,
              onChanged: (pin) {
                print('submit pin:$pin');
                usermodel.setVerifyCode(pin);
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              onSubmit: (pin) {
                print('submit pin:$pin');
              },
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              usermodel.signInWithPhoneNumber(context);
            },
            child: Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 40.0,
            ),
            shape: new CircleBorder(),
            elevation: 1.0,
            fillColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(20.0),
          )
        ],
      ),
    );
  }
}

class PinEditingController extends TextEditingController {
  /// Control the maxLength of pin.
  int pinMaxLength;

  /// If the value set to true, the controller will dispose when the widget dispose.
  final bool autoDispose;

  PinEditingController({
    required String text,
    this.autoDispose = true,
    required int pinLength,
  })  : this.pinMaxLength = pinLength,
        super(text: text);

  @override
  set text(String newText) {
    /// Cut the parameter string if the length is longer than [_pinMaxLength].
    if (newText != null &&
        pinMaxLength != null &&
        newText.length > pinMaxLength) {
      newText = newText.substring(0, pinMaxLength);
    }
    super.text = newText;
  }
}