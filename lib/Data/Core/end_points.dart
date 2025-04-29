class Endpoints {
  ///AUTH
  static const login = 'login';
  static const register = 'register';
  static const resetPassword = 'reset-password';
  static const socialMediaLogin = 'socialMediaLogin';
  static const forgetPassword = 'forgot-password';

  ///USER
  static const getProfile = 'getProfile';
  static const updateProfilePicture = 'updateProfilePicture';
  static const allBookmarkPost = 'AllBookmarkPost';
  static const bookmarkPost = 'bookmarkPost';
  static const deleteBookmarkPost = 'deleteBookmarkPost';
  static const updateToken = 'updateToken';
  static const languageList = 'language/lists';
  static const updateProfile = 'updateProfile';

  ///BLOG DETAILS
  static const addBlogVote = 'addBlogVote';
  static const getBlogVote = 'getBlogVote';

  ///MAIN
  static const searchBlog = 'searchBlog';
  static const getSingleBlogData = 'get-single-blog-data';
  static const eNewsList = 'e-news-list';
  static const liveNewsList = 'live-news-list';
  static const keyList = 'keys/lists';
  static const blogAllList = 'blog-all-list';
  static const blogCategoryList = 'blog-category-list';

  ///ACTIONS
  static const increaseBlogViewCount = 'increaseBlogViewCount';
  static const nextPreviousBlog = 'nextPreviousBlog';
  static const blogSwipe = 'blogSwipe';

  ///ACKNOWLEDGE
  static const settingsList = 'setting-list';
}
