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

      // TODO: isPost
      // request.setBody(System.JSON.serialize(httpRequestObj.body));

      System.debug(LoggingLevel.DEBUG, 'request: ' + request);

      Http http = new Http();
      HTTPResponse response = http.send(request);
      String responseBody = response.getBody();
      System.debug(LoggingLevel.DEBUG, 'responseBody: ' + responseBody);

      return responseBody;
    } catch (Exception e) {
      System.debug(System.LoggingLevel.ERROR, e);
      throw new AuraHandledException(e.getMessage());
    }

    //   HttpRequest request = new HttpRequest();
    //   request.setHeader('Authorization', 'Bearer ' + predictionService.getBearerToken());
    //   request.setHeader('Cache-Control', 'no-cache');
    //   request.setTimeout(30000);

    //   request.setMethod('GET');

    //    if (isDelete()) {
    //        request.setMethod('DELETE');
    //    } else if (isPost() || isPut()) {
    //        request.setHeader('Content-Type', Einstein_HttpBodyPart.GetContentType());
    //        request.setBodyAsblob(body);
    //        if (isPut()) {
    //            request.setMethod('PUT');
    //        } else {
    //            request.setMethod('POST');
    //        }
    //    }

    //    request.setEndpoint(url);

    //     Http http = new Http();
    //     HTTPResponse response = http.send(request);

    //    predictionService.isExecuting(true);

    //    updateResponseValues(response);
    // }
  }
}
