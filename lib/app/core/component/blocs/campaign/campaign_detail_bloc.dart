import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CampaignDetailBloc {
  CampaignRepository _repository;
  CampaignDetailBloc(this._repository);

  final _campaignDetail = BehaviorSubject<CampaignDetailModel>();

  Function(CampaignDetailModel) get updateCampaignDetail =>
      _campaignDetail.sink.add;
  Stream<CampaignDetailModel> get data => _campaignDetail.stream;

  fetchCampaignDetail(int id) {
    final result = _repository.campaignDetail(id);

    result.listen((event) {
      event.fold((error) {
        print("Something error when request campaign detail $error");

        return _campaignDetail.addError(error);
      }, (value) => updateCampaignDetail(value));
    });
  }

  dispose() {
    _campaignDetail.close();
  }
}
