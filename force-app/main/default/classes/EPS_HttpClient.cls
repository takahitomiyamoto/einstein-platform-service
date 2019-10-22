public with sharing class EPS_HttpClient {
  @AuraEnabled(cacheable=true)
  public static String sendHttpRequest(String httpRequest) {
    System.debug(LoggingLevel.DEBUG, 'httpRequest: ' + httpRequest);

    try {
      String httpResponse = '{}';
      Object obj = System.JSON.deserialize(
        httpRequest,
        EPS_HttpRequestDto.HttpRequest.class
      );
      EPS_HttpRequestDto.HttpRequest httpRequestObj = (EPS_HttpRequestDto.HttpRequest) obj;
      System.debug(LoggingLevel.DEBUG, 'httpRequest: ' + httpRequestObj);

      HttpRequest request = new HttpRequest();
      request.setMethod(httpRequestObj.method);
      request.setEndpoint(httpRequestObj.endpoint);
      request.setHeader('Authorization', httpRequestObj.header.authorization);
      request.setHeader('Cache-Control', httpRequestObj.header.cacheControl);
      request.setHeader('Content-Type', httpRequestObj.header.contentType);
      // request.setHeader('Accept', httpRequestObj.header.accept);

      System.debug(
        LoggingLevel.DEBUG,
        'body serialize: ' + System.JSON.serialize(httpRequestObj.body, true)
      );

      if (isPost(httpRequestObj.method) || isPut(httpRequestObj.method)) {
        request.setBodyAsBlob(
          Blob.valueOf(System.JSON.serialize(httpRequestObj.body, true))
        );
      }

      Http http = new Http();
      HTTPResponse response = http.send(request);
      String responseBody = response.getBody();
      System.debug(LoggingLevel.DEBUG, 'responseBody: ' + responseBody);

      return responseBody;
    } catch (Exception e) {
      System.debug(System.LoggingLevel.ERROR, e);
      throw new AuraHandledException(e.getMessage());
    }
  }

  private static Boolean isPost(String method) {
    if ('POST'.equals(method)) {
      return true;
    } else {
      return false;
    }
  }

  private static Boolean isPut(String method) {
    if ('PUT'.equals(method)) {
      return true;
    } else {
      return false;
    }
  }
}
