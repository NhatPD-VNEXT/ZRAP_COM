@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '検索ヘルプのデフォルト言語'
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_COM_99_01 as select from zy043t
{
  key div         as Div,
  @Semantics.text: true
  zztypename      as Description,
  @EndUserText.label: 'デフォルト言語キー'
  @Semantics.language: true
  cast( left( zzvalue01, 1 ) as abap.lang ) as DefaultLanguage,
  lastchangedby   as Lastchangedby,
  last_changed_at as LastChangedAt
}
  where div = 'F4_HELP' and zztype = 'A' and zzseqno = '0001'
