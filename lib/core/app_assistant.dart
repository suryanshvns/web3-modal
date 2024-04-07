import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3_modal_integration/apis/api_endpoints.dart';
import 'package:web3_modal_integration/apis/api_response.dart';
import 'package:web3_modal_integration/shared_preference/shared_preference_db.dart';

class AppAssistant extends GetxController {
  static AppAssistant get access => Get.find();

  bool isGqlClient = false;
  GraphQLClient? client;

  AuthLink authLink = AuthLink(
      getToken: () async =>
          PrefsDb.getToken == null ? null : 'Bearer ${PrefsDb.getToken}');
  HttpLink httpLink() => HttpLink(
        ApiEndpoints.gqlMainEndPoint,
        defaultHeaders: {
          "Origin": "https://app.soclly.com/",
          "Referer": "https://app.soclly.com/"
        },
      );

  GraphQLClient? get graphQlClient {
    if (isGqlClient) return client;

    Link link = authLink.concat(httpLink());
    client =
        GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
    isGqlClient = false;
    return client;
  }

  static Future<ApiResponse> queryGql(String query,
      {bool refresh = false, Map<String, bool>? variables}) async {
    var qresult = await access.client!.query(
      QueryOptions(
          document: gql(query),
          fetchPolicy:
              refresh ? FetchPolicy.networkOnly : FetchPolicy.cacheFirst,
          variables: variables ?? {}),
    );
    return ApiResponse(
      isSuccess: !qresult.hasException,
      data: qresult.data,
      exception: qresult.exception,
      rawResponse: qresult,
    );
  }
}
