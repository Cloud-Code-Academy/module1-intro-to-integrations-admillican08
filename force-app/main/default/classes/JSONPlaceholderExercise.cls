public class JSONPlaceholderExercise {
  // I was having difficulty getting the remote
  // site to accept my formatted JSON, so instead I
  // decided to create a class to create Objects and
  // then use the Apex JSON class to format them for me
  private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';
  // set timeout to 12 seconds, a little longer than the default
  private static final Integer TIMEOUT = 12000;
  private class Placeholder {
    public Integer postId { private set; }
    public String title { private set; }
    public String body { private set; }
    public Integer userId { private set; }

    public Placeholder(
      Integer postId,
      String title,
      String body,
      Integer userId
    ) {
      this.postId = postId;
      this.title = title;
      this.body = body;
      this.userId = userId;
    }
  }

  /**
   * Exercise 1: Implement a GET request to fetch a post by ID
   * Endpoint: /posts/{postId}
   * @param postId - The ID of the post to fetch
   * @return String - The JSON response from the API
   */
  public static String getPostById(Integer postId) {
    Http h = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(BASE_URL + '/posts/' + postId);
    request.setMethod('GET');
    // one or both of these statements was the key to get
    // the remote site to accept Salesforce's JSON formatting
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('User-Agent', 'Salesforce/1.0');
    // set timeout to variable
    request.setTimeout(TIMEOUT);
    HttpResponse resp = h.send(request);
    ApiResponse apiResponse = new ApiResponse(resp);
    String responseMsg = apiResponse.getResponseFromStatus();
    System.debug(responseMsg);
    return responseMsg;
  }

  /**
   * Exercise 2: Implement a POST request to create a new post
   * Endpoint: /posts
   * @param title - The title of the post
   * @param body - The body content of the post
   * @param userId - The user ID creating the post
   * @return String - The JSON response from the API
   */
  public static String createPost(String title, String body, Integer userId) {
    Http h = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(BASE_URL + '/posts');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('User-Agent', 'Salesforce/1.0');
    // set timeout to variable
    request.setTimeout(TIMEOUT);
    // Create the object
    Placeholder placeholder = new Placeholder(null, title, body, userId);
    // serialize it and remove null values
    request.setBody(JSON.serialize(placeholder, true));
    HttpResponse resp = h.send(request);
    ApiResponse apiResponse = new ApiResponse(resp);
    String responseMsg = apiResponse.getResponseFromStatus();
    System.debug(responseMsg);
    return responseMsg;
  }

  /**
   * Exercise 3: Implement a PUT request to update a post
   * Endpoint: /posts/{postId}
   * @param postId - The ID of the post to update
   * @param title - The new title
   * @param body - The new body content
   * @param userId - The user ID
   * @return String - The JSON response from the API
   */
  public static String updatePost(
    Integer postId,
    String title,
    String body,
    Integer userId
  ) {
    Http h = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(BASE_URL + '/posts/' + postId);
    request.setMethod('PUT');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('User-Agent', 'Salesforce/1.0');
    // Create the object with all values
    // set timeout to variable
    request.setTimeout(TIMEOUT);
    Placeholder placeholder = new Placeholder(postId, title, body, userId);
    // serialize it
    request.setBody(JSON.serialize(placeholder, true));
    HttpResponse resp = h.send(request);
    ApiResponse apiResponse = new ApiResponse(resp);
    String responseMsg = apiResponse.getResponseFromStatus();
    System.debug(responseMsg);
    return responseMsg;
  }

  /**
   * Exercise 4: Implement a PATCH request to partially update a post
   * Endpoint: /posts/{postId}
   * @param postId - The ID of the post to patch
   * @param title - The new title (can be null)
   * @return String - The JSON response from the API
   */
  public static String patchPostTitle(Integer postId, String title) {
    Http h = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(BASE_URL + '/posts/' + postId);
    request.setMethod('PATCH');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('User-Agent', 'Salesforce/1.0');
    // set timeout to 12 seconds
    request.setTimeout(TIMEOUT);
    // Create the object with only one value, nulls for the rest
    Placeholder placeholder = new Placeholder(null, title, null, null);
    // Serialize the one value and suppress the nulls
    request.setBody(JSON.serialize(placeholder, true));
    HttpResponse resp = h.send(request);
    ApiResponse apiResponse = new ApiResponse(resp);
    String responseMsg = apiResponse.getResponseFromStatus();
    System.debug(responseMsg);
    return responseMsg;
  }

  /**
   * Exercise 5: Implement a DELETE request to remove a post
   * Endpoint: /posts/{postId}
   * @param postId - The ID of the post to delete
   * @return Integer - The HTTP status code from the response
   */
  public static Integer deletePost(Integer postId) {
    Http h = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(BASE_URL + '/posts/' + postId);
    request.setMethod('DELETE');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('User-Agent', 'Salesforce/1.0');
    // set timeout to 100 seconds
    request.setTimeout(TIMEOUT);
    HttpResponse resp = h.send(request);
    return resp.getStatusCode();
  }
}
