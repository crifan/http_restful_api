# 通用设计规则

资源：往往对应着后台系统中对象，比如一个用户User，一个待办事项todo item，一个任务Task等等

用对应的接口表示要对资源进行何种操作，想要实现什么目的：

| HTTP Verb=HTTP方法 | 操作类型=CRUD | 返回 | 说明 |
| :--- | :--- | :--- | :--- |
|  | POST | Create创建 | _ 正常最常用：200\(OK\) _ 不太常用：201 \(Created\)异常404 \(Not Found\)409 \(Conflict\) |
| GET | Read读取 | 正常：200 \(OK\)异常：404 \(Not Found\) |  |
| PUT/UPDATE/PATCH | Update/Replace更新/替换 | 正常：200 \(OK\)异常405 \(Method Not Allowed\)204 \(No Content\)404 \(Not Found\) | PUT，UPDATE，PATCH 都常被用于 更新（已有的）某个资源，最最常用：PUT，另外也有用POST用作PUT去更新资源的 |
| DELETE | Delete删除 | 正常：200 \(OK\)204 \(No Content\)异常：404 \(Not Found\)405 \(Method Not Allowed\) |  |



