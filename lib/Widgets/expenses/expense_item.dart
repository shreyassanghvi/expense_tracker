import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseData, {super.key});

  final Expense expenseData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseData.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expenseData.amount.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                ),
                const Spacer(),
                Row(children: [
                  Icon(categoryIcons[expenseData.category]),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    expenseData.formattedDate,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
