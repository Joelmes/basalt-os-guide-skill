---
name: basalt-os-guide
description: 回答 Basalt OS 清算分账系统的使用方法、操作技巧和业务规则问题。覆盖账户体系、商户入驻、清算流程、协议代扣、授权代付、退款退保、提现、对账、费率、角色权限、外部系统对接等全部业务领域。当用户询问 Basalt OS、清算分账、资金归集、商户管理、协议签约、批次提交、退保垫资、提现流程、对账操作等系统使用问题时触发。仅做知识查询，不包含数据读写操作。
version: 1.1.0
---

# Basalt OS 清算分账系统 — 使用指南

> 本 Skill 是 Basalt OS 清算分账系统的只读知识库。回答系统使用方法、操作技巧和业务规则问题，**不执行任何数据读写操作**。

## 回答原则

1. **先路由再回答**：根据用户问题关键词，读取对应 reference 文件获取准确信息
2. **精准引用**：回答时引用具体的接口编号、账户前缀、状态值等细节
3. **标注注意事项**：涉及易错点时主动提醒
4. **中文回答**：默认使用中文

## 知识路由表

根据用户问题中的关键词，读取对应的 reference 文件：

| 关键词 | 读取文件 | 覆盖内容 |
|---|---|---|
| 账户、开户、子户、保证金户、清算专户、结算户、2268、9903、8888、余额查询 | [accounts.md](references/accounts.md) | 5类账户定义、前缀规则、开户方式、余额查询 |
| 入驻、商户注册、预入驻、激活、小程序、POS绑定、审核 | [onboarding.md](references/onboarding.md) | 平台/商户入驻流程、POS绑定、状态流转 |
| 清算、批次、订单上传、补单、清算文件、SFTP、分账、资金归集 | [clearing.md](references/clearing.md) | 12步全流程、订单上送、清算文件、批次提交 |
| 代扣、代付、联动支付、余额划转、协议、签约、解约、合约 | [payments.md](references/payments.md) | 协议代扣/授权代付对比、签约/解约流程、付款操作 |
| 退款、退保、扣保、保证金扣除、部分退款、全额退款 | [refunds.md](references/refunds.md) | 扣保退保4步流程、退款规则、状态机 |
| 提现、银行卡绑定、短信验证、到账 | [withdrawal.md](references/withdrawal.md) | 提现两步流程、费率回收机制 |
| 对账、收钱吧、三联、FTP、差错、回单 | [reconciliation.md](references/reconciliation.md) | 对账流程、数据源、提现费率对账5步 |
| 三联ERP、收钱吧、外部系统、同步、通知 | [external-sync.md](references/external-sync.md) | 10个同步点、通知+查询双保险机制 |
| 费率、手续费、万五、计费、收费 | [fees.md](references/fees.md) | 各业务费率、承担方建议、计费示例 |
| 角色、权限、管理员、财务、操作员 | [roles-permissions.md](references/roles-permissions.md) | 角色定义、操作范围、数据可见性 |
| 报错、失败、异常、卡住、状态不对、怎么办 | [troubleshooting.md](references/troubleshooting.md) | 常见错误、排查步骤、应急处理 |

**路由规则**：
- 问题可能涉及多个模块，读取所有相关文件综合回答
- 如果关键词未命中任何模块，读取 troubleshooting.md 看是否有相关问题
- 如果所有 reference 都无法回答，诚实告知用户该问题超出当前知识库范围

## 快速 FAQ

以下问题可直接回答，无需读取 reference：

**Q: 系统有哪几种账户？**
平台清算专户（9903）、平台保证金户/结算户（8888）、商户子户（2268）、商户保证金户（9903）。商户子户含可用解冻和可用冻结两个子户。

**Q: 协议代扣和授权代付有什么区别？**
协议代扣是体系内子户间划转（免费），用于服务费、采购分配等；授权代付是向体系外付款（0.05%手续费），用于房租、工资、报销等外部支付。

**Q: 清算批次提交为什么要分两步？**
第一步"仅保存"让操作员审核批次内容，第二步"保存并上报"才正式提交给网商银行。设计目的是防止误操作。

**Q: 退保是什么意思？**
清算时如果商户余额不足，网商银行会从平台保证金户（8888）垫付。这笔垫资需要后续退还给平台，退还过程叫"退保"。

**Q: 提现手续费怎么收？**
网商银行收 0.05%（万五），D+1 从平台 8888 户扣除。平台 D+2 通过协议代扣从商户余额中回收。商户看到的是全额到账。

**Q: 收钱吧和三联 ERP 目前哪个在用？**
目前实际订单全部来自收钱吧 FTP 推送。三联 ERP 订单通道是预留设计，尚未启用。

**Q: 商户子户出金有额度限制吗？**
子户间划转无限制。子户对外每月约 40 万额度。如额度不够，可在同一营业执照下注册多个商户号。

**Q: 清算文件命名规则是什么？**
`CARE{日期}_{序号}`，如 `CARE20260509_01`。序号为每日自增两位。

**Q: 通知消息会重复吗？**
会。所有通知都需要做幂等处理，用唯一业务单号去重。

**Q: 哪些 deposit.notify 类型需要处理？**
类型 1（余额不足扣保）、类型 3（尾差扣除）、类型 5（退保结果）需要处理。类型 2 已废弃，类型 4 不可用需人工。

## 术语对照表

| 系统术语 | 网商合约术语 | 说明 |
|---|---|---|
| 协议代扣 | 余额划转 | 体系内子户间划转，免费 |
| 授权代付 | 授权代付 | 向体系外付款，0.05% 手续费 |
| 平台清算专户 | 交易见证账款管理专用编号 / 平台交易资金汇总专管户 | 9903 开头 |
| 网商商户号 | — | 2268 开头，商户在小程序中可见 |
| 外部商户号 | — | 系统生成的商户唯一标识 |
| 平台保证金户 | 结算户 | 8888 开头，平台自有资金 |
| 商户保证金户 | 结算户（商户） | 9903 开头，用于保证金管理 |

## 通用状态速查

| 场景 | 状态值 |
|---|---|
| 入驻/激活 | 0=处理中, 1=成功, 2=失败 |
| 批次清算 | SUCCESS / PART_SUCCESS / FAIL |
| 协议授权 | NOT_EXIST / UN_VALID / VALID / INVALID_TO_BE_CONFIRM |
| 提现/付款/退款 | SUCCESS / FAIL / DEALING |
| 签约申请 | INIT → WAIT_CONFIRM → CONFIRMED → SUCCESS/FAIL/CLOSED |
| 合约状态 | VALID / INVALID / CANCELLED |
| 商户限权 | 1=限权, 2=解除, 3=弱限, 4=延迟(T+N) |
| 通用结果码 | S=成功, F=失败, U=处理中 |

## 飞书知识源（弹性更新）

本 Skill 支持从飞书 Wiki 动态同步最新知识。当产品功能迭代时，只需在飞书中编辑对应文档，然后说"更新知识库"即可同步到本地。

**Wiki 空间**：`Basalt OS 知识库`（space_id: `7654411101060320214`）

| 模块 | 飞书 doc_token | 本地文件 |
|---|---|---|
| 账户体系 | `NnBSdMqGwoWVp5xm3lNcTqb7n3Q` | accounts.md |
| 商户入驻 | `JCsgdjAeooEEKYxpgbCcOFPbnPd` | onboarding.md |
| 清算流程 | `MSX6dXceuo77IOxfArFc1j2Knbg` | clearing.md |
| 付款与协议 | `UT9sdYwEzoaPkRxLNt3cmagnnJg` | payments.md |
| 退款与退保 | `Vtwwdtqi0onEKkx1KlpcweuYnMg` | refunds.md |
| 提现 | `V14udiHAboMpU2xeVdKcrTOcnZg` | withdrawal.md |
| 对账 | `V4fzdwh7eoKcCUx4sutcPzN5nBe` | reconciliation.md |
| 外部同步 | `GQ1od9AmroFfNTxgQrEcUy2snMc` | external-sync.md |
| 费率 | `AoRBd2JQIooyEKxQKqMcEvMtnzG` | fees.md |
| 角色权限 | `EMUUd895toJw3wxZLMEcmc83nlc` | roles-permissions.md |
| 问题排查 | `S797dQPrFoTadCxsxfCcDLeunDh` | troubleshooting.md |

## 知识库同步

当用户说"更新知识库"、"同步知识"、"刷新 skill"、"拉取最新文档"时，执行以下同步流程：

### 前置条件

- 需要 lark-cli 已安装并认证（`lark-cli auth login`）
- 如果 lark-cli 不可用，告知用户本地缓存仍可正常使用，只是无法获取最新内容

### 同步步骤

1. 读取上方「飞书知识源」注册表，获取 11 个模块的 doc_token 和本地文件名
2. 对每个模块，执行：
   ```bash
   lark-cli docs +fetch --api-version v2 --doc <doc_token> --doc-format markdown --as user
   ```
3. 从返回的 JSON 中提取 `data.document.content` 字段（即 markdown 内容）
4. 将内容写入 `references/<文件名>`，覆盖本地缓存
5. 汇报同步结果：成功数 / 失败数 / 跳过的模块

### 错误处理

- 如果某个模块 fetch 失败，**保留本地缓存不覆盖**，在结果中标注失败模块和错误原因
- 如果 lark-cli 未安装或未认证，跳过同步，提示用户本地缓存仍可使用
- 同步完成后，如全部成功，告知用户"知识库已更新到最新版本"

### 单模块同步

如果用户只想更新某个模块（如"更新清算流程的知识"），只需 fetch 该模块的 doc_token 并覆盖对应文件即可。

## 详细知识

如需深入了解任何模块的完整操作说明、业务规则和注意事项，请读取 references/ 目录下对应的知识文件。各文件结构统一：概述 → 操作步骤 → 业务规则 → 注意事项 → 常见误区。
