# 其他RESTful API心得

## 调用api时要有**http**的前缀，否则出错`Error Domain`

关于其他（比如移动）端去调用REST的api时，要注意一点的是：

记得url地址写全了，最前面要加上`http`或`https`的前缀， 比如：

`http://115.29.173.126:21084/runningfast/api/v1.0/open/smscode`

否则，如果漏了，变成：

`115.29.173.126:21084/runningfast/api/v1.0/open/smscode`

就会报错：

`FAILURE: Error Domain=NSURLErrorDomain Code=-1002 unsupported URL`或`URL not supported`

详见：[【已解决】iOS端用Alamofire访问Flask的rest的api出错：Error Domain=NSURLErrorDomain Code=-1002](http://www.crifan.com/ios_alamofire_http_error_domain_nsurlerrordomain_code_1002)

## api中是否一定要加版本号？

如果是为了设计长期稳定的API接口，则最好是加上版本号v1.0这种写法
`http://[hostname]/todo/api/v1.0/`
但是往往中小型项目不需要这么长期维护和不需要迭代太多版本，则可以考虑不需要版本号，则可以写成：
`http://[hostname]/todo/api/`
即可。

另外了解到：
有些的做法是把API的版本号v1，放到request header中。
->github就是这么做的：[Media Types | GitHub Developer Guide](https://developer.github.com/v3/media/#request-specific-version)

## 设计Restful的接口时，尽量用复数，且统一

即，用`/artists`而不要用`/artist`

## 如果有多个对象，用模块化逻辑，嵌套资源去设计接口

举例：

获取某个（内部id为8的）歌手的所有的专辑：
`GET /artists/8/albums`

## 是否一定要严格按照Restful的规则，用对应的http的method实现对应的功能？

一般来说，不用非常严格的依照规则，尤其是

* UPDATE/PATCH 去更新修改资源
  * 往往为了简化，用PUT表示 更新修改资源即可

不过，有些项目，对方本身就要求设计接口时，严格按照Restful的规则来设计，这时最好用UPDATE/PATCH去更新修改资源。

其他的，见上面的表格总结，典型的是：

* `GET` 获取资源
* `POST` 新建资源
* `PUT` 更新/修改 资源
* `DELETE` 删除资源

## POST时body中无参数时不应该添加`Content-Type:application/json`的Header

比如`POST`时,如果没有Body内容参数传递时，Header中就不要包含 `Content-Type:application/json`

否则，某些服务器就会返回错误。

比如Flask的Flask-Restful的接口就会自动返回：

`code = 0 message = Failed to decode JSON object: No JSON object could be decoded`

-》其意思是，你指定了

`Content-Type:application/json`

所以框架就会去尝试从Body中找JSON字符串，去解析参数

但是发现Body是空的，没有可用的JSON字符串待解析，所以报这个错误。
