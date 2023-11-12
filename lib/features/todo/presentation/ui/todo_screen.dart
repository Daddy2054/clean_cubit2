import 'package:clean_cubit2/core/service_locator.dart';
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
      getIt.get<RouteObserver>().subscribe(this, ModalRoute.of(context)!);
    });
  }

  @override
  void dispose() {
    getIt.get<RouteObserver>().unsubscribe(this);
    super.dispose();
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
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  dismissThresholds: const {DismissDirection.endToStart: 0.6},
                  background: const ColoredBox(
                    color: Colors.redAccent,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) =>
                      _confirmDismiss(direction, todo.id, todo.userId),
                  child: GestureDetector(
                    onTap: () => context.push('/detail/${todo.id}'),
                    child: Card(
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
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addTodo');
        },
        heroTag: 'addTodo',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool?> _confirmDismiss(
      DismissDirection direction, int id, int userId) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text(
            "Are you sure you want to delete this item?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<ToDoController>().deleteToDo(id, userId);
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
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
