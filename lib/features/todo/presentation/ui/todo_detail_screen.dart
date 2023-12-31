import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/form/custom_text_form_field.dart';
import '../../../../common/mixin/dialog_mixin.dart';
import '../../../../common/style/dimens.dart';
import '../controller/todo_controller.dart';
import '../state/todo_state.dart';

class ToDoDetailScreen extends StatefulWidget {
  final int id;
  const ToDoDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ToDoDetailScreen> createState() => _ToDoDetailScreenState();
}

class _ToDoDetailScreenState extends State<ToDoDetailScreen> with DialogMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ToDoController>().getToDo(widget.id);
    });
  }

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
        title: const Text('Todo Detail'),
        centerTitle: true,
        actions: [
          BlocBuilder<ToDoController, ToDoState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<ToDoController>().setIsEnabled();
                },
                icon: state.isReadonly
                    ? const Icon(Icons.edit_note)
                    : const Icon(Icons.edit_outlined),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ToDoController, ToDoState>(
          listenWhen: (previous, current) {
            return current.isUpdated != previous.isUpdated;
          },
          listener: (context, state) {
            if (state.isUpdated) {
              _showSuccessDialog();
            }
          },
          buildWhen: (previous, current) {
            return current.todo.hashCode != previous.todo.hashCode ||
                current.isReadonly != previous.isReadonly;
          },
          builder: (context, state) {
            _titleController.text = state.formData['title'] ?? '';
            _bodyController.text = state.formData['body'] ?? '';
            _noteController.text = state.formData['note'] ?? '';
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(kMedium),
                child: Column(
                  children: [
                    const SizedBox(height: kMedium),
                    CustomTextFormField(
                      controller: _titleController,
                      labelText: 'Title',
                      hintText: 'ToDo Title',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      readOnly: state.isReadonly,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<ToDoController>().setFormData(
                              key: 'title',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(height: kMedium),
                    CustomTextFormField(
                      controller: _bodyController,
                      labelText: 'Body',
                      hintText: 'ToDo Body',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      readOnly: state.isReadonly,
                      maxLines: 4,
                      minLine: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'body is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<ToDoController>().setFormData(
                              key: 'body',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(height: kMedium),
                    CustomTextFormField(
                      controller: _noteController,
                      labelText: 'Note',
                      hintText: 'ToDo Note',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      readOnly: state.isReadonly,
                      maxLines: 5,
                      minLine: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'note is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<ToDoController>().setFormData(
                              key: 'note',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(height: kMedium),
                    BlocBuilder<ToDoController, ToDoState>(
                      buildWhen: (previous, current) {
                        return current.todoStatus != previous.todoStatus ||
                            current.isReadonly != previous.isReadonly;
                      },
                      builder: (context, state) {
                        return SwitchListTile.adaptive(
                          title: const Text('Status'),
                          value: state.todoStatus,
                          onChanged: state.isReadonly
                              ? null
                              : (value) {
                                  context
                                      .read<ToDoController>()
                                      .setToDoStatus(value);
                                },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          final isValid = _formKey.currentState?.validate();
          if (isValid != null && isValid) {
            context.read<ToDoController>().updateToDo();
          }
        },
        heroTag: 'updateToDo',
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showSuccessDialog(
      context: context,
      title: 'Success',
      msg: 'ToDo Updated Successfully',
      btnOkText: 'OK',
      onOkTap: () {
        context.read<ToDoController>().clearState();
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.canPop()) {
          //pop the dialog
          navigator.pop();
          //pop the route
          context.pop();
        }
      },
    );
  }
}
