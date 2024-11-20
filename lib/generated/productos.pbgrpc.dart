//
//  Generated code. Do not modify.
//  source: productos.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'productos.pb.dart' as $0;

export 'productos.pb.dart';

@$pb.GrpcServiceName('product.ProductService')
class ProductServiceClient extends $grpc.Client {
  static final _$subscribeToProductUpdates = $grpc.ClientMethod<$0.ProductUpdateRequest, $0.ProductUpdateResponse>(
      '/product.ProductService/SubscribeToProductUpdates',
      ($0.ProductUpdateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ProductUpdateResponse.fromBuffer(value));

  ProductServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.ProductUpdateResponse> subscribeToProductUpdates($0.ProductUpdateRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeToProductUpdates, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('product.ProductService')
abstract class ProductServiceBase extends $grpc.Service {
  $core.String get $name => 'product.ProductService';

  ProductServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ProductUpdateRequest, $0.ProductUpdateResponse>(
        'SubscribeToProductUpdates',
        subscribeToProductUpdates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.ProductUpdateRequest.fromBuffer(value),
        ($0.ProductUpdateResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ProductUpdateResponse> subscribeToProductUpdates_Pre($grpc.ServiceCall call, $async.Future<$0.ProductUpdateRequest> request) async* {
    yield* subscribeToProductUpdates(call, await request);
  }

  $async.Stream<$0.ProductUpdateResponse> subscribeToProductUpdates($grpc.ServiceCall call, $0.ProductUpdateRequest request);
}
