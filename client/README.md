# 🌥️ 云笔记客户端（Flutter）

一个多功能的云端笔记客户端，基于 Flutter 构建，支持用户登录、富文本笔记编辑、分类管理、数据统计、自动保存等功能，旨在提供简洁高效、安全可靠的跨平台笔记解决方案。

---

## 🚀 特性功能

- 📌 用户注册 / 登录 / 自动登录
- 📝 新建、编辑、查看笔记（支持富文本 / Markdown）
- 📂 分类 / 标签管理
- 📊 数据统计与分析图表
- 🔐 加密笔记、指纹解锁
- ☁️ 云同步 + 本地缓存
- 🌓 深色模式 / 自定义主题
- 🖥 多端适配（Web / Android / iOS）

---

## 🏗️ 项目架构说明

本项目采用模块化 + MVVM 架构，结合 Provider / Riverpod 进行状态管理，数据层独立封装便于后期替换为任意后端服务（如 Firebase、Supabase、自建 API）。

```
lib/
│
├── main.dart                     # 入口文件
├── app.dart                      # 路由 & 全局配置
│
├── core/                         # 核心通用模块
│   ├── constants/                # 常量（颜色、字体、API地址）
│   ├── utils/                    # 工具函数（时间、Toast、校验等）
│   └── services/                 # 服务类（网络请求、本地存储、加密）
│
├── models/                       # 数据模型（User、Note等）
│
├── providers/                   # 状态管理（Provider / Riverpod / Bloc）
│
├── data/                         # 数据处理层
│   ├── datasources/              # 数据来源（API、本地、模拟）
│   └── repositories/             # 仓储层，封装数据操作逻辑
│
├── views/                        # 页面 UI 层
│   ├── login/                    # 登录相关页面
│   ├── notes/                    # 笔记相关页面（列表、编辑、详情）
│   ├── stats/                    # 统计页
│   ├── settings/                 # 设置页面
│   └── widgets/                  # 可复用组件（按钮、卡片、对话框等）
│
└── routes/                       # 路由定义和跳转逻辑
```