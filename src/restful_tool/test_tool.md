# HTTP的典型结构



## Request
- URL
- Method
  - GET
    - 获取信息
    - 不会更改服务器内部的数据
  - POST
    - 向服务器发送数据：
      - 创建xxx
      - 更新xxx
        - 准确的说，其实应该用PUT或UPDATE
    - 会更改服务器内部的数据
  - PUT/UPDATE
  - DELETE
  - HEAD：获取资源的元数据
  - OPTIONS：获取信息，关于资源的哪些属性是客户端可以改变的
- Parameters
  - for `GET`
    - `query string`=`qs`=`query parameters`=`params`=`query component`
      - /xxx/xxx?key1=value1&key2=value2
  - for `POST`
    - body
      - JSON
      - url encoded
        - key1=value1&key2=value2
- Headers
  - Content-Type
    - application/json
    - application/json;charset=UTF-8
  - Accept
    - application/json
  - Authorization
    - Bearer 725a7c44b76c45ab95152bcee014ae6e_1
- Other
  - Cookie
  - LocalStorage
  - SessionStorage

## 响应Response

- Status
    - Informational - 1xx
      - 100 CONTINUE
    - Successful - 2xx
      - 200 OK
    - Redirection - 3xx
      - 301 MOVED_PERMANENTLY
    - Client Error - 4xx
      - 400 BAD_REQUEST
      - 401 UNAUTHORIZED
      - 403 FORBIDDEN
      - 404 NOT_FOUND
    - Server Error - 5xx
      - 500 INTERNAL_SERVER_ERROR
- Body
  - raw
    - to json
- Other
  - Cookie



