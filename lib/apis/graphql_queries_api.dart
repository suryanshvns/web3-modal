class GraphqlQueriesApi {
  GraphqlQueriesApi._();

  static String getChallengeId = '''
  query Challenge(\$request: ChallengeRequest!) {
    challenge(request: \$request) {
      id
      text
    }
  }
''';

  static String getProfileId = '''
  query Items(\$request: ProfilesManagedRequest!) {
    profilesManaged(request: \$request) {
      items {
        id
      }
    }
  }
''';

  static String getLensId = '''
  query Profiles(\$request: ProfilesRequest!) {
    profiles(request: \$request) {
      items {
        id
      }
    }
  }
''';

  static String profileQuery = '''
   query Profile(\$request: ProfileRequest!) {
  profile(request: \$request) {
    id
    handle {
      id
      fullHandle
      namespace
      localName
      suggestedFormatted {
        full
        localName
      }
      linkedTo {
        contract {
          address
          chainId
        }
        nftTokenId
      }
      ownedBy
    }
    ownedBy {
      address
    }
    createdAt
    stats {
      id
      followers
      following
      comments
      posts
      mirrors
      quotes
      publications
      reactions
      reacted
      countOpenActions
    }
    operations {
      id
      isBlockedByMe {
        value
        isFinalisedOnchain
      }
      isFollowedByMe {
        value
        isFinalisedOnchain
      }
      isFollowingMe {
        value
        isFinalisedOnchain
      }
      canBlock
      canUnblock
      canFollow
      canUnfollow
    }
    interests
    guardian {
      protected
      cooldownEndsOn
    }

    onchainIdentity {
      proofOfHumanity

      sybilDotOrg {
        verified
      }
      worldcoin {
        isHuman
      }
    }
    metadata {
      displayName
      bio
      rawURI
      appId
      attributes {
        type
        key
        value
      }

      coverPicture {
        optimized {
          uri
        }
      }
      picture{
        ... on ImageSet {
          optimized {
            mimeType
            uri
          }
        }
        ... on NftImage {
          image {
            optimized {
              mimeType
              uri
            }
          }
        }
      }
    }
    signless
    sponsor
  }
}

  ''';

  static String followingQuery = '''
  query Items(\$request: FollowingRequest!) {
    following(request: \$request) {
      items {
        id
      handle {
        id
        fullHandle
        namespace
        localName
        suggestedFormatted {
          full
          localName
        }
        linkedTo {
          contract {
            address
            chainId
          }
          nftTokenId
        }
        ownedBy
      }
      ownedBy {
        address
      }
      createdAt
      stats {
        id
        followers
        following
        comments
        posts
        mirrors
        quotes
        publications
        reactions
        reacted
        countOpenActions
      }
      operations {
        id
        isBlockedByMe {
          value
          isFinalisedOnchain
        }
        isFollowedByMe {
          value
          isFinalisedOnchain
        }
        isFollowingMe {
          value
          isFinalisedOnchain
        }
        canBlock
        canUnblock
        canFollow
        canUnfollow
      }
      interests
    
      onchainIdentity {
        proofOfHumanity
        
        sybilDotOrg {
          verified
          
        }
        worldcoin {
          isHuman
        }
      }
      metadata {
        displayName
        bio
        rawURI
        appId
        attributes {
          type
          key
          value
        }
        
        coverPicture {
          optimized {
            uri
          }
        }
      }
      signless
      sponsor
      }
    }
  }
''';

  static String followersQuery = '''
  query Items(\$request: FollowingRequest!) {
    following(request: \$request) {
      items {
        id
      handle {
        id
        fullHandle
        namespace
        localName
        suggestedFormatted {
          full
          localName
        }
        linkedTo {
          contract {
            address
            chainId
          }
          nftTokenId
        }
        ownedBy
      }
      ownedBy {
        address
      }
      createdAt
      stats {
        id
        followers
        following
        comments
        posts
        mirrors
        quotes
        publications
        reactions
        reacted
        countOpenActions
      }
      operations {
        id
        isBlockedByMe {
          value
          isFinalisedOnchain
        }
        isFollowedByMe {
          value
          isFinalisedOnchain
        }
        isFollowingMe {
          value
          isFinalisedOnchain
        }
        canBlock
        canUnblock
        canFollow
        canUnfollow
      }
      interests
    
      onchainIdentity {
        proofOfHumanity
        
        sybilDotOrg {
          verified
          
        }
        worldcoin {
          isHuman
        }
      }
      metadata {
        displayName
        bio
        rawURI
        appId
        attributes {
          type
          key
          value
        }
        
        coverPicture {
          optimized {
            uri
          }
        }
      }
      signless
      sponsor
      }
    }
  }
''';

  static String postsQuery = '''
query Publications(\$request: PublicationsRequest!) {
  publications(request: \$request) {
    items {
      ... on Post {
        id
        createdAt
        by {
          id
          handle {
            id
            fullHandle
            namespace
            localName
            suggestedFormatted {
              full
              localName
            }
            linkedTo {
              contract {
                address
                chainId
              }
              nftTokenId
            }
            ownedBy
          }
          ownedBy {
            address
          }
          createdAt
          stats {
            id
            followers
            following
            comments
            posts
            mirrors
            quotes
            publications
            reactions
            reacted
            countOpenActions
          }
          operations {
            id
            isBlockedByMe {
              value
              isFinalisedOnchain
            }
            isFollowedByMe {
              value
              isFinalisedOnchain
            }
            isFollowingMe {
              value
              isFinalisedOnchain
            }
            canBlock
            canUnblock
            canFollow
            canUnfollow
          }
          interests
          guardian {
            protected
            cooldownEndsOn
          }
          onchainIdentity {
            proofOfHumanity

            sybilDotOrg {
              verified
            }
            worldcoin {
              isHuman
            }
          }
          metadata {
            displayName
            bio
            rawURI
            appId
            attributes {
              type
              key
              value
            }

            coverPicture {
              optimized {
                uri
              }
            }
            picture {
              ... on ImageSet {
                optimized {
                  mimeType
                  uri
                }
              }
              ... on NftImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
            }
          }

          signless
          sponsor
        }
        stats {
          id
          comments
          mirrors
          quotes
          reactions
          countOpenActions
          bookmarks
        }
        operations {
          isNotInterested
          hasBookmarked
          hasReported
          canAct
          hasActed {
            value
            isFinalisedOnchain
          }

          hasReacted
          canComment
          canMirror
          canQuote
          hasMirrored
          canDecrypt {
            result
            reasons
            extraDetails
          }
        }
        metadata {
          ... on TextOnlyMetadataV3 {
            content
          }
          ... on ImageMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
              
            }
          }
          ... on AudioMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaAudio {
                audio {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
            title
          }
          ... on VideoMetadataV3 {
            title
            attachments {
              ... on PublicationMetadataMediaVideo {
                video {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

''';

  static String bookMarkQuery =
      '''query Items(\$request: PublicationBookmarksRequest) {
  publicationBookmarks(request: \$request) {
    items {
      ... on Post {
        id
        createdAt
        by {
          id
          handle {
            id
            fullHandle
            namespace
            localName
            suggestedFormatted {
              full
              localName
            }
            linkedTo {
              contract {
                address
                chainId
              }
              nftTokenId
            }
            ownedBy
          }
          ownedBy {
            address
          }
          createdAt
          stats {
            id
            followers
            following
            comments
            posts
            mirrors
            quotes
            publications
            reactions
            reacted
            countOpenActions
          }
          operations {
            id
            isBlockedByMe {
              value
              isFinalisedOnchain
            }
            isFollowedByMe {
              value
              isFinalisedOnchain
            }
            isFollowingMe {
              value
              isFinalisedOnchain
            }
            canBlock
            canUnblock
            canFollow
            canUnfollow
          }
          interests
          guardian {
            protected
            cooldownEndsOn
          }
          onchainIdentity {
            proofOfHumanity

            sybilDotOrg {
              verified
            }
            worldcoin {
              isHuman
            }
          }
          metadata {
            displayName
            bio
            rawURI
            appId
            attributes {
              type
              key
              value
            }

            coverPicture {
              optimized {
                uri
              }
            }
            picture {
              ... on ImageSet {
                optimized {
                  mimeType
                  uri
                }
              }
              ... on NftImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
            }
          }

          signless
          sponsor
        }
        stats {
          id
          comments
          mirrors
          quotes
          reactions
          countOpenActions
          bookmarks
        }
        operations {
          isNotInterested
          hasBookmarked
          hasReported
          canAct
          hasActed {
            value
            isFinalisedOnchain
          }

          hasReacted
          canComment
          canMirror
          canQuote
          hasMirrored
          canDecrypt {
            result
            reasons
            extraDetails
          }
        }
        metadata {
          ... on TextOnlyMetadataV3 {
            content
          }
          ... on ImageMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
            }
          }
          ... on AudioMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaAudio {
                audio {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
            title
          }
          ... on VideoMetadataV3 {
            title
            attachments {
              ... on PublicationMetadataMediaVideo {
                video {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
''';

  static String videoAndImageListQuery = '''
query Items(\$request: PublicationsRequest!) {
  publications(request: \$request) {
    items {
      ... on Post {
        id
        createdAt
        by {
          id
          handle {
            id
            fullHandle
            namespace
            localName
            suggestedFormatted {
              full
              localName
            }
            linkedTo {
              contract {
                address
                chainId
              }
              nftTokenId
            }
            ownedBy
          }
          ownedBy {
            address
          }
          createdAt
          stats {
            id
            followers
            following
            comments
            posts
            mirrors
            quotes
            publications
            reactions
            reacted
            countOpenActions
          }
          operations {
            id
            isBlockedByMe {
              value
              isFinalisedOnchain
            }
            isFollowedByMe {
              value
              isFinalisedOnchain
            }
            isFollowingMe {
              value
              isFinalisedOnchain
            }
            canBlock
            canUnblock
            canFollow
            canUnfollow
          }
          interests
          guardian {
            protected
            cooldownEndsOn
          }
          onchainIdentity {
            proofOfHumanity

            sybilDotOrg {
              verified
            }
            worldcoin {
              isHuman
            }
          }
          metadata {
            displayName
            bio
            rawURI
            appId
            attributes {
              type
              key
              value
            }

            coverPicture {
              optimized {
                uri
              }
            }
            picture {
              ... on ImageSet {
                optimized {
                  mimeType
                  uri
                }
              }
              ... on NftImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
            }
          }

          signless
          sponsor
        }
        stats {
          id
          comments
          mirrors
          quotes
          reactions
          countOpenActions
          bookmarks
        }
        metadata {
          ... on TextOnlyMetadataV3 {
            content
          }
          ... on ImageMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
              
            }
          }
          ... on AudioMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaAudio {
                audio {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
            title
          }
          ... on VideoMetadataV3 {
            title
            attachments {
              ... on PublicationMetadataMediaVideo {
                video {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
''';

  static String commentsQuery = '''
query Publications(\$request: PublicationsRequest!) {
  publications(request: \$request) {
    items {
      ... on Comment {
        id
        createdAt
        by {
          id
          handle {
            id
            fullHandle
            namespace
            localName
            suggestedFormatted {
              full
              localName
            }
            linkedTo {
              contract {
                address
                chainId
              }
              nftTokenId
            }
            ownedBy
          }
          ownedBy {
            address
          }
          createdAt
          stats {
            id
            followers
            following
            comments
            posts
            mirrors
            quotes
            publications
            reactions
            reacted
            countOpenActions
          }
          operations {
            id
            isBlockedByMe {
              value
              isFinalisedOnchain
            }
            isFollowedByMe {
              value
              isFinalisedOnchain
            }
            isFollowingMe {
              value
              isFinalisedOnchain
            }
            canBlock
            canUnblock
            canFollow
            canUnfollow
          }
          interests
          guardian {
            protected
            cooldownEndsOn
          }
          onchainIdentity {
            proofOfHumanity

            sybilDotOrg {
              verified
            }
            worldcoin {
              isHuman
            }
          }
          metadata {
            displayName
            bio
            rawURI
            appId
            attributes {
              type
              key
              value
            }

            coverPicture {
              optimized {
                uri
              }
            }
            picture {
              ... on ImageSet {
                optimized {
                  mimeType
                  uri
                }
              }
              ... on NftImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
            }
          }

          signless
          sponsor
        }
        stats {
          id
          comments
          mirrors
          quotes
          reactions
          countOpenActions
          bookmarks
        }
        operations {
          isNotInterested
          hasBookmarked
          hasReported
          canAct
          hasActed {
            value
            isFinalisedOnchain
          }

          hasReacted
          canComment
          canMirror
          canQuote
          hasMirrored
          canDecrypt {
            result
            reasons
            extraDetails
          }
        }
        metadata {
          ... on TextOnlyMetadataV3 {
            content
          }
          ... on ImageMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaImage {
                image {
                  optimized {
                    mimeType
                    uri
                  }
                }
              }
              
            }
          }
          ... on AudioMetadataV3 {
            attachments {
              ... on PublicationMetadataMediaAudio {
                audio {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
            title
          }
          ... on VideoMetadataV3 {
            title
            attachments {
              ... on PublicationMetadataMediaVideo {
                video {
                  optimized {
                    mimeType
                    uri
                  }
                }
                cover {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

''';

  static String homePageQuery = '''
 query Items(\$request: FeedRequest!) {
  feed(request: \$request) {
    items {
      id
      root {
        ... on Post {
          createdAt
          operations {
            id
            hasReported
            hasReacted
            hasQuoted
            hasMirrored
            hasBookmarked
            canQuote
            canMirror
            canComment
            isNotInterested
            hasActed {
              value
            }
          }
          stats {
            id
            comments
            mirrors
            quotes
            reactions
            countOpenActions
            bookmarks
          }
          metadata {
            ... on TextOnlyMetadataV3 {
              content
            }

            ... on ImageMetadataV3 {
              attachments {
                ... on PublicationMetadataMediaImage {
                  image {
                    optimized {
                      mimeType
                      uri
                    }
                  }
                }
              }
              marketplace {
                description
              }
            }
            ... on AudioMetadataV3 {
              attachments {
                ... on PublicationMetadataMediaAudio {
                  audio {
                    optimized {
                      mimeType
                      uri
                    }
                  }
                  cover {
                    optimized {
                      uri
                    }
                  }
                }
              }
              title
              marketplace {
                description
              }
            }
            ... on VideoMetadataV3 {
              title
              attachments {
                ... on PublicationMetadataMediaVideo {
                  video {
                    optimized {
                      mimeType
                      uri
                    }
                  }
                  cover {
                    optimized {
                      uri
                    }
                  }
                }
              }
              marketplace {
                description
              }
            }
          }
          by {
            handle {
              localName
              suggestedFormatted {
                localName
              }
            }
            metadata {
              displayName
              picture {
                ... on ImageSet {
                  optimized {
                    uri
                  }
                }
                ... on NftImage {
                  image {
                    optimized {
                      uri
                    }
                  }
                }
              }
            }
            id
          }
        }
        ... on Comment {
          createdAt
          by {
            id
            handle {
              localName
              suggestedFormatted {
                localName
              }
            }
            metadata {
              displayName
              picture {
                ... on ImageSet {
                  optimized {
                    uri
                  }
                }
                ... on NftImage {
                  image {
                    optimized {
                      uri
                    }
                  }
                }
              }
            }
          }
          metadata {
            ... on VideoMetadataV3 {
              asset {
                video {
                  optimized {
                    uri
                  }
                }
              }
            }
            ... on ImageMetadataV3 {
              asset {
                image {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
          operations {
            id
            hasReported
            hasReacted
            hasQuoted
            hasMirrored
            hasBookmarked
            canQuote
            canMirror
            canComment
            isNotInterested
            hasActed {
              value
            }
          }
          stats {
            id
            comments
            mirrors
            quotes
            reactions
            countOpenActions
            bookmarks
          }
        }
        ... on Quote {
          createdAt
          by {
            id
            handle {
              localName
              suggestedFormatted {
                localName
              }
            }
            metadata {
              displayName
              picture {
                ... on ImageSet {
                  optimized {
                    uri
                  }
                }
                ... on NftImage {
                  image {
                    optimized {
                      uri
                    }
                  }
                }
              }
            }
          }
          metadata {
            ... on VideoMetadataV3 {
              asset {
                video {
                  optimized {
                    uri
                  }
                }
              }
            }
            ... on ImageMetadataV3 {
              asset {
                image {
                  optimized {
                    uri
                  }
                }
              }
            }
          }
          stats {
            id
            comments
            mirrors
            quotes
            reactions
            countOpenActions
            bookmarks
          }
          operations {
            id
            hasReported
            hasReacted
            hasQuoted
            hasMirrored
            hasBookmarked
            canQuote
            canMirror
            canComment
            isNotInterested
            hasActed {
              value
            }
          }
        }
      }
    }
  }
}

  ''';
}
