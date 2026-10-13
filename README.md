# MiniTavern Ultra Docs（ultra_guides）

[MiniTavern Ultra](https://minitavern.github.io/ultra_website/)（超迷你酒馆）的**官方用户手册**静态站点仓库。

本仓库托管 VitePress 构建产物，经 GitHub Pages 发布为在线文档，涵盖：

- **用户手册**：模型连接、角色卡、聊天、世界书、正则、预设、备份等
- **免费云端**：各厂商免费额度与 Key 配置
- **本地模型**：Ollama、LM Studio、KoboldCPP、llama.cpp 等语言 / 生图部署，以及连接 App

多语言：简体中文、繁体中文、English、Deutsch、日本語、한국어。

> **注意**：本仓只存构建结果，**不要**在此编辑教程正文。正文在同级目录 `tavernmm/guides/**/*.md`，同步后再发布。

在线文档：https://minitavern.github.io/ultra_guides/

---

## 仓库地址

| | |
|---|---|
| GitHub | https://github.com/minitavern/ultra_guides |
| SSH | `git@github.com-minitavern:minitavern/ultra_guides.git` |
| 分支 | `gh-pages`（Pages 根目录） |
| 站点 | https://minitavern.github.io/ultra_guides/ |

---

## 独立 GitHub 账号（minitavern）

本机个人 GitHub 与 **minitavern** 分开：用专用 SSH 密钥 + Host 别名，避免推送到错误账号。

| 文件 | 路径 |
|------|------|
| 私钥 | `~/.ssh/id_ed25519_minitavern` |
| 公钥 | `~/.ssh/id_ed25519_minitavern.pub` |
| SSH 别名 | `~/.ssh/config` → `Host github.com-minitavern` |

默认的 `~/.ssh/id_ed25519`（或 `id_rsa`）仍给个人账号；推本仓必须走别名 `github.com-minitavern`。

### 其他电脑同样配置（推荐：新电脑生成新密钥）

不要拷贝私钥；在新电脑为 minitavern 单独建一把钥匙。

1. **生成密钥**

   ```bash
   ssh-keygen -t ed25519 -C "minitavern@gmail.com" -f ~/.ssh/id_ed25519_minitavern
   ```

2. **公钥加到 minitavern 账号**

   ```bash
   cat ~/.ssh/id_ed25519_minitavern.pub
   ```

   登录 **minitavern** → [SSH keys](https://github.com/settings/keys) → New SSH key → 粘贴。

3. **配置 SSH 别名**（写入 `~/.ssh/config`）

   ```
   Host github.com-minitavern
           HostName github.com
           User git
           IdentityFile ~/.ssh/id_ed25519_minitavern
           IdentitiesOnly yes
   ```

4. **验证身份必须是 minitavern**

   ```bash
   ssh -T git@github.com-minitavern
   # Hi minitavern! ...
   ```

5. **本项目 `.publish.env`**

   复制 `.publish.env.example` → `.publish.env`：

   ```bash
   GIT_NAME=minitavern
   GIT_EMAIL=minitavern@gmail.com
   REMOTE_URL=git@github.com-minitavern:minitavern/ultra_guides.git
   ```

若坚持拷贝本机私钥到新电脑：拷 `id_ed25519_minitavern` + `.pub`，执行 `chmod 600 ~/.ssh/id_ed25519_minitavern`，再做上面第 3–5 步（公钥已在 GitHub 则跳过第 2 步）。更稳妥仍是每台电脑一把独立密钥。

---

## 发布到 GitHub

1. **同步内容**（从源仓构建并拷贝到本目录）：

   ```bash
   cd ../tavernmm/guides && yarn sync
   ```

2. **本机配置**：完成上一节「独立 GitHub 账号」后，确认 `.publish.env` 与 `ssh -T git@github.com-minitavern` 正常。

3. **推送**：

   ```bash
   ./publish.sh
   # 或带提交说明：
   ./publish.sh "更新本地模型教程"
   ```

   脚本会提交当前静态站并 `git push -u origin gh-pages`。

4. **Pages**：仓库 Settings → Pages → Branch: `gh-pages` / root（首次需开启）。

也可手动推送（remote 已指向 GitHub 时）：

```bash
git add -A
git commit -m "更新说明"
git push -u origin gh-pages
```
