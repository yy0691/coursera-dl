# Coursera课程下载工具使用手册

## 📖 目录
- [工具概述](#工具概述)
- [环境准备](#环境准备)
- [cauth令牌管理](#cauth令牌管理)
- [脚本使用说明](#脚本使用说明)
- [配置文件说明](#配置文件说明)
- [常见问题解决](#常见问题解决)
- [高级用法](#高级用法)

---

## 🎯 工具概述

本工具基于 `coursera-dl` 开发，专门用于下载Coursera课程内容，具有以下特点：

- ✅ **只下载中文字幕** - 自动过滤其他语言，节省存储空间
- ✅ **环境变量认证** - cauth令牌永久保存，无需重复输入
- ✅ **一键下载** - 简单的命令即可开始下载
- ✅ **智能配置** - 自动优化下载设置
- ✅ **错误处理** - 完善的错误检查和提示

---

## 🔧 环境准备

### 系统要求
- Windows 10/11
- PowerShell 5.0+ 或 命令提示符
- 稳定的网络连接

### 文件结构
```
coursera-dl/
├── download-coursera-chinese.bat      # Windows批处理脚本
├── download-coursera-chinese.ps1     # PowerShell脚本
├── coursera-dl-chinese-only.conf     # 配置文件
├── venv39/                            # Python虚拟环境
├── 使用说明.md                        # 快速使用指南
└── Coursera课程下载工具使用手册.md    # 本手册
```

---

## 🔑 cauth令牌管理

### 什么是cauth令牌？
cauth令牌是Coursera的身份验证令牌，用于验证你的课程访问权限。它类似于登录凭证，但专门用于API访问。

### 如何获取cauth令牌？

#### 方法1：从浏览器获取（推荐）
1. 登录 [Coursera官网](https://www.coursera.org)
2. 按 `F12` 打开开发者工具
3. 切换到 `Application` 或 `存储` 标签
4. 在左侧找到 `Cookies` → `https://www.coursera.org`
5. 找到名为 `cauth` 的cookie
6. 复制其值（通常是一长串字符）

#### 方法2：从网络请求获取
1. 在Coursera课程页面按 `F12`
2. 切换到 `Network` 标签
3. 刷新页面
4. 找到任意请求，查看 `Request Headers`
5. 找到 `Cookie` 字段中的 `cauth=...` 部分

### 设置环境变量

#### 临时设置（当前会话有效）
```powershell
$env:COURSERA_CAUTH = "你的cauth令牌"
```

#### 永久设置（推荐）
```powershell
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "你的cauth令牌", "User")
```

#### 验证设置是否成功
```powershell
echo $env:COURSERA_CAUTH
```

### 更新cauth令牌

当令牌过期或需要更换时：

```powershell
# 更新环境变量
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "新的cauth令牌", "User")

# 验证更新
echo $env:COURSERA_CAUTH
```

### 令牌有效期说明
- **有效期**：通常为几周到几个月
- **过期表现**：下载时出现认证错误
- **更新频率**：建议每月检查一次

---

## 🚀 脚本使用说明

### 方法1：批处理脚本（推荐新手）

#### 基本用法
```bash
download-coursera-chinese.bat [课程名]
```

#### 使用示例
```bash
# 下载产品管理课程
download-coursera-chinese.bat product-management-an-introduction

# 下载机器学习课程
download-coursera-chinese.bat machine-learning-stanford

# 下载Python课程
download-coursera-chinese.bat python-for-everybody
```

#### 脚本功能
- ✅ 自动检查环境变量是否设置
- ✅ 验证课程名是否提供
- ✅ 使用中文字幕配置
- ✅ 显示下载进度
- ✅ 下载完成后暂停显示结果

### 方法2：PowerShell脚本（推荐高级用户）

#### 基本用法
```powershell
.\download-coursera-chinese.ps1 [课程名]
```

#### 使用示例
```powershell
# 下载产品管理课程
.\download-coursera-chinese.ps1 product-management-an-introduction

# 下载机器学习课程
.\download-coursera-chinese.ps1 machine-learning-stanford
```

#### 脚本功能
- ✅ 彩色输出显示
- ✅ 错误处理和异常捕获
- ✅ 参数验证
- ✅ 环境变量检查

### 方法3：直接命令行

#### 基本用法
```bash
.\venv39\Scripts\coursera-dl.exe --cauth $env:COURSERA_CAUTH --config coursera-dl-chinese-only.conf [课程名]
```

#### 使用示例
```bash
.\venv39\Scripts\coursera-dl.exe --cauth $env:COURSERA_CAUTH --config coursera-dl-chinese-only.conf product-management-an-introduction
```

---

## ⚙️ 配置文件说明

### coursera-dl-chinese-only.conf

```ini
# Coursera-dl 配置文件 - 只下载中文字幕
# 使用方法: coursera-dl --config coursera-dl-chinese-only.conf [其他参数]

# 认证设置 - 使用环境变量中的cauth令牌
# 环境变量 COURSERA_CAUTH 已在系统中设置
# 如果环境变量未设置，可以手动指定: --cauth "your_token_here"

# 字幕语言设置 - 只下载中文字幕
subtitle-language=zh-CN

# 其他推荐设置
# 下载视频
download-quizzes=false
download-notebooks=false
download-programming-assignments=false

# 文件命名
file-name-format="{module_index:02d}_{module_name}/{lesson_index:02d}_{lesson_name}"

# 输出设置
quiet=false
verbose=true
```

### 配置项说明

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `subtitle-language` | 字幕语言 | `zh-CN` |
| `download-quizzes` | 下载测验 | `false` |
| `download-notebooks` | 下载笔记本 | `false` |
| `download-programming-assignments` | 下载编程作业 | `false` |
| `file-name-format` | 文件命名格式 | 模块/课程格式 |
| `quiet` | 静默模式 | `false` |
| `verbose` | 详细输出 | `true` |

---

## 🔍 常见问题解决

### 问题1：环境变量未设置
**错误信息**：`环境变量 COURSERA_CAUTH 未设置`

**解决方案**：
```powershell
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "你的cauth令牌", "User")
```

### 问题2：cauth令牌过期
**错误信息**：`认证失败` 或 `Unauthorized`

**解决方案**：
1. 重新获取cauth令牌
2. 更新环境变量：
```powershell
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "新的cauth令牌", "User")
```

### 问题3：课程不存在
**错误信息**：`课程未找到`

**解决方案**：
1. 检查课程名称是否正确
2. 确认你有该课程的访问权限
3. 在Coursera网站上验证课程URL

### 问题4：网络连接问题
**错误信息**：`连接超时` 或 `网络错误`

**解决方案**：
1. 检查网络连接
2. 尝试使用VPN
3. 检查防火墙设置

### 问题5：权限不足
**错误信息**：`权限被拒绝`

**解决方案**：
1. 以管理员身份运行PowerShell
2. 检查文件权限
3. 确认虚拟环境路径正确

---

## 🎓 高级用法

### 自定义下载内容

#### 只下载视频（无字幕）
```bash
.\venv39\Scripts\coursera-dl.exe --cauth $env:COURSERA_CAUTH --subtitle-language "" [课程名]
```

#### 下载特定模块
```bash
.\venv39\Scripts\coursera-dl.exe --cauth $env:COURSERA_CAUTH --config coursera-dl-chinese-only.conf --module "1,2,3" [课程名]
```

#### 下载到指定目录
```bash
.\venv39\Scripts\coursera-dl.exe --cauth $env:COURSERA_CAUTH --config coursera-dl-chinese-only.conf --path "D:\Downloads" [课程名]
```

### 批量下载

#### 创建课程列表文件
创建 `courses.txt`：
```
product-management-an-introduction
machine-learning-stanford
python-for-everybody
```

#### 批量下载脚本
```powershell
$courses = Get-Content "courses.txt"
foreach ($course in $courses) {
    Write-Host "正在下载: $course" -ForegroundColor Green
    .\download-coursera-chinese.ps1 $course
}
```

### 监控下载进度

#### 实时查看下载状态
```bash
# 在另一个终端窗口中运行
Get-ChildItem -Path "课程目录" -Recurse -Filter "*.mp4" | Measure-Object -Property Length -Sum
```

---

## 📞 技术支持

### 获取帮助
```bash
# 查看coursera-dl帮助
.\venv39\Scripts\coursera-dl.exe --help

# 查看详细参数
.\venv39\Scripts\coursera-dl.exe --help | more
```

### 日志文件
下载过程中的日志会显示在终端中，包含：
- 下载进度
- 错误信息
- 文件保存路径

### 联系支持
如果遇到问题，请提供：
1. 错误信息截图
2. 使用的命令
3. 系统环境信息
4. 网络环境描述

---

## 📝 更新日志

### v1.0.0 (2025-01-17)
- ✅ 初始版本发布
- ✅ 支持中文字幕下载
- ✅ 环境变量认证
- ✅ 便捷脚本工具
- ✅ 详细使用文档

---

## ⚠️ 免责声明

本工具仅供学习使用，请遵守Coursera的使用条款和相关法律法规。用户需要确保有合法的课程访问权限。

---

*最后更新：2025年1月17日*

