const CREATE_BUSINESS = r"""
mutation (
  $businessName: String
  $phoneNumber: [String]
  $location: String
  $description: String
  $picture: [String]
) {
  businessCreateOne(
    record: {
      businessName: $businessName
      phoneNumber: $phoneNumber
      location: $location
      description: $description
      pictures: $picture
    }
  ){
    record {
      """ + record + """
    }
  }
}
""";

const ADD_POST = r"""
mutation ($businessId: MongoID!, $posts: [MongoID]){
  businessUpdateById(record: {
    posts: $posts,
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const ADD_EVENT = r"""
mutation ($businessId: MongoID!, $events: [MongoID]){
  businessUpdateById(record: {
    events: $events,
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const UPDATE_DESCRIPTION = r"""
mutation ($businessId: MongoID!, $description: String){
  businessUpdateById(record: {
    description: $description,
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const UPDATE_SPECIALIZATION = r"""
mutation ($businessId: MongoID!, $specialization: String){
  businessUpdateById(record: {
    specialization: $specialization,
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const UPDATE_HISTORY = r"""
mutation ($businessId: MongoID!, $history: String, $establishedIn: String){
  businessUpdateById(record: {
    history: $history,
    establishedIn: $establishedIn
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const UPDATE_ADDRESS_INFO = r"""
mutation ($businessId: MongoID!, $emails: [String], $phoneNumbers: [String], $website: String){
  businessUpdateById(record: {
    emails: $emails,
    phoneNumbers: $phoneNumbers,
    website: $website,
  },
    _id: $businessId
  ) {
    record{
      """ + record + """
    }
  }
}
""";

const record = """
    _id
    businessName
    phoneNumber
    location
    emails
    website
    logoPics
    slogan
    description
    specialization
    categoriesName
    history
    establishedIn
    subscription
    updatedAt
    createdAt
    pictures
    owner {
      fullName
      email
      phoneNumber
      firebaseId
      businesses {
        _id
        businessName
      }
    }
    openHours {
      day
      opens
      closes
    }
    posts {
      _id
      description
      videos
      photos
      createdAt
    }
    events {
      _id
      title
      description
      location
      link
      videos
      photos
      createdAt
    }
    categories {
      _id
      name
      parent
    }
""";