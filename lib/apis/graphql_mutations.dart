import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3_modal_integration/core/app_assistant.dart';

import 'api_response.dart';

class GraphqlMutations {
  static Future<ApiResponse> mutate(String query,
      {Map variables = const {}, bool ensurePublicId = true}) async {
    MutationOptions options = MutationOptions(
        document: gql(query), variables: Map<String, dynamic>.from(variables));

    QueryResult result = await mutateWithOptions(options);
    if (result.hasException) debugPrint(result.exception.toString());
    return ApiResponse.fromQuerySaveDataResult(result, ensurePublicId);
  }

  static Future<QueryResult<Object?>> mutateWithOptions(
      MutationOptions options) async {
    var result = await AppAssistant.access.graphQlClient!.mutate(options);
    try {
      return result;
    } catch (e) {
      return result;
    }
  }
}
