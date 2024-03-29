import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/client/queries/queries.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

class CategoryRepository {
  final GraphQLClient client;

  CategoryRepository({@required this.client}) : assert(client != null);

  Future<List<MainCategoryList>> getCategories() async {
    final result = await client.query(
      QueryOptions(document: gql(GET_ALL_CATEGORIES)),
    );
    if (result.hasException) {
      throw result.exception;
    }
    final data = result.data['mainCategoryListMany'] as List;
    return data.map((e) => MainCategoryList.fromJson(e)).toList();
  }
}
