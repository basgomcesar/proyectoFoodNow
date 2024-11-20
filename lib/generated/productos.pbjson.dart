//
//  Generated code. Do not modify.
//  source: productos.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use productUpdateRequestDescriptor instead')
const ProductUpdateRequest$json = {
  '1': 'ProductUpdateRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ProductUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productUpdateRequestDescriptor = $convert.base64Decode(
    'ChRQcm9kdWN0VXBkYXRlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use productUpdateResponseDescriptor instead')
const ProductUpdateResponse$json = {
  '1': 'ProductUpdateResponse',
  '2': [
    {'1': 'product_id', '3': 1, '4': 1, '5': 9, '10': 'productId'},
    {'1': 'product_name', '3': 2, '4': 1, '5': 9, '10': 'productName'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'price', '3': 4, '4': 1, '5': 1, '10': 'price'},
    {'1': 'quantity_available', '3': 5, '4': 1, '5': 5, '10': 'quantityAvailable'},
    {'1': 'available', '3': 6, '4': 1, '5': 8, '10': 'available'},
    {'1': 'photo', '3': 7, '4': 1, '5': 12, '10': 'photo'},
    {'1': 'user_id', '3': 8, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ProductUpdateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List productUpdateResponseDescriptor = $convert.base64Decode(
    'ChVQcm9kdWN0VXBkYXRlUmVzcG9uc2USHQoKcHJvZHVjdF9pZBgBIAEoCVIJcHJvZHVjdElkEi'
    'EKDHByb2R1Y3RfbmFtZRgCIAEoCVILcHJvZHVjdE5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlS'
    'C2Rlc2NyaXB0aW9uEhQKBXByaWNlGAQgASgBUgVwcmljZRItChJxdWFudGl0eV9hdmFpbGFibG'
    'UYBSABKAVSEXF1YW50aXR5QXZhaWxhYmxlEhwKCWF2YWlsYWJsZRgGIAEoCFIJYXZhaWxhYmxl'
    'EhQKBXBob3RvGAcgASgMUgVwaG90bxIXCgd1c2VyX2lkGAggASgJUgZ1c2VySWQSFgoGc3RhdH'
    'VzGAkgASgJUgZzdGF0dXM=');

