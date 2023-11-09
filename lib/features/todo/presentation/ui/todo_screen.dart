import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
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
}
