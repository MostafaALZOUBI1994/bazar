import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:bazarcom/app/data/repositories/category_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  final CategoryRepository repository;
  var isLoading = false.obs;

  HomeController({this.repository}) : assert(repository != null);
  @override
  void onInit() {
    getAll();
    super.onInit();
  }

  final _categoriesList = List<CategoryModel>().obs;

  get categoriesList => this._categoriesList.value;

  set categoriesList(value) => this._categoriesList.value = value;

  final _mainCategoriesList = List<CategoryModel>().obs;

  get mainCategoriesList => this._mainCategoriesList.value;

  set mainCategoriesList(value) => this._mainCategoriesList.value = value;

  getAll() async {
    try {
      isLoading(true);
      categoriesList = await repository.getAll();
    } finally {
      isLoading(false);
    }
    update();
  }

}
