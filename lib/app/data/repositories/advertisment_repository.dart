import 'package:bazarcom/app/data/providers/advertisment_provider.dart';
import 'package:meta/meta.dart';

class AdvertismentRepository {
  final AdvertismentApiClient apiClient;

  AdvertismentRepository({@required this.apiClient}) : assert(apiClient != null);


  getId(id) {
    return apiClient.getAdvertisment(id);
  }
}
 

