import 'package:budget_app/db/chart_db.dart';
import 'package:budget_app/models/transaction/transaction_model.dart';
import 'package:get/get.dart';

class chartController extends GetxController {
// class ChartDatas {
//   String category;
//   double amount;
//   ChartDatas({required this.category, required this.amount});
// }

  chartLogic(List<TransactionModel> model) {
    double value;
    String categoryname;
    List<ChartDatas> newData = [];
    List visited = [];

    for (var i = 0; i < model.length; i++) {
      visited.add(0);
    }
    for (var i = 0; i < model.length; i++) {
      value = model[i].amount.toDouble();
      categoryname = model[i].category.name;
      for (var j = i + 1; j < model.length; j++) {
        if (model[i].category.name == model[j].category.name) {
          value += model[j].amount;
          visited[j] = -1;
        }
      }
      if (visited[i] != -1) {
        newData.add(ChartDatas(amount: value, category: categoryname));
      }
    }
    return newData;
  }
}
