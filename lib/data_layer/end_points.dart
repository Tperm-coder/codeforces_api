class EndPoints {
  static BlogEntry blogEntries = BlogEntry();
  static User user = User();
  static Contest contest = Contest();
}

class BlogEntry {
  String comments = "blogEntry.comments", view = "blogEntry.view";
}

class User {
  String blogEntries = "user.blogEntries",
      friends = "user.friends",
      info = "user.info",
      ratedList = "user.ratedList",
      rating = "user.rating",
      status = "user.status";
}

class Contest {
  String hacks = "contest.hacks",
      list = "contest.list",
      ratingChanges = "contest.ratingChanges",
      standings = "contest.standings",
      status = "contest.status";
}
