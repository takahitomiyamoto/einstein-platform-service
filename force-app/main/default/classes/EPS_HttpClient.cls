public with sharing class EPS_HttpClient {
  @AuraEnabled(cacheable=true)
  public static String sendHttpRequest(String httpRequest) {
    try {
      String httpResponse = '{}';
      Object obj = System.JSON.deserialize(
        httpRequest,
        EPS_HttpRequestDto.HttpRequest.class
      );
      EPS_HttpRequestDto.HttpRequest httpRequestObj = (EPS_HttpRequestDto.HttpRequest) obj;

      HttpRequest request = new HttpRequest();
      request.setMethod(httpRequestObj.method);
      request.setEndpoint(httpRequestObj.endpoint);
      request.setHeader('Authorization', httpRequestObj.header.authorization);
      request.setHeader('Cache-Control', httpRequestObj.header.cacheControl);
      request.setHeader('Accept', httpRequestObj.header.accept);

      Boolean isPost = isPost(httpRequestObj.method);
      Boolean isPut = isPut(httpRequestObj.method);
      Boolean isMultipartBody = isMultipartBody(
        httpRequestObj.header.contentType
      );

      if (isPost || isPut) {
        String body = '';
        if (isMultipartBody) {
          String boundary = '------------' + String.valueOf(DateTime.now().getTime());

          request.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);

          body += setMultiparams(boundary, httpRequestObj.body);
          body += '--' + boundary + '--' + '\r\n';
        } else {
          request.setHeader('Content-Type', httpRequestObj.header.contentType);
          body = System.JSON.serialize(httpRequestObj.body, true);
        }
        request.setBody(body);
      }

      Http http = new Http();
      HTTPResponse response = http.send(request);
      String responseBody = response.getBody();
      System.debug(System.LoggingLevel.DEBUG, 'responseBody: ' + responseBody);

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

  private static Boolean isMultipartBody(String contentType) {
    if ('multipart/form-data'.equals(contentType)) {
      return true;
    } else {
      return false;
    }
  }

  private static String setMultiparams(String boundary, EPS_HttpRequestDto.HttpRequestBody body) {
    Boolean hasData = body.data != null;
    Boolean hasLanguage = body.language != null;
    Boolean hasName = body.name != null;
    Boolean hasPath = body.path != null;
    Boolean hasType = body.type != null;
    Boolean hasDatasetId = body.datasetId != null;
    Boolean hasEpochs = body.epochs != null;
    Boolean hasLearningRate = body.learningRate != null;
    Boolean hasModelId = body.modelId != null;
    Boolean hasTrainParams = body.trainParams != null;

    String params = '';

    params += setparam(boundary, hasData, 'data', body.data);
    params += setparam(boundary, hasLanguage, 'language', body.language);
    params += setparam(boundary, hasName, 'name', body.name);
    params += setparam(boundary, hasPath, 'path', body.path);
    params += setparam(boundary, hasType, 'type', body.type);
    params += setparam(boundary, hasDatasetId, 'datasetId', body.datasetId);
    params += setparam(boundary, hasEpochs, 'epochs', body.epochs);
    params += setparam(boundary, hasLearningRate, 'learningRate', body.learningRate);
    params += setparam(boundary, hasModelId, 'modelId', body.modelId);
    params += setparam(boundary, hasTrainParams, 'trainParams', body.trainParams);

    return params;
  }

  private static String setparam(String boundary, Boolean has, String name, Object value) {
    String param = '';
    if (has) {
      param += '--' + boundary + '\r\n' + 'Content-Disposition: form-data; ';
      param += 'name="';
      param += name;
      param += '" \r\n\r\n';
      param += value;
      param += '\r\n';
    }
    return param;
  }
}
