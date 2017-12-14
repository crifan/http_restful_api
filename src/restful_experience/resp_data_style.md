# RESTful API接口返回数据的格式和风格
常见返回的数据的格式一般用JSON。

对应返回的内容，常见的做法是：

* `code`：http的status code
  * 如果有自己定义的额外的错误，那么也可以考虑用自己定义的错误码
* `message`：对应的文字描述信息
  * 如果是出错，则显示具体的错误信息
  * 否则操作成功，一般简化处理都是返回OK
* `data`
  * 对应数据的json字符串
    * 如果是**数组**，则对应最外层是**\[\]**的`list`
    * 如果是**对象**，则对应最外层是**\{\}**的`dict`

比如之前某项目中设计的返回的数据格式：
1. code是200
创建用户
`POST /v1.0/open/register`
返回：
````json
  {
    "code": 200,
    "message": "new user has created",
    "data": {
      "id": "user-4d51faba-97ff-4adf-b256-40d7c9c68103",
      "firstName": "crifan",
      "lastName": "Li",
      "password": "654321",
      "phone": "13511112222",
      "createdAt": "2016-10-24T20:39:46",
      "updatedAt": "2016-10-24T20:39:46"
      ......
    }
  }
````

2. code是401
````json
{
    "code": 401,
    "message": "invalid access token: wrong or expired"
}
````

