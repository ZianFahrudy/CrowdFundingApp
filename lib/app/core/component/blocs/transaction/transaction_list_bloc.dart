import 'package:crowd_funding/app/core/component/domain/models/response/transaction_list_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/transaction/transaction_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TransactionListBloc {
  TransactionRepository _repository;

  TransactionListBloc(this._repository);

  final _transactionList = BehaviorSubject<TransactionListModel?>();
  Function(TransactionListModel?) get updateCampaign =>
      _transactionList.sink.add;
  Stream<TransactionListModel?> get data => _transactionList.stream;

  fetchCampaignList() {
    _transactionList.value = null;

    final result = _repository.getTransactionList();

    result.listen((event) {
      event.fold((l) {
        print("Something error when request campaign list $l");
        _transactionList.addError(l);
      }, (value) => updateCampaign(value));
    });
  }

  dispose() {
    _transactionList.close();
  }
}
