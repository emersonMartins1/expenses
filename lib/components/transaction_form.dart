import 'package:flutter/material.dart';
import 'adaptative/adaptative_button.dart';
import 'adaptative/adaptative_text_field.dart';
import 'adaptative/adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit) {
    // print("Constructor TransactionForm");
  }

  @override
  _TransactionFormState createState() {
    // print("createState() TransactionForm");
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  // _TransactionFormState() {
  //   print("Constructor _TransactionFormState");
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print("initState() _TransactionFormState");
  // }

  // @override
  // void didUpdateWidget(TransactionForm oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print("didUpdateWidget() _TransactionFormState");
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   print("dispose() _TransactionFormState");
  // }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: "Título",
                textController: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                label: "Valor (R\$)",
                textController: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: "Nova Transação",
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
