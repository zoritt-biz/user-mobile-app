const GET_USER = r"""
query{
  user{
    _id
    firstName
    middleName
    lastName
    email
    phoneNumber
    image
    firebaseId
    roles
    account{
      verification{
        verified
      }
    }
    status
  }
}
""";

const GET_USER_PROFILE = r"""
query($firebaseId: String){
  userOne(filter: {firebaseId: $firebaseId}){
    _id
    firstName
    middleName
    lastName
    email
    image
    phoneNumber
    firebaseId
    userType
  }
}
""";

const GET_FAVORITES_LIST_MANY = r"""
query{
  user{
    businesses{
      _id
      businessName
      distance
      branch
      phoneNumbers
      emails
      website
      logoPics
      location
      locationDescription
      lngLat{
        coordinates
      }
      description
      pictures
      isLiked
      favoriteList
      categories{
        name
        parent
        autocompleteTerm
      }
      createdAt
      updatedAt
    }
  }
}
""";

const GET_USER_EVENTS = r"""
query{
  user{
    interestedInEvents{
      _id
      title
      description
      location
      link
      startDate
      endDate
      startTime
      endTime
      videos
      photos
      isInterested
      interestedUsers
      likeCount
      owner{
        _id
        businessName
        location
        logoPics
      }
    }
  }
}
""";

const GET_USER_POSTS = r"""
query{
  user{
    likedPosts{
     _id
      description
      descriptionList{
        field
        value
      }
      photos
      videos
      isLiked
      createdAt
      likeCount
      likeList
      owner {
        _id
        businessName
        location
        logoPics
      } 
    }
  }
}
""";
