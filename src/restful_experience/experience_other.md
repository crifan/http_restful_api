# 其他RESTful API心得

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

## 当查询返回的数据多了则：paging分页
如上，如果一个歌手的专辑太多，则应该使用分页`paging`

设计分页的API时返回的数据的格式，可参考之前某项目中的返回的格式：
```json
{
    "code": 200,
    "message": "get task/orders ok",
    "data": {
        "curPageNum": 2,
        "hasNext": false,
        "hasPrev": true,
        "numPerPage": 10,
        "tasks": {
            "task-10b01105-ec53-41bb-810e-720ab468bdf7": {......},
            "task-da013992-e7aa-4ae9-8b6f-bdf621b9fbaa": {......},
            "task-f3c0c660-e7f5-4583-bab2-23c7006dadc4": {......},
            "task-f7a4d0df-3142-444b-a962-83660acd447f": {......}
        },
        "totalNum": 14,
        "totalPageNum": 2
    }
}
```
具体的解释：
Pagination的对象中，最常用到的属性就是：
* `items`：具体有多少个对象，是个列表
    * 然后就可以通过items去获取每个对象的详细信息了。
其他还有一些常用属性：
* `page`：当前的页数
* `pages`：总的页数
* `per_page`：每一页的个数
* `has_prev`：是否有前一页
* `has_next`：是否有后一页
* `total`：（符合当前分页查询的）总（的项目的）个数

具体的Python的`Flask+SQLAlchemy`的API的代码，供参考：
```python
    curPageTaskList = None
    taskPagination = None

    if curRole == UserRole.Initiator:
        taskPagination = Task.query.filter_by(initiatorId=userId).paginate(
            page=curPageNum,
            per_page=numPerPage,
            error_out=False)
    elif curRole == UserRole.Errandor:
        taskPagination = Task.query.filter_by(errandorId=userId).paginate(
            page=curPageNum,
            per_page=numPerPage,
            error_out=False)

    paginatedTaskList = taskPagination.items

    paginatedTaskDict = {}
    for curIdx, eachTask in enumerate(paginatedTaskList):
        paginatedTaskDict[eachTask.id] = marshal(eachTask, task_fields)

    respPaginatedTaskInfoDict = {
        "curPageNum"    : taskPagination.page,
        "totalPageNum"  : taskPagination.pages,
        "numPerPage"    : taskPagination.per_page,
        "hasPrev"       : taskPagination.has_prev,
        "hasNext"       : taskPagination.has_next,
        "totalTaskNum"  : taskPagination.total,
        'tasks'         : paginatedTaskDict
    }
```

详见：
【已解决】Flask-Restful中如何设计分页的API

## 是否一定要严格按照Restful的规则，用对应的http的method实现对应的功能？
一般来说，不用非常严格的依照规则，尤其是
* UPDATE/PATCH 去更新修改资源
    * 往往为了简化，用PUT表示 更新修改资源即可

不过，有些项目，对方本身就要求设计接口时，严格按照Restful的规则来设计，这时最好用UPDATE/PATCH去更新修改资源。

其他的，见上面的表格总结，典型的是：
* GET 获取资源
* POST 新建资源
* PUT 更新/修改 资源
* DELETE 删除资源


## POST时body中无参数时不应该添加`Content-Type:application/json`的Header
比如POST时,如果没有Body内容参数传递时，Header中就不要包含 `Content-Type:application/json`
否则，某些服务器就会返回错误。
比如Flask的Flask-Restful的接口就会自动返回：
`code = 0 message = Failed to decode JSON object: No JSON object could be decoded`
-》其意思是，你指定了
`Content-Type:application/json`
所以框架就会去尝试从Body中找JSON字符串，去解析参数
但是发现Body是空的，没有可用的JSON字符串待解析
所以报这个错误。
