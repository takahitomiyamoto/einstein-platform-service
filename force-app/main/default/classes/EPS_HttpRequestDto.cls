public without sharing class EPS_HttpRequestDto {
  public class HttpRequest {
    public String method;
    public String endpoint;
    public HttpRequestHeader header;
    public HttpRequestBody body;
  }
  public class HttpRequestHeader {
    public String authorization;
    public String cacheControl;
    public String contentType;
    public String accept;
  }
  public class HttpRequestBody {
    public String data;
    public String language;
    public String name;
    public String path;
    public String type;
    public Long datasetId;
    public String epochs;
    public String learningRate;
    public String modelId;
    public String trainParams;
    public String document;
    public Long numResults;
    public String sampleId;
  }
}
