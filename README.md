# CloudNote

Java多功能新云笔记

开发人员：芒吉，empty，zcc

开发时间：XXX

# API 设计方案

---

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
  "id": 1,
  "email": "test@example.com",
  "created_at": "2025-06-20T10:00:00Z"
}
```

---

## 🔑 **2. 笔记模块**

| 接口         | 方法   | 路径                 | 功能描述             |
| ------------ | ------ | -------------------- | -------------------- |
| 获取笔记列表 | GET    | /note/api/notes      | 获取当前用户所有笔记 |
| 创建笔记     | POST   | /note/api/notes      | 新建笔记             |
| 更新笔记     | PUT    | /note/api/notes/\:id | 更新笔记             |
| 删除笔记     | DELETE | /note/api/notes/\:id | 删除笔记             |
| 获取笔记详情 | GET    | /note/api/notes/\:id | 查看单个笔记         |

---

### 🔧 **获取笔记列表**

* **GET** `/note/api/notes`
* **Header**: `Authorization: Bearer <token>`
* **Query 参数**:

| 参数       | 类型 | 是否必填 | 说明                |
| ---------- | ---- | -------- | ------------------- |
| page       | int  | 否       | 当前页码，默认 `1`  |
| page\_size | int  | 否       | 每页条数，默认 `10` |

* **示例请求**:

```
GET /note/api/notes?page=2&page_size=20
Authorization: Bearer <token>
```

* **返回**：

```json
{
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
    },
    ...
  ]
}
```

* **字段说明**:

| 字段       | 说明     |
| ---------- | -------- |
| total      | 笔记总数 |
| page       | 当前页码 |
| page\_size | 每页条数 |
| pages      | 总页数   |
| notes      | 笔记数组 |

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
  "id": 1,
  "title": "第一篇笔记",
  "content": "这是笔记内容",
  "created_at": "2025-06-20T10:00:00Z",
  "updated_at": "2025-06-20T12:00:00Z"
}
```

---

## 🔐 **3. 认证方式**

* 使用 JWT Bearer Token
* 所有笔记接口均需授权

---
