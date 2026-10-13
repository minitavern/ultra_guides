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

## 发布到 GitHub

1. **同步内容**（从源仓构建并拷贝到本目录）：

   ```bash
   cd ../tavernmm/guides && yarn sync
   ```

2. **本机配置**：复制 `.publish.env.example` → `.publish.env`，填入 `GIT_EMAIL`。若使用 minitavern 专用 SSH 密钥，在 `~/.ssh/config` 中配置：

   ```
   Host github.com-minitavern
           HostName github.com
           User git
           IdentityFile ~/.ssh/id_ed25519_minitavern
           IdentitiesOnly yes
   ```

   并将 `.publish.env` 中 `REMOTE_URL` 设为：

   ```bash
   REMOTE_URL=git@github.com-minitavern:minitavern/ultra_guides.git
   ```

   公钥需已添加到 **minitavern** 账号的 [SSH keys](https://github.com/settings/keys)。验证：

   ```bash
   ssh -T git@github.com-minitavern
   # Hi minitavern! ...
   ```

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
