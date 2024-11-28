import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String timePeriod = "month";

  final List<Map<String, dynamic>> expenseCategories = [
    {"name": "Food", "icon": Icons.fastfood, "amount": 450, "percentage": 30, "color": Colors.orange},
    {"name": "Shopping", "icon": Icons.shopping_bag, "amount": 300, "percentage": 20, "color": Colors.blue},
    {"name": "Entertainment", "icon": Icons.movie, "amount": 225, "percentage": 15, "color": Colors.purple},
    {"name": "Accommodation", "icon": Icons.home, "amount": 10000, "percentage": 50, "color": Colors.green},
    {"name": "Travel", "icon": Icons.flight, "amount": 375, "percentage": 25, "color": Colors.yellow},
    {"name": "Other", "icon": Icons.circle, "amount": 150, "percentage": 10, "color": Colors.grey},
  ];

  final List<Map<String, dynamic>> latestExpenses = [
    {"description": "Grocery shopping", "amount": 85.5, "date": "2023-05-15"},
    {"description": "Movie tickets", "amount": 30.0, "date": "2023-05-14"},
    {"description": "Gas station", "amount": 45.0, "date": "2023-05-13"},
    {"description": "Restaurant dinner", "amount": 120.0, "date": "2023-05-12"},
  ];

  double get totalExpenses {
    return expenseCategories.fold(0, (sum, category) => sum + category['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: timePeriod,
              onChanged: (newValue) {
                setState(() {
                  timePeriod = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'day', child: Text('Today')),
                DropdownMenuItem(value: 'week', child: Text('This Week')),
                DropdownMenuItem(value: 'month', child: Text('This Month')),
                DropdownMenuItem(value: 'year', child: Text('This Year')),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Header
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Welcome to your Dashboard!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              
              // Total Expenses Card
              Card(
                color: Colors.blueAccent,
                child: ListTile(
                  title: Text(
                    'Total Expenses',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rs.${totalExpenses.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '+20.1% from last $timePeriod',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      // Navigate to the add expense page
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Expense Categories
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: expenseCategories.length,
                itemBuilder: (context, index) {
                  var category = expenseCategories[index];
                  return Card(
                    color: category['color'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'], size: 40, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          category['name'],
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Rs.${category['amount'].toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: category['percentage'] / 100,
                          backgroundColor: Colors.white,
                          color: Colors.white70,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${category['percentage']}% of total expenses',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              // Latest Expenses Table
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Latest Expenses',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Date')),
                      ],
                      rows: latestExpenses
                          .map(
                            (expense) => DataRow(cells: [
                              DataCell(Text(expense['description'])),
                              DataCell(Text('Rs.${expense['amount'].toStringAsFixed(2)}')),
                              DataCell(Text(expense['date'])),
                            ]),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
