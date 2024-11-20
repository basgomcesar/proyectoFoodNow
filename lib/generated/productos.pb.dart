//
//  Generated code. Do not modify.
//  source: productos.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProductUpdateRequest extends $pb.GeneratedMessage {
  factory ProductUpdateRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  ProductUpdateRequest._() : super();
  factory ProductUpdateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProductUpdateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProductUpdateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'product'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProductUpdateRequest clone() => ProductUpdateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProductUpdateRequest copyWith(void Function(ProductUpdateRequest) updates) => super.copyWith((message) => updates(message as ProductUpdateRequest)) as ProductUpdateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProductUpdateRequest create() => ProductUpdateRequest._();
  ProductUpdateRequest createEmptyInstance() => create();
  static $pb.PbList<ProductUpdateRequest> createRepeated() => $pb.PbList<ProductUpdateRequest>();
  @$core.pragma('dart2js:noInline')
  static ProductUpdateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProductUpdateRequest>(create);
  static ProductUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class ProductUpdateResponse extends $pb.GeneratedMessage {
  factory ProductUpdateResponse({
    $core.String? productId,
    $core.String? productName,
    $core.String? description,
    $core.double? price,
    $core.int? quantityAvailable,
    $core.bool? available,
    $core.List<$core.int>? photo,
    $core.String? userId,
    $core.String? status,
  }) {
    final $result = create();
    if (productId != null) {
      $result.productId = productId;
    }
    if (productName != null) {
      $result.productName = productName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (price != null) {
      $result.price = price;
    }
    if (quantityAvailable != null) {
      $result.quantityAvailable = quantityAvailable;
    }
    if (available != null) {
      $result.available = available;
    }
    if (photo != null) {
      $result.photo = photo;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ProductUpdateResponse._() : super();
  factory ProductUpdateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProductUpdateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProductUpdateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'product'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..aOS(2, _omitFieldNames ? '' : 'productName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'quantityAvailable', $pb.PbFieldType.O3)
    ..aOB(6, _omitFieldNames ? '' : 'available')
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'photo', $pb.PbFieldType.OY)
    ..aOS(8, _omitFieldNames ? '' : 'userId')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProductUpdateResponse clone() => ProductUpdateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProductUpdateResponse copyWith(void Function(ProductUpdateResponse) updates) => super.copyWith((message) => updates(message as ProductUpdateResponse)) as ProductUpdateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProductUpdateResponse create() => ProductUpdateResponse._();
  ProductUpdateResponse createEmptyInstance() => create();
  static $pb.PbList<ProductUpdateResponse> createRepeated() => $pb.PbList<ProductUpdateResponse>();
  @$core.pragma('dart2js:noInline')
  static ProductUpdateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProductUpdateResponse>(create);
  static ProductUpdateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productName => $_getSZ(1);
  @$pb.TagNumber(2)
  set productName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductName() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get price => $_getN(3);
  @$pb.TagNumber(4)
  set price($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrice() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantityAvailable => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantityAvailable($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuantityAvailable() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantityAvailable() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get available => $_getBF(5);
  @$pb.TagNumber(6)
  set available($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAvailable() => $_has(5);
  @$pb.TagNumber(6)
  void clearAvailable() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get photo => $_getN(6);
  @$pb.TagNumber(7)
  set photo($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoto() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoto() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get userId => $_getSZ(7);
  @$pb.TagNumber(8)
  set userId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUserId() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
