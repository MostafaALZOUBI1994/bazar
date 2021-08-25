
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:bazarcom/app/data/repositories/advertisment_repository.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyAdvertismentController extends GetxController {
  final AdvertismentRepository adsRepo;
  final int userId;
  var isLoading=false.obs;

  MyAdvertismentController(this.adsRepo, this.userId)  : assert(adsRepo != null );

@override
  void onInit() {
   getMyAds(userId);
    super.onInit();
  }


  final _myAdvertismentList = List<Advertisment>().obs;
  get myAdvertismentList => this._myAdvertismentList.value;
  set myAdvertismentList(value) => this._myAdvertismentList.value = value;


  getMyAds(int userId) async {
    try{
      isLoading(true);
      myAdvertismentList=await adsRepo.getMyAdvertisments(userId);
    }finally
    {
      isLoading(false);
    }
    update();
  }
}
