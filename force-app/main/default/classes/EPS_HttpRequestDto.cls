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
  }
  public class HttpRequestBody {
    // public String method;
    // public String endpoint;
  }
}
