import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:web3_modal_integration/core/app_assistant.dart';

class GraphQlQueries {
  static Future<QueryResult<Object?>> queryWithOptions(
      QueryOptions options) async {
    var result = await AppAssistant.access.graphQlClient!.query(options);
    try {
      return result;
    } catch (e) {
      return result;
    }
  }
}
