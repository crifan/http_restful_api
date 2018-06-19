# HATEOAS

`HATEOAS` = `Hypermedia As The Engine Of Application State` = `超媒体即应用状态引擎`

谈到`REST`时，往往会提到这个`HATEOAS`。

## 什么是`HATEOAS`？

或者说：

* 为何会有`HATEOAS`？
* `HATEOAS`有什么好处或作用？

找个例子来比喻，就容易理解了：

### `HATEOAS`的例子

比如有个`用户`的对象，或者说**资源**，定义是：

```java
class Customer {
    String name;
}
```

而普通的`REST`，`GET`后返回的信息是：

```json
{
    "name" : "Alice"
}
```

而简单点的`HATEOAS`则返回是：

```json
{
    "name": "Alice",
    "links": [ {
        "rel": "self",
        "href": "http://localhost:8080/customer/1"
    } ]
}
```

好处是：

客户端，不需要再去问提供了接口的服务器端，就可以通过此`HATEOAS`返回的信息中知道一些额外的信息：

* `rel`： 表示`relationship`关系。此处的`self`指的是就是对象`Customer`自己本身。
    * 而更加复杂点的情况中，可能会包含其他的对象，比如`"rel":"customer"`
* `href`：当前对象的完整的`url`地址。

由此可以看出：

如果后台接口支持，或者说实现了`HATEOAS`这套标准（规范），那么：

调用接口的前端（移动端等），就可以像：

用户通过点击页面的`href`的链接地址，而跳转到其他网页，实现浏览网页的过程了。

-> 让调用`REST`的api就可以实现，类似于用户浏览网页的从一个页面跳转到另外一个页面的过程了

-> **而这种超链接方式的api用于告诉用户：该资源的只允许哪些操作（比如`GET`,`POST`)，以及不允许哪些操作（比如`DELETE`）**

-> 从而达到方便用户更加清楚使用你的接口的目的

## 关于`HATEOAS`的最佳实践：**不用`HATEOAS`**

但是`HATEOAS`的缺点也很明显：

就把简单的返回的信息，搞的更加复杂了。

也因此实际在开发`REST`的api过程中，至少我是很少采用这个规范的。

当然，也有和我持同样观点的，比如[这位](https://jeffknupp.com/blog/2014/06/03/why-i-hate-hateoas/)

-》这样会让前端解析API时，倒是变得更加复杂了。显得多此一举和增加复杂度了。

而之前自己在折腾[选择好的Flask的REST API的框架](http://www.crifan.com/choose_better_flask_rest_api_framework_lib)期间，本来觉得`eve`不错，后来就是由于发现`eve`默认使用`HATEOAS`，把返回的`json`搞的太复杂，而放弃`eve`的。

顺带提及一点的是：

针对于`HATEOAS`标准，也还有是别人会用的。

所以一些流行的`REST`的框架中，有些也是内置支持了`HATEOAS`。

比如：`Flask`的`REST`框架：

* [eve](https://github.com/pyeve/eve)
* [ripozo](https://github.com/vertical-knowledge/ripozo)
* [flask-marshmallow](https://github.com/marshmallow-code/flask-marshmallow)

另外，再贴出来一个复杂点的`HATEOAS`的例子，仅供了解：

```json
{
    "content": [ {
        "price": 499.00,
        "description": "Apple tablet device",
        "name": "iPad",
        "links": [ {
            "rel": "self",
            "href": "http://localhost:8080/product/1"
        } ],
        "attributes": {
            "connector": "socket"
        }
    }, {
        "price": 49.00,
        "description": "Dock for iPhone/iPad",
        "name": "Dock",
        "links": [ {
            "rel": "self",
            "href": "http://localhost:8080/product/3"
        } ],
        "attributes": {
            "connector": "plug"
        }
    } ],
    "links": [ {
        "rel": "product.search",
        "href": "http://localhost:8080/product/search"
    } ]
}
```
