class GraphqlMutationsApi {
  GraphqlMutationsApi._();

  static String getAccessToken = '''
  mutation Authenticate(\$request: SignedAuthChallenge!) {
    authenticate(request: \$request) {
      accessToken
      refreshToken
    }
  }
''';

  static String getRefreshToken = '''
  mutation Refresh(\$request: RefreshRequest!) {
    refresh(request: \$request) {
      refreshToken
      accessToken
    }
  }
''';

  static String addLikeReaction = '''
    mutation AddReaction(\$request: ReactionRequest!) {
      addReaction(request: \$request)
    }
  ''';

  static String removeLikeReaction = '''
    mutation RemoveReaction(\$request: ReactionRequest!) {
      removeReaction(request: \$request)
    }
  ''';

  static String addBookMark = '''
    mutation AddPublicationBookmark(\$request: PublicationBookmarkRequest!) {
      addPublicationBookmark(request: \$request)
    }
  ''';

  static String removeBookMark = '''
   mutation RemovePublicationBookmark(\$request: PublicationBookmarkRequest!) {
    removePublicationBookmark(request: \$request)
  }
  ''';
}
