// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ws_work_teste_mobile/src/core/utils/extensions/theme_extension.dart';

import '../../../../../app/theme/extensions/common_theme_extension.dart';
import '../../viewmodels/contact_viewmodel.dart';

class FormContactWidget extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController telephoneController;
  const FormContactWidget({
    Key? key,
    required this.fullNameController,
    required this.telephoneController,
  }) : super(key: key);

  @override
  State<FormContactWidget> createState() => _FormContactWidgetState();
}

class _FormContactWidgetState extends State<FormContactWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = context.getExtension<CommonThemeExtension>();
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: size.width * 0.8,
          decoration: theme?.card1,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      "form.contact_us".tr(),
                      style: theme?.paragraph1,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      key: const Key('full_name'),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.fullNameController,
                      decoration: InputDecoration(
                        labelText: 'form.full_name'.tr(),
                        hintStyle: theme?.paragraph1,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!RegExp(r'^\w+\s\w+').hasMatch(value)) {
                          return 'Please enter a last name and first name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      key: const Key('telephone'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.telephoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'form.telephone'.tr(),
                        hintStyle: theme?.paragraph1,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                          return 'Please enter a valid telephone';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: Key('${widget.key.toString()}_submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final viewModel = ContactViewModel(
                      fullName: widget.fullNameController.text,
                      telephone: widget.telephoneController.text,
                    );
                    Modular.to.pop(viewModel);
                  }
                },
                child: Text(
                  "form.submit".tr(),
                  style: theme?.paragraph1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
