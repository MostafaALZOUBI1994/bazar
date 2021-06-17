import 'package:bazarcom/app/data/providers/categories_provider.dart';
import 'package:meta/meta.dart';

class CategoryRepository {
  final CategoryApi apiClient;

  CategoryRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAllCategory();
  }

  getId(id) {
    return apiClient.getId(id);
  }
}
