# Basalt OS Guide

Basalt OS 清算分账系统的 AI Agent Skill（只读知识库）。

安装后，你的 AI Agent 可以回答关于 Basalt OS 清算分账系统的所有业务问题，包括账户体系、商户管理、清算流程、协议代扣/授权代付、退款退保、提现、费率、角色权限等。

## 快速安装

### 方式一：Shell 安装（推荐）

适用于有终端能力的 Agent（Claude Code、Gemini CLI、Cursor、Codex、Cline 等）：

```bash
npx skills add Joelmes/basalt-os-guide-skill -g
```

`-g` 表示全局安装。`npx skills` 会自动检测 Agent 环境并安装到对应路径。

### 方式二：URL 安装（通用）

适用于没有 shell 的 Agent。复制以下文字发给你的 Agent：

```
安装这个 skill https://github.com/Joelmes/basalt-os-guide-skill，包括所有子文件
```

Agent 会通过 URL 读取仓库中的 SKILL.md 和 references/ 内容，自动创建到本地 skill 目录。

## 知识模块

| 模块 | 文件 | 覆盖内容 |
|---|---|---|
| 商户管理 | `references/merchants.md` | 5 类账户、品牌/总部/区域/门店商户、资金账户、提现 |
| 清算流程 | `references/clearing.md` | 清算订单、清算文件、清算批次、退款扣保 |
| 付款与签约 | `references/payments.md` | 签约授权、协议代扣/授权代付、付款记录、退款 |
| 平台与规则 | `references/global-rules.md` | 平台管理、编码规则、状态机、费率、角色权限 |

## 使用方式

安装后，直接用自然语言向 Agent 提问即可：

- "协议代扣和授权代付有什么区别？"
- "清算批次状态是 PART_SUCCESS 怎么处理？"
- "提现手续费怎么收？商户看到全额吗？"
- "商户子户出金有额度限制吗？"

Agent 会自动根据关键词路由到对应知识模块，返回带接口编号和状态值的精准答案。

## 检查更新

知识库内容会持续更新。安装后对 Agent 说"检查更新"即可从 GitHub 拉取最新版本，自动覆盖本地 skill 文件。

## 工作原理

```
SKILL.md（路由入口）
├── 知识路由表（关键词 → reference 文件映射）
├── 快速 FAQ（高频问题，无需读取 reference）
├── 术语对照表
├── 检查更新（从 GitHub 拉取最新版本）
└── references/（4 个模块化知识文件，按需加载）
```

## License

MIT
