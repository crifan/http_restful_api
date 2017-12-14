# 不好的API设计风格

## 在接口中添加GET/UPDATE等动词
比如：
* `GET /getUser`
* `POST /updateUser`
* `POST /cowfarm/cowfarmemp/new`
* `POST /cowfarm/cowfarmemp/update`
* `POST /cowfarm/cowfarmemp/delete/{id}`
  * 且返回值中包含了data和对应的字段

实际上不应该在接口中加这些动词，而应该通过接口的HTTP方法，GET/UPDATE，来表示接口的含义，比如改为：

* `GET /user`
  * 获取一个用户的信息
* `PUT /user`
  * 更新用户的信息
* `POST /cowfarm/employee`
  * 表示 新建一个农场的雇员/员工
* `PUT /cowfarm/employee`
  * 表示 更新农场雇员/员工的信息
* `DELETE /cowfarm/employee`
  * body中包含json参数
    * ```{"id": xxx}```
    * 表示删除用户
    * 且返回值中，message，code应该正常返回，data就没必要返回了。

## 非改动资源的操作却设计为POST/PUT等方法
对于没有新增/更新/删除等去改动和影响资源的操作，HTTP的方法却设计为POST/PUT等
* 很多公司的后台开发人员，为了偷懒省事，所有的接口都用POST，包括本应该用GET的接口
* 或者是，对API接口设计规范不了解，把仅仅是获取、查询资源，不会改动资源的接口设计成POST

比如，不好的做法：
* 通过id获取task信息：POST /task 
  * body参数：```{ "id": "1234" }```
* 查询出符合条件的任务：`POST /task/query`
  * 参数放在body中 ```{"keyword”:”xxx”, “start”: 0, “limit”: 10}```
应该改为正常的做法：
* `GET /task/{id}`
  * 或：`GET /task?id=1234`
* `GET /task/query?keyword=xxxx&start=0&limit=10`
  * 其中GET的query string在客户端调用API接口时，往往不是手动加上去
  * 而是传递一个字典变量，然后用相关的encode函数去编码出来的
  * 详见：[HTTP知识总结](http://book.crifan.com/books/http_summary/website/)
  * 这样才能确保参数中包含特殊字符，服务器端也能正常接受，比如：
    * 空格 -> `%20`
    * 中文"李茂" -> 被UTF-8编码为 -> `%e6%9d%8e%e8%8c%82`

