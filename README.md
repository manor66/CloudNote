# CloudNote

Java多功能新云笔记

开发人员：芒吉，empty，zcc

开发时间：XXX

---

# API 设计方案

## 🔑 **1. 认证模块**

| 接口         | 方法 | 路径               | 功能描述                   |
| ------------ | ---- | ------------------ | -------------------------- |
| 注册         | POST | /note/api/register | 用户注册                   |
| 登录         | POST | /note/api/login    | 用户登录，返回 JWT Token   |
| 获取用户信息 | GET  | /note/api/user     | 获取当前用户信息（需授权） |

---

### 🔧 **注册**

* **POST** `/note/api/register`
* **请求体**：

```json
{
  "email": "test@example.com",
  "password": "123456"
}
```

* **返回**：

```json
{
  "status": 0,
  "message": "注册成功"
}
```

---

### 🔧 **登录**

* **POST** `/note/api/login`
* **请求体**：

```json
{
  "email": "test@example.com",
  "password": "123456"
}
```

* **返回**：

```json
{
  "status": 0,
  "token": "token.here"
}
```

---

### 🔧 **获取用户信息**

* **GET** `/note/api/user`
* **Header**: `Authorization: Bearer <token>`
* **返回**：

```json
{
  "status": 0,
  "data": {
    "id": 1,
    "email": "test@example.com",
    "created_at": "2025-06-20T10:00:00Z"
  }
}
```

---

## 🔑 **2. 笔记模块**

| 接口         | 方法   | 路径                 | 功能描述                 |
| ------------ | ------ | -------------------- | ------------------------ |
| 获取笔记列表 | GET    | /note/api/notes      | 获取当前用户笔记（分页） |
| 创建笔记     | POST   | /note/api/notes      | 新建笔记                 |
| 更新笔记     | PUT    | /note/api/notes/\:id | 更新笔记                 |
| 删除笔记     | DELETE | /note/api/notes/\:id | 删除笔记                 |
| 获取笔记详情 | GET    | /note/api/notes/\:id | 查看单个笔记             |

---

### 🔧 **获取笔记列表（分页）**

* **GET** `/note/api/notes`
* **Header**: `Authorization: Bearer <token>`
* **Query 参数**:

| 参数       | 类型 | 是否必填 | 说明                |
| ---------- | ---- | -------- | ------------------- |
| page       | int  | 否       | 当前页码，默认 `1`  |
| page\_size | int  | 否       | 每页条数，默认 `10` |

* **返回**：

```json
{
  "status": 0,
  "data": {
    "total": 52,
    "page": 2,
    "page_size": 20,
    "pages": 3,
    "notes": [
      {
        "id": 21,
        "title": "第21篇笔记",
        "content": "这是笔记内容",
        "created_at": "2025-06-20T10:00:00Z",
        "updated_at": "2025-06-20T12:00:00Z"
      }
    ]
  }
}
```

---

### 🔧 **创建笔记**

* **POST** `/note/api/notes`
* **Header**: `Authorization: Bearer <token>`
* **请求体**：

```json
{
  "title": "笔记标题",
  "content": "笔记内容"
}
```

* **返回**：

```json
{
  "status": 0,
  "message": "笔记创建成功",
  "id": 5
}
```

---

### 🔧 **更新笔记**

* **PUT** `/note/api/notes/:id`
* **Header**: `Authorization: Bearer <token>`
* **请求体**：

```json
{
  "title": "新标题",
  "content": "新内容"
}
```

* **返回**：

```json
{
  "status": 0,
  "message": "更新成功"
}
```

---

### 🔧 **删除笔记**

* **DELETE** `/note/api/notes/:id`
* **Header**: `Authorization: Bearer <token>`
* **返回**：

```json
{
  "status": 0,
  "message": "删除成功"
}
```

---

### 🔧 **获取笔记详情**

* **GET** `/note/api/notes/:id`
* **Header**: `Authorization: Bearer <token>`
* **返回**：

```json
{
  "status": 0,
  "data": {
    "id": 1,
    "title": "第一篇笔记",
    "content": "这是笔记内容",
    "created_at": "2025-06-20T10:00:00Z",
    "updated_at": "2025-06-20T12:00:00Z"
  }
}
```

---

## 🔐 **3. 认证方式**

* 使用 JWT Bearer Token
* 所有笔记接口均需授权

---

## 🚨 **4. 错误码定义**


### 🔢 **1. 状态码字段**

* 所有接口返回包含 `status` 字段
* `0` 表示请求成功
* 非 `0` 表示发生错误，通过不同值区分错误类型

---

### 🔑 **2. 错误码定义**

| 状态码 | 描述         | 说明                               |
| ------ | ------------ | ---------------------------------- |
| 0      | 成功         | 请求正常处理完成                   |
| 1000   | 参数错误     | 请求参数缺失、格式错误、值非法     |
| 1001   | 资源不存在   | 查询的对象不存在，如笔记 id 不存在 |
| 1002   | 操作失败     | 数据库操作异常、更新失败等         |
| 2000   | 未授权       | 未登录或 Token 过期                |
| 2001   | 无权限       | 已登录，但没有访问该资源的权限     |
| 3000   | 认证失败     | 登录失败，账号或密码错误           |
| 3001   | 用户已存在   | 注册用户时，邮箱已被注册           |
| 3002   | 用户未激活   | 用户注册后未激活或被禁用           |
| 4000   | 服务异常     | 服务器内部错误（未知异常）         |
| 5000   | 依赖服务异常 | 外部服务调用失败，如第三方接口异常 |

---

### 💡 **3. 返回结构示例**

#### ⚠️ **参数错误**

```json
{
  "status": 1000,
  "message": "缺少必填参数 email"
}
```

---

#### ⚠️ **认证失败**

```json
{
  "status": 3000,
  "message": "邮箱或密码错误"
}
```

---

#### ⚠️ **未授权（Token 失效）**

```json
{
  "status": 2000,
  "message": "未登录或登录已过期，请重新登录"
}
```

---

#### ⚠️ **服务器异常**

```json
{
  "status": 4000,
  "message": "服务器内部错误，请稍后重试"
}
```

---

### 🔧 **4. 使用建议**

✅ **分段设计**

* `1xxx`：参数与资源相关错误
* `2xxx`：鉴权与权限相关错误
* `3xxx`：用户认证与注册错误
* `4xxx`：服务器内部错误
* `5xxx`：外部依赖服务错误

✅ **返回一致结构**

* 每个接口返回至少包含 `status` 和 `message`，若有数据则另含 `data` 字段。


---
