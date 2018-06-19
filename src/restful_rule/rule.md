# 通用设计规则

资源：往往对应着后台系统中对象，比如一个用户User，一个待办事项todo item，一个任务Task等等

用对应的接口表示要对资源进行何种操作，想要实现什么目的：

| HTTP Verb=HTTP方法 | 操作类型=CRUD | 返回值 |
| :--- | :--- | :--- |
| POST | Create创建 | <ul><li>正常</li><ul><li>201 (Created)</li></ul><li>异常</li><ul><li>404 (Not Found)</li><li>409 (Conflict)</li></ul>|
| GET | Read读取 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li></ul> |
| PUT | Replace替换 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常</li><ul><li>405 (Method Not Allowed)</li><li>204 (No Content)</li><li>404 (Not Found)</li></ul> |
| PATCH | Update/Modify更新 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常</li><ul><li>405 (Method Not Allowed)</li><li>204 (No Content)</li><li>404 (Not Found)</li></ul> |
| DELETE | Delete删除 | <ul><li>正常：</li><ul><li>200 (OK)</li><li>204 (No Content)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li><li>405 (Method Not Allowed)</li></ul> |

## 举例：RESTful的某个类似于外卖的项目的API

此处给出之前做过一个项目的RESTful的API，供参考：

* 用户
    * 获取用户ID：支持多个参数，根据参数不同返回对应的值
        * `GET /v1.0/open/userId?type=phone&phone={phone}`
        * `GET /v1.0/open/userId?type=email&email={email}`
        * `GET /v1.0/open/userId?type=facebook&facebookUserId={facebookUserId}`
    * 获取用户信息
        * `GET /v1.0/users/{userId}`
    * 修改用户信息
        * `PUT /v1.0/users/{userId}/info`
    * 修改密码
        * `PUT /v1.0/users/{userId}/password`
* 订单
    * 获取订单任务信息
        * `GET /v1.0/tasks/{taskId}/users/{userId}`
    * 发布任务
        * `POST /v1.0/tasks/users/{userId}`
    * 发单人确认任务信息
        * `PUT /v1.0/tasks/{taskId}/users/{userId}/confirmInfo`

## 常见问题

在具体设计接口时，会遇到一些具体的某些接口，到底应该用哪个`HTTP`的`方法`等方面的问题，整理如下供参考：

### 更新资源到底应该用`PATCH`还是`PUT`?

对于更新一个资源，很多人都会遇到这个问题，到底应该用`PATCH`还是`PUT`？

现解释如下：

HTTP的**官方**规范定义中，其实是：

| HTTP方法 | 主要目的 | 传入参数 | 额外说明或注意事项 |
| :--- | :--- | :--- | :--- |
| `PUT` | 把某个资源的**整体**的信息**替换**掉 | 该资源的 **全部** 的字段 | 换言之：当某些字段没有传的话，则直接设置为`null` |
| `PATCH` | 把某个资源的**部分**信息**更新**掉 | 该资源的（你想要更新数据的那）**部分**的字段 | `PATCH`是在`PUT`之后才提出来，进入官方规范的。目的就是，只更新你传了值的那些字段，保留其他字段的已有的值 |

> #### warning:: 最佳实践==大家的实际做法
> 
> 只不过，现在大家的常见的，实际的做法往往是：
>
> 用`PUT`实现了`PATCH`的效果：
> 
> **使用`PUT`，但只传递`部分`字段，然后更新相应的字段**

#### 举例说明

有一个user用户，信息是：

```json
{
  "name": "zhangsan",
  "email": "xxx@x.com"
}
```

按照PUT的规范来说，如果想要更新这个用户的邮箱，则需要传递：

```json
PUT /user/some_user_id

{
  "name": "zhangsan",
  "email": "yyy@y.com"
}
```

否则如果传递：

```json
PUT /user/some_user_id

{
  "email": "yyy@y.com"
}
```

REST标准中PUT就会认为，你没有其他字段，包括name，则会去设置name为null

-> 这样才是原本想要的replace替换的效果

而如果只是想要更新用户邮箱，应该去用PATCH，传递：

```json
PATCH /user/some_user_id

{
  "email": "yyy@y.com"
}
```

然后才可以实现：只更新email字段，保留其他字段的已有的值

但是现在实际上大部人都是为了省事，也可以说作为最佳实践，用`PUT`代替`PATCH`，传入

```json
PUT /user/some_user_id

{
  "email": "yyy@y.com"
}
```

去实现（只）更新email邮箱，而保留其他（比如用户名name）的效果。

### `POST`创建资源成功后是返回`200`还是`201`?

虽然按照REST协议来说，POST了新建的，应该返回201

但是为了统一处理，以及：很多开发者未必能很好的处理201，所以：

对于操作成功的，都正常返回200即可。

然后在response中返回对应的信息

比如：

新建的对象的详细信息

或者只是新建对象的id

结论：

* **HTTP协议规范**：`POST`创建成功后，应该返回201，以及对应的新的资源的`id`
    * 用户再通过新建资源的`id`，去获取资源详情
* **最佳实践**：大家实际的常见做法则是，直接返回新建资源的所有的详情的`json`，其中包括`id`