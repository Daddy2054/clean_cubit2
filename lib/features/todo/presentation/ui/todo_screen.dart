import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/mixin/loading_overlay_mixin.dart';
import '../../../../common/style/dimens.dart';
import '../../domain/model/todo_item.dart';
import '../controller/todo_controller.dart';
import '../state/todo_state.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen>
    with LoadingOverlayMixin, RouteAware {
  OverlayEntry? _overlayEntry;
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ToDoController>().getToDoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: BlocListener<ToDoController, ToDoState>(
        listenWhen: (previous, current) {
          return current.isLoading != previous.isLoading ||
              current.isDeleted != previous.isDeleted;
        },
        listener: (context, state) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          if (state.isLoading) {
            _overlayEntry = showLoadingOverlay(context, _overlayEntry);
          }
          if (state.isDeleted) {
            _showSnackBar();
          }
        },
        child: BlocSelector<ToDoController, ToDoState, List<ToDoItem>>(
          selector: (state) {
            return state.todos;
          },
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final todo = state[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(kSmall),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(todo.id.toString()),
                            const Spacer(),
                            Text(todo.createdAt),
                          ],
                        ),
                        const SizedBox(
                          height: kSmall,
                        ),
                        Text(todo.title),
                        const SizedBox(
                          height: kSmall,
                        ),
                        Text(todo.body),
                        Align(
                          alignment: Alignment.centerRight,
                          child: todo.status
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          context.push('/addTodo');
        },
        heroTag: 'addTodo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'ToDo deleted successfully',
        ),
      ),
    );
  }

  @override
  void didPopNext() {
    context.read<ToDoController>().refetchToDos();
    super.didPopNext();
  }
}
