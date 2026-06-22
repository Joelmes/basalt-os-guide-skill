# Basalt OS Guide

Basalt OS 清算分账系统的 AI Agent Skill（只读知识库）。

安装后，你的 AI Agent 可以回答关于 Basalt OS 清算分账系统的所有业务问题，包括账户体系、商户入驻、清算流程、协议代扣/授权代付、退款退保、提现、对账、费率、角色权限、外部系统同步等。

## 快速安装

### QoderWork

复制以下命令，直接发给你的 QoderWork Agent：

```
请安装 basalt-os-guide skill：从 https://github.com/Joelmes/basalt-os-guide-skill 克隆到 ~/.qoderworkcn/skills/basalt-os-guide/ 目录
```

Agent 会自动执行 `git clone` 并将文件放入正确位置。

### Claude / Cursor / 其他 Agent

将 Skill 文件复制到你的项目目录中：

```bash
git clone https://github.com/Joelmes/basalt-os-guide-skill.git .claude/skills/basalt-os-guide
```

或手动下载文件，将 `SKILL.md` 和 `references/` 目录放入你的 Agent 能读取的位置。

## 知识模块

| 模块 | 文件 | 覆盖内容 |
|---|---|---|
| 账户体系 | `references/accounts.md` | 5 类账户、前缀规则、余额查询 |
| 商户入驻 | `references/onboarding.md` | 预入驻+激活、POS 绑定、状态流转 |
| 清算流程 | `references/clearing.md` | 12 步全流程、批次提交、资金归集 |
| 付款与协议 | `references/payments.md` | 协议代扣/授权代付、签约/解约 |
| 退款与退保 | `references/refunds.md` | 扣保退保 4 步、deposit.notify 类型 |
| 提现 | `references/withdrawal.md` | 提现流程、费率回收、银行卡绑定 |
| 对账 | `references/reconciliation.md` | 提现费率对账、回单下载 |
| 外部同步 | `references/external-sync.md` | 10 个同步点、双保险机制 |
| 费率 | `references/fees.md` | 各业务费率、计费示例 |
| 角色权限 | `references/roles-permissions.md` | 角色定义、两步审批、商户限权 |
| 问题排查 | `references/troubleshooting.md` | 常见错误、排查步骤、错误码 |

## 使用方式

安装后，直接用自然语言向 Agent 提问即可：

- "协议代扣和授权代付有什么区别？"
- "清算批次状态是 PART_SUCCESS 怎么处理？"
- "deposit.notify 类型 1 和类型 5 有什么区别？"
- "提现手续费怎么收？商户看到全额吗？"

Agent 会自动根据关键词路由到对应知识模块，返回带接口编号和状态值的精准答案。

## 工作原理

```
SKILL.md（路由入口，~100 行）
├── 知识路由表（关键词 → reference 文件映射）
├── 快速 FAQ（10 个高频问题，无需读取 reference）
├── 术语对照表
└── references/（11 个详细知识模块，按需加载）
```

Agent 收到问题后，先从 SKILL.md 的路由表匹配关键词，再读取对应 reference 文件获取完整信息。未命中关键词时回退到 troubleshooting.md。

## 更新

产品功能迭代时，更新 `references/` 下对应模块文件即可。已安装用户重新执行安装命令会覆盖更新。

## License

MIT
