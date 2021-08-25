
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:bazarcom/app/data/repositories/advertisment_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AdvertismentController extends GetxController {
  final AdvertismentRepository adsRepo;
  final int subId;
  var isLoading=false.obs;
  AdvertismentController(this.adsRepo, this.subId)  : assert(adsRepo != null );


  @override
  void onInit() {
    getAds(subId);
    super.onInit();
  }

  final _advertismentList = List<Advertisment>().obs;

  get advertismentList => this._advertismentList.value;

  set advertismentList(value) => this._advertismentList.value = value;


  getAds(subId) async {
    try{
      isLoading(true);
      advertismentList=await adsRepo.getAll(subId);
    }finally
        {
          isLoading(false);
        }
        update();
  }

}
