import 'package:expense_tracker/Widgets/chart/chart.dart';
import 'package:expense_tracker/Widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _userExpense = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _userExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int index = _userExpense.indexOf(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _userExpense.insert(index, expense);
              });
            }),
      ),
    );
    setState(() {
      _userExpense.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size widgetSize = MediaQuery.of(context).size;

    Widget contentWidget = const Center(
        child: Text(
      'No expenses found. Start adding some!',
    ));
    if (_userExpense.isNotEmpty) {
      contentWidget = ExpensesList(
        expenses: _userExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    Widget orientWidget = Column(
      children: [
        Chart(expenses: _userExpense),
        Expanded(
          child: contentWidget,
        ),
      ],
    );
    if (widgetSize.width > widgetSize.height) {
      orientWidget = Row(
        children: [
          Expanded(
            child: Chart(expenses: _userExpense),
          ),
          Expanded(
            child: contentWidget,
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 25, 0, 75),
        title: const Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: orientWidget,
    );
  }
}
