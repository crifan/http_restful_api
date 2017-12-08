# 通用设计规则

资源：往往对应着后台系统中对象，比如一个用户User，一个待办事项todo item，一个任务Task等等

用对应的接口表示要对资源进行何种操作，想要实现什么目的：

| HTTP Verb=HTTP方法 | 操作类型=CRUD | 返回 | 说明 |
| :--- | :--- | :--- | :--- |
| POST | Create创建 | <ul><li>正常</li><ul><li>最常用：200 (OK)</li><li>不太常用：201 (Created)</li></ul><li>异常</li><ul><li>404 (Not Found)</li><li>409 (Conflict)</li></ul></ul>| |
| GET | Read读取 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li></ul></ul> |  |
| PUT/UPDATE/PATCH | Update/Replace更新/替换 | <ul><li>正常：</li><ul><li>200 (OK)</li></ul><li>异常</li><ul><li>405 (Method Not Allowed)</li><li>204 (No Content)</li><li>404 (Not Found)</li></ul></ul> | PUT，UPDATE，PATCH 都常被用于 更新（已有的）某个资源，最最常用：PUT，另外也有用POST用作PUT去更新资源的 |
| DELETE | Delete删除 | <ul><li>正常：</li><ul><li>200 (OK)</li><li>204 (No Content)</li></ul><li>异常：</li><ul><li>404 (Not Found)</li><li>405 (Method Not Allowed)</li></ul></ul> |  |



