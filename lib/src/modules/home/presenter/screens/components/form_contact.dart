// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
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
                      'Contact us',
                      style: Theme.of(context).textTheme.titleLarge,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: widget.telephoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telephone',
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
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
