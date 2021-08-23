import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CampaignRepository {
  Stream<Either<Failure, CampaignListModel>> getCampaignList();
  Stream<Either<Failure, CampaignListModel>> getCampaignListByUserId();
  Stream<Either<Failure, CampaignDetailModel>> campaignDetail(int id);
}
