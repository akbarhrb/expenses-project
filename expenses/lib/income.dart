class Income {
  int? amount;
  String? month;

  Income({required this.amount, required this.month});

  static List<Income> incomes = [
    Income(amount: 1800, month: 'January'),
    Income(amount: 1200, month: 'February'),
    Income(amount: 2300, month: 'March'),
    Income(amount: 750, month: 'April'),
    Income(amount: 1350, month: 'May'),
    Income(amount: 1250, month: 'June'),
  ];
}
