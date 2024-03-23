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
                  IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              TextField(
                controller: widget.fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              TextField(
                controller: widget.telephoneController,
                decoration: const InputDecoration(
                  labelText: 'Telephone',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: Key('${widget.key.toString()}_submit'),
                onPressed: () => Modular.to.pop(
                  ContactViewModel(
                    fullName: widget.fullNameController.text,
                    telephone: widget.telephoneController.text,
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
