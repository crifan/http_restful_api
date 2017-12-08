# HTTP的Header头

HTTP的Header包括两类：

- 请求头=Request Header
- 响应头=Response Header

## HTTP的Header方面的逻辑总结

既然是`Client问, Sever答`的过程，那么基本逻辑就是：

* Client告诉服务器端，自己的Request请求，能够接受的各种信息是什么类型的
  * 所以Request中有很多Accept方面的请求头
    * Accept：能接受（返回）哪些类型
      * 格式：type/sub-type
        * \*/\* 表示任何类型
      * 举例：
        * Accept: application/json
        * Accept: text/plain
        * Accept: text/html
        * Accept: image/jpeg
        * Accept: application/msword
        * Accept: image/png
        * Accept: application/pdf
    * Accept-Charset
      * 能接受的字符集
    * Accept-Encoding
      * 能接受的（编码）压缩类型
        * 比如：gzip，deflate
    * Accept-Language
      * 能接受的语言类型
  * 以及其他一些额外的请求和希望
    * User-Agent:告诉你我是哪种浏览器（所处的操作系统是什么类型）等信息
      * 举例：
        * User-Agent：Mozilla/5.0 \(Windows; U; Windows NT 5.1; zh-CN;rv:1.8.1.14\) Gecko/20080404 Firefox/2.0.0.14
        * User-Agent：Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36
        * User-Agent：Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/604.3.5 (KHTML, like Gecko) Version/11.0.1 Safari/604.3.5
    * Referer：告诉服务器是从（参考）哪个链接去访问的
      * 举例：Referer：
        [https://www.google.co.uk/](https://www.google.co.uk/)
    * Keep-Alive：希望服务器保持此次连接（多长时间）
    * Cache-Control：表示是否使用缓存
    * Connection：完成本次请求的响应后，是否断开连接，是否要等待本次连接的后续请求了
      * Connection: close
      * Connection: keepalive
* Sever返回响应，告诉客户端，自己的响应中数据都是什么类型的
  * 所以Response中有很多Content方面的字段，表示服务器返回的内容的各种类型说明
    * Content-Encoding：此响应中使用了什么压缩方法（gzip，deflate）压缩响应中的对象
      * 表示客户端的你用什么对应的方法去解压缩，才能得到数据的原文
      * 举例：Content-Encoding：gzip
    * Content-Language：用了什么语言
    * Content-Length：数据内容的长度，单位：字节
      * 举例：Content-Length: 2684
    * Content-Type：自己返回的数据是什么格式的
      * 和Request中的Accept对应
      * 举例：Content-Type：application/json
    * Connection：和Request对应
      * Connection: close
      * Connection: keepalive
  * 以及其他一些表示当前信息的情况的
    * Location：一个url地址，表示你想要的资源被转移到别处了，
      * 典型的是发生了302表示自动跳转，告诉你要的东西，换了地址了

## 常见Header举例

* Request Header请求头
  * Accept
    * 代码调用API时：
      * Accept: application/json
      * Accept: application/json; charset=UTF-8
    * 浏览器访问网页时：
      * Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,_/_;q=0.8
  * Content-Type
    * 代码调用API时：
      * Content-Type:application/json
      * Content-Type:application/json; charset=UTF-8
      * Content-Type:application/x-www-form-urlencoded
  * Authorization
    * 代码调用API时：
      * Authorization: Bearer 6k8p8ucshobav531lftkb2f1bv
  * User-Agent
    * 浏览器访问网页时：
      * User-Agent: Mozilla/5.0\(Linux;X11\)
      * User-Agent: Mozilla/5.0 \(Macintosh; Intel Mac OS X 10\_13\_1\) AppleWebKit/537.36 \(KHTML, like Gecko\) Chrome/61.0.3163.100 Safari/537.36
  * Accept-Language
    * 浏览器访问网页时：
      * Accept-Language: zh-CN,zh;q=0.8,en;q=0.6
  * Accept-Encoding
    * 浏览器访问网页时：
      * Accept-Encoding: gzip, deflate, br
* Response Header响应头
  * Content-Type
    * 代码调用API时：
      * Content-Type:application/json
    * 浏览器访问网页时：
      * Content-Type: text/html; charset=utf-8
  * Connection
    * 浏览器访问网页时：
      * Connection: Keep-Alive
  * Content-Encoding
    * 浏览器访问网页时：
      * Content-Encoding: gzip

## 更全更完整的Header

### Request的Header

| Header | 解释 | 示例 |
| :--- | :--- | :--- |
| Accept | 指定客户端能够接收的内容类型 | Accept:text/plain,text/html |
| Accept-Charset | 浏览器可以接受的字符编码集。 | Accept-Charset:iso-8859-5 |
| Accept-Encoding | 指定浏览器可以支持的web服务器返回内容压缩编码类型。 | Accept-Encoding:compress,gzip |
| Accept-Language | 浏览器可接受的语言 | Accept-Language:en,zh |
| Accept-Ranges | 可以请求网页实体的一个或者多个子范围字段 | Accept-Ranges:bytes |
| Authorization | HTTP授权的授权证书 | Authorization:Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ== |
| Cache-Control | 指定请求和响应遵循的缓存机制 | Cache-Control:no-cache |
| Connection | 表示是否需要持久连接。（HTTP 1.1默认进行持久连接） | Connection:close |
| Cookie | HTTP请求发送时，会把保存在该请求域名下的所有cookie值一起发送给web服务器。 | Cookie:$Version=1;Skin=new; |
| Content-Length | 请求的内容长度 | Content-Length:348 |
| Content-Type | 请求的与实体对应的MIME信息 | Content-Type:application/x-www-form-urlencoded |
| Date | 请求发送的日期和时间 | Date:Tue,15 Nov 2010 08:12:31 GMT |
| Expect | 请求的特定的服务器行为 | Expect:100-continue |
| From | 发出请求的用户的Email | From: user@email.com |
| Host | 指定请求的服务器的域名和端口号 | Host: www.zcmhi.com |
| If-Match | 只有请求内容与实体相匹配才有效 | If-Match:“737060cd8c284d8af7ad3082f209582d” |
| If-Modified-Since | 如果请求的部分在指定时间之后被修改则请求成功，未被修改则返回304代码 | If-Modified-Since:Sat,29 Oct 2010 19:43:31 GMT |
| If-None-Match | 如果内容未改变返回304代码，参数为服务器先前发送的Etag，与服务器回应的Etag比较判断是否改变 | If-None-Match:“737060cd8c284d8af7ad3082f209582d” |
| If-Range | 如果实体未改变，服务器发送客户端丢失的部分，否则发送整个实体。参数也为Etag | If-Range:“737060cd8c284d8af7ad3082f209582d” |
| If-Unmodified-Since | 只在实体在指定时间之后未被修改才请求成功 | If-Unmodified-Since:Sat,29 Oct 2010 19:43:31 GMT |
| Max-Forwards | 限制信息通过代理和网关传送的时间 | Max-Forwards:10 |
| Pragma | 用来包含实现特定的指令 | Pragma:no-cache |
| Proxy-Authorization | 连接到代理的授权证书 | Proxy-Authorization:Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ== |
| Range | 只请求实体的一部分，指定范围 | Range:bytes=500-999 |
| Referer | 先前网页的地址，当前请求网页紧随其后,即来路 | Referer:http: |
| TE | 客户端愿意接受的传输编码，并通知服务器接受接受尾加头信息 | TE:trailers,deflate;q=0.5 |
| Upgrade | 向服务器指定某种传输协议以便服务器进行转换（如果支持） | Upgrade:HTTP/2.0,SHTTP/1.3,IRC/6.9,RTA/x11 |
| User-Agent | User-Agent的内容包含发出请求的用户信息 | User-Agent:Mozilla/5.0\(Linux;X11\) |
| Via | 通知中间网关或代理服务器地址，通信协议 | Via:1.0 fred,1.1 nowhere.com \(Apache/1.1\) |
| Warning | 关于消息实体的警告信息 | Warn:199 Miscellaneous warning |

### Response的Header

| Header | 解释 | 示例 |
| :--- | :--- | :--- |
| Accept-Ranges | 表明服务器是否支持指定范围请求及哪种类型的分段请求 | Accept-Ranges: bytes |
| Age | 从原始服务器到代理缓存形成的估算时间（以秒计，非负） | Age: 12 |
| Allow | 对某网络资源的有效的请求行为，不允许则返回405 | Allow: GET, HEAD |
| Cache-Control | 告诉所有的缓存机制是否可以缓存及哪种类型 | Cache-Control: no-cache |
| Content-Encoding | web服务器支持的返回内容压缩编码类型。 | Content-Encoding: gzip |
| Content-Language | 响应体的语言 | Content-Language: en,zh |
| Content-Length | 响应体的长度 | Content-Length: 348 |
| Content-Location | 请求资源可替代的备用的另一地址 | Content-Location: /index.htm |
| Content-MD5 | 返回资源的MD5校验值 | Content-MD5: Q2hlY2sgSW50ZWdyaXR5IQ== |
| Content-Range | 在整个返回体中本部分的字节位置 | Content-Range: bytes 21010-47021/47022 |
| Content-Type | 返回内容的MIME类型 | Content-Type: text/html; charset=utf-8 |
| Date | 原始服务器消息发出的时间 | Date: Tue, 15 Nov 2010 08:12:31 GMT |
| ETag | 请求变量的实体标签的当前值 | ETag: “737060cd8c284d8af7ad3082f209582d” |
| Expires | 响应过期的日期和时间 | Expires: Thu, 01 Dec 2010 16:00:00 GMT |
| Last-Modified | 请求资源的最后修改时间 | Last-Modified: Tue, 15 Nov 2010 12:45:26 GMT |
| Location | 用来重定向接收方到非请求URL的位置来完成请求或标识新的资源 | Location:[http://www.zcmhi.com/archives/94.html](http://www.zcmhi.com/archives/94.html) |
| Pragma | 包括实现特定的指令，它可应用到响应链上的任何接收方 | Pragma: no-cache |
| Proxy-Authenticate | 它指出认证方案和可应用到代理的该URL上的参数 | Proxy-Authenticate: Basic |
| refresh | 应用于重定向或一个新的资源被创造，在5秒之后重定向（由网景提出，被大部分浏览器支持） | Refresh: 5; url=[http://www.zcmhi.com/archives/94.html](http://www.zcmhi.com/archives/94.html) |
| Retry-After | 如果实体暂时不可取，通知客户端在指定时间之后再次尝试 | Retry-After: 120 |
| Server | web服务器软件名称 | Server: Apache/1.3.27 \(Unix\) \(Red-Hat/Linux\) |
| Set-Cookie | 设置Http Cookie | Set-Cookie: UserID=JohnDoe; Max-Age=3600; Version=1 |
| Trailer | 指出头域在分块传输编码的尾部存在 | Trailer: Max-Forwards |
| Transfer-Encoding | 文件传输编码 | Transfer-Encoding:chunked |
| Vary | 告诉下游代理是使用缓存响应还是从原始服务器请求 | Vary: \* |
| Via | 告知代理客户端响应是通过哪里发送的 | Via: 1.0 fred, 1.1 nowhere.com \(Apache/1.1\) |
| Warning | 警告实体可能存在的问题 | Warning: 199 Miscellaneous warning |
| WWW-Authenticate | 表明客户端请求实体应该使用的授权方案 | WWW-Authenticate: Basic |


