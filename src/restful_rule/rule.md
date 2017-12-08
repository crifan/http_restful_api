# 通用设计规则

资源：往往对应着后台系统中对象，比如一个用户User，一个待办事项todo item，一个任务Task等等

用对应的接口表示要对资源进行何种操作，想要实现什么目的：

| HTTP Verb=HTTP方法 | 操作类型=CRUD | 返回 | 说明 |
| :--- | :--- | :--- | :--- |
| POST | Create创建 | <ul><li>正常</li><ul><li>最常用：200 (OK)</li><li>不太常用：201 (Created)</li></ul><li>异常</li><ul><li>404 (Not Found)</li><li>409 (Conflict)</li></ul></ul>| |
| GET | Read读取 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li></ul></ul> |  |
| PUT/UPDATE/PATCH | Update/Replace更新/替换 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常</li><ul><li>405 (Method Not Allowed)</li><li>204 (No Content)</li><li>404 (Not Found)</li></ul></ul> | <ul><li>PUT，UPDATE，PATCH 都常被用于 更新（已有的）某个资源</li><li>最最常用：PUT，另外也有用POST用作PUT去更新资源的</li><ul> |
| DELETE | Delete删除 | <ul><li>正常：</li><ul><li>200 (OK)</li><li>204 (No Content)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li><li>405 (Method Not Allowed)</li></ul></ul> |  |


## RESTful的某个类似于外卖的项目的API
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

