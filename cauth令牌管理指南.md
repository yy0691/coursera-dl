# cauth令牌管理指南

## 📋 目录
- [什么是cauth令牌](#什么是cauth令牌)
- [获取cauth令牌](#获取cauth令牌)
- [设置环境变量](#设置环境变量)
- [更新令牌](#更新令牌)
- [故障排除](#故障排除)
- [安全建议](#安全建议)

---

## 🔍 什么是cauth令牌？

### 定义
cauth令牌是Coursera的身份验证令牌，用于API访问和课程内容下载。它类似于登录凭证，但专门用于程序化访问。

### 特点
- **唯一性**：每个用户都有独特的cauth令牌
- **时效性**：令牌会定期过期，需要更新
- **安全性**：包含敏感信息，需要妥善保管
- **必要性**：下载课程内容必须提供有效令牌

### 格式
cauth令牌通常是一个长字符串，包含字母、数字和特殊字符：
```
ux6J1FwGS4CiLyFdTGAVCtYndA5z_0lXTQy8QPMGS7H-X6m-NC8v1QV0ES7C5PL-GXp1CNx3-T74CxKibXyvMA...
```

---

## 🔑 获取cauth令牌

### 方法1：从浏览器Cookie获取（推荐）

#### Chrome/Edge浏览器
1. **打开Coursera网站**
   - 访问 [https://www.coursera.org](https://www.coursera.org)
   - 登录你的账户

2. **打开开发者工具**
   - 按 `F12` 键
   - 或右键点击页面 → "检查"

3. **找到Cookie**
   - 点击 `Application` 标签（Chrome）或 `存储` 标签（Edge）
   - 在左侧面板找到 `Cookies`
   - 展开 `https://www.coursera.org`

4. **复制cauth值**
   - 找到名为 `cauth` 的cookie
   - 双击 `Value` 列中的值
   - 复制整个字符串

#### Firefox浏览器
1. **打开Coursera网站并登录**
2. **打开开发者工具**：按 `F12`
3. **切换到存储标签**
4. **找到Cookie**：左侧面板 → Cookies → coursera.org
5. **复制cauth值**

### 方法2：从网络请求获取

#### Chrome/Edge
1. **打开课程页面**
2. **按F12打开开发者工具**
3. **切换到Network标签**
4. **刷新页面**
5. **找到任意请求**（如课程页面请求）
6. **查看Request Headers**
7. **找到Cookie字段**，其中包含 `cauth=...`

#### Firefox
1. **打开课程页面**
2. **按F12打开开发者工具**
3. **切换到网络标签**
4. **刷新页面**
5. **点击任意请求**
6. **查看请求头** → Cookie字段

### 方法3：使用浏览器扩展

#### Cookie Editor扩展
1. **安装Cookie Editor扩展**
2. **访问Coursera网站**
3. **点击扩展图标**
4. **搜索cauth**
5. **复制值**

---

## ⚙️ 设置环境变量

### Windows PowerShell（推荐）

#### 临时设置（当前会话有效）
```powershell
$env:COURSERA_CAUTH = "你的cauth令牌"
```

#### 永久设置（用户级别）
```powershell
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "你的cauth令牌", "User")
```

#### 永久设置（系统级别，需要管理员权限）
```powershell
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "你的cauth令牌", "Machine")
```

### Windows命令提示符

#### 临时设置
```cmd
set COURSERA_CAUTH=你的cauth令牌
```

#### 永久设置（用户级别）
```cmd
setx COURSERA_CAUTH "你的cauth令牌"
```

#### 永久设置（系统级别）
```cmd
setx COURSERA_CAUTH "你的cauth令牌" /M
```

### 图形界面设置

#### Windows 10/11
1. **打开系统设置**
   - 按 `Win + I`
   - 或右键"此电脑" → "属性" → "高级系统设置"

2. **环境变量设置**
   - 点击"环境变量"按钮
   - 在"用户变量"部分点击"新建"
   - 变量名：`COURSERA_CAUTH`
   - 变量值：你的cauth令牌
   - 点击"确定"

---

## 🔄 更新令牌

### 何时需要更新令牌？

#### 自动过期
- **时间**：通常几周到几个月
- **表现**：下载时出现认证错误
- **频率**：建议每月检查一次

#### 手动更新场景
- 更换Coursera账户
- 重新安装系统
- 令牌泄露需要更换
- 长期未使用需要刷新

### 更新步骤

#### 1. 获取新令牌
按照[获取cauth令牌](#获取cauth令牌)的方法获取新的令牌

#### 2. 更新环境变量
```powershell
# 更新用户级环境变量
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "新的cauth令牌", "User")

# 验证更新
echo $env:COURSERA_CAUTH
```

#### 3. 测试新令牌
```bash
# 测试下载
download-coursera-chinese.bat product-management-an-introduction
```

### 批量更新脚本

#### PowerShell脚本
```powershell
# 更新cauth令牌脚本
param(
    [Parameter(Mandatory=$true)]
    [string]$NewToken
)

# 更新环境变量
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", $NewToken, "User")

# 验证更新
$currentToken = [Environment]::GetEnvironmentVariable("COURSERA_CAUTH", "User")
if ($currentToken -eq $NewToken) {
    Write-Host "✅ cauth令牌更新成功！" -ForegroundColor Green
} else {
    Write-Host "❌ cauth令牌更新失败！" -ForegroundColor Red
}

# 显示当前令牌（前20个字符）
Write-Host "当前令牌: $($currentToken.Substring(0, 20))..." -ForegroundColor Yellow
```

使用方法：
```powershell
.\update-cauth.ps1 "新的cauth令牌"
```

---

## 🔧 故障排除

### 问题1：环境变量未设置

#### 错误信息
```
环境变量 COURSERA_CAUTH 未设置
```

#### 解决方案
```powershell
# 检查环境变量
echo $env:COURSERA_CAUTH

# 如果为空，重新设置
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "你的cauth令牌", "User")

# 重新启动PowerShell或命令提示符
```

### 问题2：令牌格式错误

#### 错误信息
```
Invalid cauth token format
```

#### 解决方案
1. **检查令牌长度**：cauth令牌通常很长（100+字符）
2. **检查特殊字符**：确保没有多余的空格或换行符
3. **重新复制**：从浏览器重新复制令牌

### 问题3：令牌过期

#### 错误信息
```
Unauthorized: Invalid or expired token
```

#### 解决方案
1. **重新获取令牌**：按照获取步骤重新获取
2. **更新环境变量**：使用新令牌更新环境变量
3. **测试下载**：验证新令牌是否有效

### 问题4：权限不足

#### 错误信息
```
Access denied: Insufficient permissions
```

#### 解决方案
1. **检查课程访问权限**：确保你有该课程的访问权限
2. **验证账户状态**：确保Coursera账户状态正常
3. **重新登录**：在浏览器中重新登录Coursera

### 问题5：网络问题

#### 错误信息
```
Network error: Unable to connect
```

#### 解决方案
1. **检查网络连接**：确保网络连接正常
2. **尝试VPN**：如果在中国大陆，可能需要VPN
3. **检查防火墙**：确保防火墙没有阻止连接

---

## 🔒 安全建议

### 令牌保护

#### 不要分享令牌
- ❌ 不要在聊天中发送令牌
- ❌ 不要将令牌提交到代码仓库
- ❌ 不要在不安全的网站上输入令牌

#### 定期更新
- ✅ 建议每月更新一次令牌
- ✅ 发现异常活动立即更新
- ✅ 更换设备后更新令牌

### 环境变量安全

#### 用户级别 vs 系统级别
- **用户级别**：只有当前用户可以访问（推荐）
- **系统级别**：所有用户都可以访问（不推荐）

#### 访问控制
```powershell
# 检查环境变量权限
Get-ItemProperty -Path "HKCU:\Environment" -Name "COURSERA_CAUTH"

# 删除环境变量（如果需要）
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", $null, "User")
```

### 备份和恢复

#### 备份令牌
```powershell
# 备份当前令牌到文件
$token = [Environment]::GetEnvironmentVariable("COURSERA_CAUTH", "User")
$token | Out-File -FilePath "cauth-backup.txt" -Encoding UTF8
```

#### 恢复令牌
```powershell
# 从文件恢复令牌
$token = Get-Content -Path "cauth-backup.txt" -Encoding UTF8
[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", $token, "User")
```

---

## 📊 令牌状态检查

### 检查脚本

#### PowerShell检查脚本
```powershell
# cauth令牌状态检查脚本
Write-Host "🔍 检查cauth令牌状态..." -ForegroundColor Yellow

# 检查环境变量
$token = [Environment]::GetEnvironmentVariable("COURSERA_CAUTH", "User")
if ($token) {
    Write-Host "✅ 环境变量已设置" -ForegroundColor Green
    Write-Host "📏 令牌长度: $($token.Length) 字符" -ForegroundColor Cyan
    Write-Host "🔤 令牌前缀: $($token.Substring(0, 20))..." -ForegroundColor Cyan
} else {
    Write-Host "❌ 环境变量未设置" -ForegroundColor Red
    Write-Host "💡 请运行: [Environment]::SetEnvironmentVariable('COURSERA_CAUTH', '你的令牌', 'User')" -ForegroundColor Yellow
}

# 检查当前会话
$sessionToken = $env:COURSERA_CAUTH
if ($sessionToken) {
    Write-Host "✅ 当前会话令牌已加载" -ForegroundColor Green
} else {
    Write-Host "⚠️ 当前会话令牌未加载，请重启PowerShell" -ForegroundColor Yellow
}
```

### 自动检查功能

#### 集成到下载脚本
```powershell
# 在下载脚本中添加令牌检查
if (-not $env:COURSERA_CAUTH) {
    Write-Error "❌ cauth令牌未设置！"
    Write-Host "💡 请先设置环境变量：" -ForegroundColor Yellow
    Write-Host "[Environment]::SetEnvironmentVariable('COURSERA_CAUTH', '你的令牌', 'User')" -ForegroundColor Cyan
    exit 1
}
```

---

## 📝 总结

### 最佳实践
1. **定期更新**：每月检查并更新令牌
2. **安全存储**：使用用户级环境变量
3. **及时备份**：保存令牌到安全位置
4. **监控使用**：注意异常活动

### 常见操作
- **获取令牌**：F12 → Application → Cookies → cauth
- **设置变量**：`[Environment]::SetEnvironmentVariable("COURSERA_CAUTH", "令牌", "User")`
- **验证设置**：`echo $env:COURSERA_CAUTH`
- **更新令牌**：重新设置环境变量

### 故障排除
- **未设置**：重新设置环境变量
- **过期**：重新获取并更新令牌
- **格式错误**：检查令牌完整性
- **权限问题**：验证课程访问权限

---

*cauth令牌管理指南 v1.0 - 2025年1月17日*

