import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3_modal_integration/apis/graphql_mutations.dart';
import 'package:web3_modal_integration/apis/graphql_queries.dart';
import 'package:web3_modal_integration/apis/graphql_reponse.dart';

class GraphqlRequest {
  static Future<GraphQlResponse> get(String query,
      [Map variables = const {}]) async {
    variables = variables.isEmpty ? {} : (variables);
    var res = await GraphQlQueries.queryWithOptions(
      QueryOptions(
        document: gql(query),
        variables: {
          ...variables,
          if (variables['publicId'] != null) 'hasPublicId': true
        }.cast(),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return GraphQlResponse.success(
        meta: res.data?['queryResult']?['meta'] ?? {}, data: res.data);
  }

  static Future<GraphQlResponse> save(String query,
      [Map variables = const {}, bool rawQuery = false]) async {
    log(variables.toString());
    var res = await GraphqlMutations.mutateWithOptions(
        MutationOptions(document: gql(query), variables: (variables).cast()));
    if (rawQuery) {}
    List? errors = res.data?['errors'];

    return GraphQlResponse(
      isSuccess: res.data != null,
      data: res.data,
      exception: errors,
    );
  }
}
