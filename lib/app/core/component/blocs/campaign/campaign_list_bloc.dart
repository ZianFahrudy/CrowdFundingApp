import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CampaignListBloc {
  CampaignRepository _repository;
  CampaignListBloc(this._repository);

  final _campaignList = BehaviorSubject<CampaignListModel?>();
  Function(CampaignListModel?) get updateCampaign => _campaignList.sink.add;
  Stream<CampaignListModel?> get data => _campaignList.stream;

  fetchCampaignList() {
    _campaignList.value = null;

    final result = _repository.getCampaignList();

    result.listen((event) {
      event.fold((l) {
        print("Something error when request campaign list $l");
        _campaignList.addError(l);
      }, (value) => updateCampaign(value));
    });
  }

  dispose() {
    _campaignList.close();
  }
}

@injectable
class CampaignListByIdBloc {
  CampaignRepository _repository;
  CampaignListByIdBloc(this._repository);

  final _campaignList = BehaviorSubject<CampaignListModel?>();
  Function(CampaignListModel?) get updateCampaign => _campaignList.sink.add;
  Stream<CampaignListModel?> get data => _campaignList.stream;

  fetchCampaignList() {
    _campaignList.value = null;

    final result = _repository.getCampaignListByUserId();

    result.listen((event) {
      event.fold((l) {
        print("Something error when request campaign list by id $l");
        _campaignList.addError(l);
      }, (value) => updateCampaign(value));
    });
  }

  dispose() {
    _campaignList.close();
  }
}
