// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../component/blocs/campaign/campaign_detail_bloc.dart' as _i12;
import '../component/blocs/campaign/campaign_list_bloc.dart' as _i13;
import '../component/blocs/login/login_bloc.dart' as _i11;
import '../component/blocs/transaction/checkout_bloc.dart' as _i10;
import '../component/domain/repository/campaign/campaign_repository.dart'
    as _i8;
import '../component/domain/repository/campaign/campaign_repository_impl.dart'
    as _i9;
import '../component/domain/repository/transaction/transaction_repository.dart'
    as _i4;
import '../component/domain/repository/transaction/transaction_repository_impl.dart'
    as _i5;
import '../component/domain/repository/user/user_repository.dart' as _i6;
import '../component/domain/repository/user/user_repository_impl.dart' as _i7;
import '../infrastructure/dio_module_injection.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioModuleInjectable = _$DioModuleInjectable();
  gh.lazySingleton<_i3.Dio>(() => dioModuleInjectable.dio);
  gh.lazySingleton<_i4.TransactionRepository>(
      () => _i5.TransactionRepositoryImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i6.UserRepository>(
      () => _i7.UserRepositoryImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i8.CampaignRepository>(
      () => _i9.CampaignRepositoryImpl(get<_i3.Dio>()));
  gh.factory<_i10.CheckoutBloc>(
      () => _i10.CheckoutBloc(get<_i4.TransactionRepository>()));
  gh.factory<_i11.LoginBloc>(() => _i11.LoginBloc(get<_i6.UserRepository>()));
  gh.factory<_i12.CampaignDetailBloc>(
      () => _i12.CampaignDetailBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i13.CampaignListBloc>(
      () => _i13.CampaignListBloc(get<_i8.CampaignRepository>()));
  return get;
}

class _$DioModuleInjectable extends _i14.DioModuleInjectable {}
