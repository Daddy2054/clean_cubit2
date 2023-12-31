import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/form/custom_text_form_field.dart';
import '../../../../common/mixin/loading_overlay_mixin.dart';
import '../../../../common/style/dimens.dart';
import '../controller/todo_add_controller.dart';
import '../state/todo_add_state.dart';
import 'package:clean_cubit2/common/mixin/dialog_mixin.dart';

class ToDoAddScreen extends StatefulWidget {
  const ToDoAddScreen({Key? key}) : super(key: key);

  @override
  State<ToDoAddScreen> createState() => _ToDoAddScreenState();
}

class _ToDoAddScreenState extends State<ToDoAddScreen>
    with DialogMixin, LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<ToDoAddController, ToDoAddState>(
          listenWhen: (previous, current) {
            return current.isAdded != previous.isAdded ||
                current.isLoading != previous.isLoading ||
                current.errorMsg != null;
          },
          listener: (context, state) {
            _overlayEntry?.remove();
            _overlayEntry = null;

            if (state.isAdded) {
              _showSuccessDialog();
            }

            if (state.isLoading) {
              _overlayEntry = showLoadingOverlay(context, _overlayEntry);
            }

            if (state.errorMsg != null) {
              _showErrorSnackbar(state.errorMsg ?? '');
            }
          },
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(kMedium),
              child: Column(
                children: [
                  const SizedBox(
                    height: kMedium,
                  ),
                  CustomTextFormField(
                    controller: _titleController,
                    labelText: 'Title',
                    hintText: 'ToDo Title',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'title is empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<ToDoAddController>().setFormData(
                            key: 'title',
                            value: value,
                          );
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: kMedium,
                  ),
                  CustomTextFormField(
                    controller: _bodyController,
                    labelText: 'Body',
                    hintText: 'ToDo Body',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 4,
                    minLine: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'body is empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<ToDoAddController>().setFormData(
                            key: 'body',
                            value: value,
                          );
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: kMedium,
                  ),
                  CustomTextFormField(
                    controller: _noteController,
                    labelText: 'Note',
                    hintText: 'ToDo Note',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    minLine: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Note is empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<ToDoAddController>().setFormData(
                            key: 'note',
                            value: value,
                          );
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: kMedium,
                  ),
                  BlocBuilder<ToDoAddController, ToDoAddState>(
                    buildWhen: (previous, current) {
                      return current.todoStatus != previous.todoStatus;
                    },
                    builder: (context, state) {
                      return SwitchListTile.adaptive(
                        title: const Text('Status'),
                        value: state.todoStatus,
                        onChanged: (value) {
                          context
                              .read<ToDoAddController>()
                              .setToDoStatus(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'saveToDo',
        onPressed: () {
          final isValid = _formKey.currentState?.validate();
          if (isValid != null && isValid) {
            context.read<ToDoAddController>().addToDo();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  void _showErrorSnackbar(String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
  }

  void _showSuccessDialog() {
    showSuccessDialog(
      context: context,
      title: 'Success',
      msg: 'ToDo Added Successfully',
      btnOkText: 'OK',
      onOkTap: () {
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.canPop()) {
          // pop the dialog
          navigator.pop();
          // pop the route
          context.pop();
        }
      },
    );
  }
}
