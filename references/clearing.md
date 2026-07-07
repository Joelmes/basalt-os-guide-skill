# 清算流程

> 数据来源：Basalt OS PRD

## 清算订单

### 清算订单状态

<callout emoji="🧨">
三联系统未维护订单创建、支付等前置状态，本系统订单状态从订单上送环节开始定义。
</callout>

1. 状态定义：

   1. 未上送：支付订单从三联系统/收钱吧拉取至本系统后的初始状态，表示订单在本系统中刚创建，尚未向网商银行发起订单上送。
   2. 上送失败：「未上送」订单调用网商`补单创单接口`失败（网络异常、参数校验驳回、网关报错等），未获取网商订单号。
   3. 已上送：
   
      1. 支付单：「未上送」的支付订单调用网商银行`补单创单接口< ant.mybank.bkcloudfunds.bill.pay>` 完成订单上送并拿到网商订单号 `{OrderNo}`后的状态。
      2. 退款单：「未上送」的退款单变更订单状态为「已上送」，不调用网商接口（网商是不需要退款单上送）。
   4. 清算中：「已上送」状态的订单，关联的清算文件上传成功，关联的批次调用`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`创建批次成功进入「清算中」状态，网商执行清算操作中的状态。
   5. 清算成功：「清算中」状态的订单，网商侧完成该订单所属批次的清算，批次清算结果中该笔订单为「清算成功」时的状态。
   6. 清算失败：「清算中」状态的订单，网商侧完成该订单所属批次的清算，批次清算结果中该笔订单为「清算失败」时的状态。批次清算结果为「部分成功」时需通过校验文件确认该批次中每个订单的清算结果。
2. 状态变更

   <whiteboard token="WgytwInDFhP2pVbWNFDcGLjLnPc"></whiteboard>

### 订单导入状态

<synced_reference src-block-id="MgLldiERYssox1bx4q5c6aoanhx" src-token="P4eedyyrhoWE5HxC1AtcCPvtnWc"></synced_reference>

1. 状态说明

   <table><colgroup><col/><col/><col/><col/></colgroup><thead><tr><th>状态名称</th><th>状态值</th><th>状态类型</th><th>说明</th></tr></thead><tbody><tr><td>处理中</td><td>DEALING</td><td>中间态</td><td><ol><li seq="1">文件上传成功，系统正在解析文件，暂未全部处理完成。</li></ol></td></tr><tr><td>成功</td><td>SUCCESS</td><td>终态</td><td><ol><li seq="1">表格解析完成，且所有数据全部导入成功，该文件内所有的订单数据导入成功（无异常数据，如重复，数据缺失等）。</li></ol></td></tr><tr><td>失败</td><td>FAIL</td><td>终态</td><td><ol><li seq="1">文件异常：文件损坏/ 格式不对/ 缺少必填表头/列错乱，整份文件无法读取。</li><li>数据异常：数据全部导入失败。</li></ol></td></tr><tr><td>部分成功</td><td>PARTIAL_SUCCESS</td><td>终态</td><td><ol><li seq="1">文件上传成功，部分数据解析且导入成功，部分数据解析或导入失败（数据确实，订单重复等）。订单唯一性通过「交易流水号」字段识别。</li></ol></td></tr></tbody></table>

   1. 处理中
   2. 成功
   3. 失败
   4. 部分成功

### POS机绑定状态

1. 状态定义：

   1. 未绑定商户：POS未跟任何商户有绑定关系。
   2. 已绑定商户：POS跟商户已建立绑定关系。
2. 状态变更

   <whiteboard token="B5HawgqOdhB2Ptb6ze2ciGFUnrd"></whiteboard>


## 清算文件

<synced_reference src-block-id="I8BNdAwyRs5SS1bbJlec74gSnwb" src-token="P4eedyyrhoWE5HxC1AtcCPvtnWc"></synced_reference>

<callout emoji="🧨">
1. 清算文件的产生：清算文件通过「清算订单」功能中的「生成清算文件」按钮生成。文件名称用清算批次号。
2. 清算文件在网商系统中也被称为「补单文件」，或「交易明细文件」。
3. 清算文件的作用：前述步骤已经完成了零售订单上送给网商，清算文件中补充参与清算的商户信息，后面按批次清算时则按照该文件中的商户进行清算。
4. 清算文件上传路径：/upload/\${isvOrgId}/\${acquireId}/\${batchNo}/merchant_trade_detail\_\${batchNo}.txt
5. 标档文件上传路径：/upload/\${isvOrgId}/\${acquireId}/\${batchNo}/finish\_\${batchNo}.txt
6. ⚠️ 每天最多上传 50 次清算文件。
7. 每个清算文件（清算批次）中「实际金额」须＞0。
</callout>

### 清算文件管理

1. 筛选清算文件

   1. 上传时间：对应列表中的上传时间列，提供近60天，近30天，近7天，昨天，今天，快捷筛选，也支持通过下拉日期自定义时间段筛选。
   2. 批次号：对应列表中的批次号列，文本框输入，支持关键词筛选（非完全匹配）。
   3. 订单编号：对应列表中的订单编号列，文本框输入，支持关键词筛选（非完全匹配）。
   4. 状态：对应列表中的上送状态列，下拉选择，全部状态见[清算文件状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-LzzMdlvQfoE9hkxIR0OcreKlntd)。
2. 操作

   1. 无
3. 清算文件列表

   1. 批次号：系统生成的清算批次号，批次号生成规则详见[清算批次号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-FrbjdJkmWoZhGMxVhpHc8jSJnmj)。
   2. 交易总金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，该清算文件中`全部支付订单的交易总金额`减去`全部退款订单的交易总金额`，数据关系上，交易总金额=实际金额+渠道手续费。
   3. 实际金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，该清算文件中`全部支付订单的实际金额`减去`全部退款订单的实际金额`。
   4. 渠道手续费：金额数字为2位小数，单位元，格式为`{x.xx}元`，该清算文件中`全部支付订单的渠道手续费金额`减去`全部退款订单的渠道手续费金额`。
   5. 状态：清算文件的状态，详细状态定义及状态变更见[清算文件状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-LzzMdlvQfoE9hkxIR0OcreKlntd)。
   6. 上传时间：文件上传至网商的时间.
   7. 操作：根据清算文件状态，不同状态的清算文件对应有不同的操作。
   
      1. 待上传：上传，作废，详情
      2. 已作废：详情
      3. 上传失败：上传，作废，详情
      4. 已上传：撤回，新建批次，详情
      5. 已撤回：上传，作废，详情
      6. 待上报：查看批次，详情
      7. 上报失败：查看批次，详情
      8. 清算中：查看批次，详情
      9. 清算成功：查看批次，详情
      10. 部分成功：查看批次，详情
      11. 清算失败：查看批次，详情
   8. 操作说明：
   
      1. 上传：点击后系统依次上传`清算文件`和`同名标档文件`。两个文件都上传成功时才视为清算文件上传成功，有一个失败则视为清算文件上传失败。
      
         1. 上传成功：toast提示：清算文件上传成功，请刷新列表查看。
         2. 上传失败：toast提示：清算文件上传失败，请稍后重试。
      2. 撤回：点击后从网商ftp服务器撤回该文件。
      
         1. 撤回成功：toast提示：清算文件撤回成功，请刷新列表查看。
         2. 撤回失败：toast提示：清算文件撤回失败，请稍后重试。
      3. 作废：点击展示作废确认弹窗。
      
         1. 弹窗内容：
         
            <callout emoji="❗">
            作废操作不可撤销，请谨慎操作，作废后：
            - 该清算文件将不可再编辑，不可上传。
            - 批次内的所有订单将变更为已上送状态，需要重新生成清算文件方可发起清算。
            </callout>
         2. 取消：点击后弹窗消失，回到清算文件列表，清算文件状态不变。
         3. 确定：点击后执行作废操作，执行成功后弹窗内容变更为「清算文件已作废，请刷新列表查看。」，清算文件状态变更为「已作废」状态，批次内所有订单变更为「已上送」状态。
      4. 新建批次：点击后跳转至新建批次页面。
      5. 查看批次：点击后跳转至批次详情页面。
      6. 详情：点击后跳转至清算文件详情页面。
4. 清算文件详情

   1. 查询
   
      1. 支付时间：对应列表中的创单时间，通过下拉日期自定义时间段筛选。
      2. 订单编号：对应列表中的isv支付单号列，文本框输入，支持关键词筛选（非完全匹配）。
      3. 门店名称：对应列表中的门店名称列，文本框输入，支持关键词筛选（非完全匹配）。
      4. 门店编码：列表中未展示，按订单跟门店的归属关系，匹配系统生成的门店编码，文本框输入，支持关键词筛选（非完全匹配）。

### 清算文件（交易明细文件）生成规范

<table><colgroup><col/><col/><col/><col/><col/><col/><col/></colgroup><thead><tr><th>字段</th><th>名字</th><th>举例</th><th>备注</th><th>说明/固定值/规则</th><th>传值-收钱吧</th><th>传值-拉卡拉</th></tr></thead><tbody><tr><td>channel_type</td><td>渠道类型</td><td>WXPAY<br/>ALIPAY</td><td></td><td>收钱吧：<code>Shouqianba_pay</code><br/>拉卡拉：<code>Shouqianba_pay</code></td><td>传值 <code>Shouqianba_pay</code></td><td>传值：<code>Lakala_Pay</code></td></tr><tr><td>trade_type</td><td>交易类型</td><td>SINGLE_PAY 支付明细<br/>REFUND 退款明细</td><td>支付订单和退款订单通过该字段区分，后面的金额一律传入正值</td><td>付款：SINGLE_PAY<br/>退款：REFUND</td><td>收钱吧<code>{交易类型/交易模式}</code>：<br/>付款→ SINGLE_PAY：支付明细<br/>退款→ REFUND：退款明细</td><td>拉卡拉：<code>{交易类型}</code><br/>扫码消费→ SINGLE_PAY：支付明细<br/>扫码退款→ REFUND：退款明细</td></tr><tr><td>batch_no</td><td>批次号</td><td></td><td>标准支付渠道发生的交易对应批次由系统自动生成，批次号是YYYYMMDD日期格式； <br/>ISV自主创建的批次，批次号由ISV负责，保证不重复即可；</td><td>标记清算批次，与清算批次号严格对应</td><td colspan="2">生成清算文件时系统按规则生成，详见<a href="https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-FrbjdJkmWoZhGMxVhpHc8jSJnmj">清算批次号生成规则</a></td></tr><tr><td>recon_dt</td><td>对账日</td><td>20190501</td><td></td><td>订单实际收银日期</td><td>收钱吧<code>{交易日期}</code></td><td>拉卡拉<code>{计费日期}</code></td></tr><tr><td>mybank_order_no</td><td>网商订单号</td><td></td><td>标准支付渠道发生的交易，填写支付成功补单创单返回的网商订单号；</td><td>补单创单成功后由网商返回<br/>退款单填写其关联支付单的网商订单号</td><td colspan="2">网商<code>{OrderNo}</code> </td></tr><tr><td>out_trade_no</td><td>isv支付单号</td><td></td><td>标准支付渠道发生的交易，填写补单创单的isv预下单的外部单号；</td><td>ISV侧自有订单号</td><td>收钱吧<br/>交易类型/交易模式=付款→<code>{交易流水号}</code><br/>交易类型/交易模式=退款→ <code>{商户订单号}</code></td><td>拉卡拉<ul><li>交易类型=扫码消费→ <code>{交易流水号}</code></li><li>交易类型=扫码退款→ <code>{原交易流水号}</code></li></ul></td></tr><tr><td>channel_trade_no</td><td>渠道支付单号</td><td></td><td>标准支付渠道发生的交易，写三方支付返回的支付单号；</td><td>渠道侧交易单号</td><td colspan="2">-</td></tr><tr><td>out_refund_no</td><td>isv退款单号</td><td></td><td>【退款时填】<br/>标准支付渠道发生的交易，写isv退款的外部单号；</td><td>ISV侧自有退款单号</td><td>收钱吧<code>{交易流水号}</code></td><td>拉卡拉<code>{交易流水号}</code></td></tr><tr><td>channel_refund_no</td><td>渠道退款单号</td><td></td><td>【退款时填】<br/>标准支付渠道发生的交易，写三方支付返回的退款单号；</td><td>渠道侧退款单号</td><td colspan="2">-</td></tr><tr><td>trade_amount</td><td>交易总金额</td><td>1.52</td><td>单位（元）支付/退款总金额；<br/>【金额一律传入正值，通过trade_type区分支付和退款方向】</td><td>交易总金额 = 实际金额 + 渠道手续费</td><td>收钱吧<code>收款金额</code><br/>金额一律传入正值</td><td>拉卡拉<code>{交易金额}</code><br/>金额一律传入正值</td></tr><tr><td>actual_amount</td><td>实际金额</td><td>1.50</td><td>单位（元），精确到分<br/>实收/实退金额<br/>【金额一律传入正值，通过trade_type区分支付和退款方向】</td><td>订单实收金额</td><td>收钱吧<code>结算金额</code><br/>金额一律传入正值</td><td>拉卡拉<code>{结算金额}</code><br/>金额一律传入正值</td></tr><tr><td>channel_fee_amount</td><td>渠道手续费</td><td></td><td>支付为渠道收费，退款为渠道退费<br/>【金额一律传入正值，通过trade_type区分支付和退款方向】</td><td>收钱吧收取的服务费</td><td>收钱吧<code>{支付手续费}</code>+<code>{技术服务费}</code><br/>金额一律传入正值</td><td>拉卡拉<code>{结算手续费}</code><br/>金额一律传入正值</td></tr><tr><td>ccy</td><td>币种</td><td>156</td><td></td><td>币种标识字段</td><td colspan="2">固定值：<code>156</code></td></tr><tr><td>user_id</td><td>用户标识</td><td></td><td>填写渠道侧返回的用户标识</td><td>用户唯一标识</td><td>收钱吧<code>{付款账户</code>，没有时传空</td><td>拉卡拉<code>{用户ID}</code></td></tr><tr><td>merchant_id</td><td>商户号</td><td></td><td>商户号</td><td>网商商户号</td><td colspan="2">网商返回的商户<code>{MerchantId}</code></td></tr><tr><td>status</td><td>交易状态</td><td>SUCCESS</td><td></td><td>交易状态标识</td><td colspan="2">固定值：<code>SUCCESS</code></td></tr><tr><td>remark</td><td>备注</td><td></td><td></td><td>备注说明信息</td><td colspan="2"><code>{店铺名称} </code>- 订单</td></tr><tr><td>create_time</td><td>创单时间</td><td>20190501120101</td><td>支付时为支付创建时间，退款时为退款创建时间</td><td>三联系统中订单创建时间</td><td>收钱吧<code>{交易日期}+{时间}</code></td><td>拉卡拉<code>{交易创建时间}</code></td></tr><tr><td>trade_time</td><td>交易时间</td><td>20190501120101</td><td>支付时为支付时间，退款时为退款时间</td><td>三联系统中订单创建时间</td><td>收钱吧<code>{交易日期}+{时间}</code></td><td>拉卡拉：<code>{交易完成时间}</code></td></tr><tr><td>acquire_id</td><td>收单机构编号</td><td></td><td>门店自主收银模式下，填写对应的渠道编号，对接时找技术同学确认；</td><td>固定传值 <code>DEFAULT</code></td><td colspan="2">固定值：<code>DEFAULT</code></td></tr></tbody></table>

### 网商清算文件SFTP服务器

1. 测试环境

   1. 账号 202211000000000004381
   2. 密码 BX4VIRS7GYJH23KD
   3. 域名 sftp-dev.alipay.com
   4. 端口号 22
   5. 注意：测试及预发环境无法提供对账文件，仅能在线上环境获取。】
2. 生产环境

   1. 账号：SFTP账号：202211000000000004381
   2. 密码：7T9JWFX4Zn
   3. 文件下载地及文件命名方式： 
   4. 登录域名： fcsftp.mybank.cn（sftp文件上传目录规则联系钉群对接网商技术沟通确认）（6.29更新：与测试环境一致）
   5. 端口：80


## 清算批次

<synced_reference src-block-id="I8BNdAwyRs5SS1bbJlec74gSnwb" src-token="P4eedyyrhoWE5HxC1AtcCPvtnWc"></synced_reference>

### 清算批次

<callout emoji="🧨">
1. 清算文件上传成功后，需要创建清算批次正式发起清算。
</callout>

#### 新建批次

1. 新建批次操作从「清算文件」列表中的-新建批次发起。
2. 新建批次页面字段说明

   1. 批次号：带入清算文件名称。
   2. 渠道编号：从清算文件带入。
   3. 清算类型：从清算文件带入。
   4. 清算文件：清算文件名，从清算文件带入，跟批次号同名。
   5. 备注：选填，用户可填写该批次的备注内容。
3. 操作：

   1. 取消：返回至清算批次列表页。
   2. 仅保存：批次信息仅在本系统保存，不调用网商创建批次接口。保存后批次状态为「待上报」。
   
      1. 保存失败：toast提示：清算批次保存失败，请稍后重试。批次未创建。
      2. 保存成功：批次保存成功，状态为「待上报」，页面跳转至保存成功页。页面内容：
      
         1. 标题：保存成功
         2. 文本段落：清算批次已保存，您可编辑或继续上报以发起清算。
         3. 按钮操作：
         
            1. 返回列表：点击后返回清算批次列表页。
            2. 编辑：点击后进入该批次的编辑批次页面。
            3. 上报：点击后系统调用`创建批次接口`发起上报。
   3. 保存并上报：系统先保存批次信息，然后调用`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`发起清算。
   
      1. 上报失败：清算批次状态变更为「上报失败」，toast提示：清算批次上报失败，请稍后重试。
      2. 上报成功：清算批次上报成功，状态变更为「清算中」，页面跳转至上报成功页。页面内容：
      
         1. 标题：上报成功
         2. 文本段落：已发起清算，正在等待网商银行处理，稍后可至「清算批次」查看清算结果。
         3. 批次实例号：创建批次接口返回的网商实例号`Batchlnstanceld`
         4. 按钮操作：
         
            1. 返回列表：点击后返回清算批次列表页。

#### 批次管理（批次列表）

1. 筛选：

   1. 上报时间：对应列表中的上报时间列，点击日期下拉框自定义时间段筛选。
   2. 完成时间：对应列表中的完成时间列，点击日期下拉框自定义时间段筛选。
   3. 批次实例号：对应列表中的批次实例号列，文本框输入，支持关键词筛选（非完全匹配）。
   4. 批次号：对应列表中的批次号列，文本框输入，支持关键词筛选（非完全匹配）。
   5. 是否扣保：对应列表中的结算单扣保列，下拉单选，选项包含是，和无扣保，具体规则下面列表中说明。
   6. 批次状态：对应列表中的状态列，下拉选择，全部选项详见[清算批次状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Lrk7dG0nMoNpCWxSfwkcF8C7nMe)。
2. 操作

   1. 更新批次状态：用户点击该按钮后系统调用网商`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`更新批次信息。
   
      1. 更新指定批次：用户先在列表中勾选批次，然后点击该按钮继续操作。
      2. 更新全部批次：用户不勾选列表中任何批次，点击该按钮时，系统查询当前列表所有「清算中」状态的批次。
3. 清算批次列表

   1. 批次号：对应网商接口中的`{BatchNo}`字段值，和生成该批次的清算文件名称一致，批次号生成规则详见[清算批次号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-FrbjdJkmWoZhGMxVhpHc8jSJnmj)。
   2. ~~渠道编号：`{AcquireId}`当前统一传默认值`DEFAULT`。~~
   3. 清算类型：对应网商接口中的`BatchType`字段值`STMT_AVAILABLE_SUM_SHARE`（ ISV收单，结算至余额并分账），前端显示为：至可用余额。
   4. 批次实例号：调用网商`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`成功后网商返回的`Batchlnstanceld`，和批次号一一对应。
   5. 状态：清算批次状态，详见[清算批次状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Lrk7dG0nMoNpCWxSfwkcF8C7nMe)。
   
      1. `失败`状态时网商会同步返回失败原因`{ErrorDesc}`。
      2. 部分成功时网商会返回失败信息下载地址`{VerifyFailDataFileUrl}`，地址三天有效，系统接收到失败状态时同步通过该地址获取失败原因。
   6. 结算单扣保：批次处理完成后，通过`批次完结通知<ant.mybank.bkcloudfunds.billpay.batch.finish.notify>`或`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`接口返回。
   
      1. 列表中展示的字段包含了`IsDepositPay是否发生结算单扣保`和`DepositPayCnt发生结算单扣保的商户`2个字段的内容。
      2. 先根据`IsDepositPay是否发生结算单扣保`字段值判断是否存在扣保，不存在扣保时显示「无」。
      3. 存在扣保时根据`DepositPayCnt发生结算单扣保的商户`字段值展示扣保商户数量。展示格式为「共x个商户」
   7. 上报时间：批次在网商侧的创建时间，由`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`接口`RequestTime`返回。
   8. 完成时间：批次完成时间，由`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`接口`FinishTime`返回。
   9. 备注：创建批次时填写的备注内容，`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`中的`Memo`。
   10. 操作：不同状态对应不同的操作。
   
       1. 待上报：上报，作废，编辑。
       2. 已作废：详情。
       3. 上报失败：上报，作废，编辑。
       4. 清算中：详情。
       5. 清算成功：详情。
       6. 部分成功：详情。
       7. 清算失败：详情。
   11. 操作说明
   
       1. 上报：点击后调用`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`发起清算。
       
          1. 上报成功：toast提示：清算批次上报成功，请刷新列表查看。
          2. 上报失败：toast提示：清算批次上报失败，请稍后重试。
       2. 作废：点击展示作废确认弹窗。
       
          1. 弹窗内容：
          
             <callout emoji="❗">
             作废操作不可撤销，请谨慎操作，作废后：
             - 该清算批次将不可再上报。
             - 批次文件同步作废，批次内所有订单将恢复至已上送状态，需要重新生成清算文件后发起清算。
             </callout>
          2. 取消：点击后弹窗消失，回到清算批次列表，清算批次状态不变。
          3. 确定：点击后执行作废操作，执行成功后弹窗内容变更为「清算批次已作废，请刷新列表查看。」，清算批次变更为「已作废」状态，清算文件状态变更为「已作废」状态，批次内所有订单变更为「已上送」状态。
       3. 编辑：点击后跳转至批次编辑页面。
       4. 详情：点击后跳转至批次详情页面。
   12. 清算批次上报（创建批次）接口映射
   
       <table><colgroup><col/><col/><col/><col/><col/><col/><col/><col/></colgroup><thead><tr><th><b>序号</b></th><th><b>参数名</b></th><th><b>参数描述</b></th><th><b>数据类型</b></th><th><b>长度</b></th><th><b>出现要求</b></th><th><b>示例</b></th><th>传值</th></tr></thead><tbody><tr><td colspan="7"><b>基本参数</b></td><td></td></tr><tr><td>1</td><td>IsvOrgId</td><td>合作方机构号</td><td>String</td><td>32</td><td>M</td><td>2022xxx</td><td></td></tr><tr><td>2</td><td>BatchNo</td><td>批次号，"平台"维度下保证唯一</td><td>String</td><td>16</td><td>M</td><td>仅支持数字，字母、大小写字符</td><td>从清算文件带入。</td></tr><tr><td>3</td><td>AcquireId</td><td>渠道编号</td><td>String</td><td>16</td><td>M</td><td>默认传DEFAULT，具体对接过程确认分配，如MT0001/ELE001</td><td>传值：<code>DEFAULT</code></td></tr><tr><td>4</td><td>BatchType</td><td>批次类型</td><td>String</td><td>64</td><td>M</td><td>STMT_AVAILABLE_SUM_SHARE -- ISV收单，结算至余额并分账（汇总分账）<br/>STMT_AVAILABLE_FREEZE_SUM_WITHHOLD-- ISV收单，结算至余额冻结并分账（汇总分账）<br/>STMT_AVAILABLE_HISTORY_REFUND--ISV历史退款批次（从可用余额退款）<br/>STMT_AVAILABLE_FREEZE_HISTORY_REFUND--ISV历史退款批次（从可用冻结部分退款）</td><td>传值：<code>STMT_AVAILABLE_SUM_SHARE</code></td></tr><tr><td>5</td><td>FileUploadType</td><td>文件上送方式</td><td>String</td><td>32</td><td>M</td><td> SFTP、OSS；当前暂时仅支持SFTP；</td><td>传值:<code>SFTP</code></td></tr><tr><td>6</td><td>ExtInfo</td><td>扩展字段</td><td>String</td><td>256</td><td>C</td><td>Map&lt;String,String&gt;的Json格式(Base64编码)<br/>AutoUnfreezeBalance:Y(批次内的商户剩余结算资金自动解冻)</td><td></td></tr><tr><td>7</td><td>Memo</td><td>备注</td><td>String</td><td>256</td><td>C</td><td></td><td></td></tr></tbody></table>

#### 批次详情

1. 批次号：带入清算文件名称。
2. 渠道编号：从清算文件带入。
3. 清算类型：从清算文件带入。
4. 清算文件：清算文件名，从清算文件带入，跟批次号同名。
5. 备注：选填，用户可填写该批次的备注内容。
6. 批次实例号：网商`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`成功后返回的`Batchlnstanceld`。
7. 状态：该批次的清算状态。
8. 失败原因：

   1. 清算失败：显示{ErrorDesc}返回的值。
   2. 部分成功：显示{VerifyFailDataFileUrl}返回的失败信息下载地址。
9. 结算单扣保：如无扣保则显示「无」，有扣保时显示为「共x个商户」。
10. 上报时间：网商接口`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`接口返回的`RequestTime`的值。
11. 完成时间：`批次查询接口<ant.mybank.bkcloudbatch.batch.query>`接口返回的`FinishTime`的值。

#### 编辑批次

1. 批次号：带入清算文件名称。
2. 渠道编号：从清算文件带入。
3. 清算类型：从清算文件带入。
4. 清算文件：清算文件名，从清算文件带入，跟批次号同名。
5. 备注：选填，用户可修改该批次的备注内容。
6. 操作：

   1. 取消：返回至清算批次列表页。
   2. 仅保存：更新本系统中保存的批次，不调用网商创建批次接口。保存后批次状态仍为「待上报」。
   
      1. 保存失败：toast提示：清算批次保存失败，请稍后重试。批次未创建。
      2. 保存成功：批次保存成功，状态为「待上报」，页面跳转至保存成功页。
   3. 保存并上报：系统先保存批次信息，然后调用`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`发起清算。
   
      1. 上报失败：清算批次状态变更为「上报失败」，toast提示：清算批次上报失败，请稍后重试。
      2. 上报成功：清算批次上报成功，状态变更为「清算中」，页面跳转至上报成功页。

### 退款扣保

<callout emoji="🎈">
1. 清算批次提交后，网商会按商户维度聚合，然后进行清算操作。如果商户有退款订单，且商户可用余额少于退款金额时，网商会从品牌方888结算户（保证金户）帮商户垫付该笔订单退款，即发生扣保。

   1. 扣保发生后会在清算批次结果中用`IsDepositPay是否发生结算单扣保`和`DepositPayCnt发生结算单扣保的商户`字段展示结果，也会通过`补单保证金扣除&退回通知<ant.mybank.bkcloudfunds.billpay.platform.deposit.notify>`接口发送一条扣保通知给品牌方。
2. 品牌方收到扣保通知时，需在自己系统内创建一条扣保单，即本功能页面列表的每一条数据。
3. 然后品牌方需发起退保申请以完成退保，该过程会产生一条退保单，与扣保单一一对应。

   1. 退保即资金从商户可用余额退回至品牌方888结算户的动作。
   2. 退保成功后，网商银行会通过退保通知接口发送退保成功通知。
</callout>

#### 扣保记录

<callout emoji="🎈">
1. 扣保记录下文也称为扣保单。
2. 收到网商的扣保通知后系统创建扣保单。
3. 完整的扣保单（含退保成功）数据来源包括补单保证金扣除通知接口，发起退保申请接口，退保结果查询接口，和补单保证金退回通知接口的数据。
</callout>

1. 筛选

   1. 批次号：对应列表中的批次号列，文本框输入，支持关键词筛选（非完全匹配）。
   2. 商户：对应列表中商户列，支持使用网商商户号对应的公司/门店名称，或商户简称筛选，文本框输入，支持关键词筛选（非完全匹配）。
   3. 扣保单号：对应列表中的扣保单号列，文本框输入，支持关键词筛选（非完全匹配）。
   4. 退保流水号：对应列表中的退保流水号列，文本框输入，支持关键词筛选（非完全匹配）。
   5. 退保状态：对应列表中的退保状态列，下拉单选，全部状态详见[退款扣保单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-KiPrdY7E5o28mXxvHfLcXfOznVc)。
2. 操作

   1. 更新退保状态：点击后调用`退保结果查询接口<ant.mybank.bkcloudbatch.stmt.deposit.return.query>`查询扣保单最新状态。
   
      1. 如未勾选任何扣保单：点击后查询所有状态为「处理中」的退保单对应的扣保单的最新状态。
      2. 如勾选退保单中包含非「处理中」状态的订单：过滤其他状态的退保单，仅查询状态为「处理中」的退保单对应的扣保单的最新状态。
3. 列表

   <callout emoji="🎈">
   1. 
   2. 前一步清算批次结果中，如果有结算单扣保的商户，网商会通过下面的接口通知品牌方，每个商户一条通知。
   
      1. 通知接口：`补单保证金扣除&退回通知<ant.mybank.bkcloudfunds.billpay.platform.deposit.notify>`，该接口同时用于扣保通知和退保通知。通过接口返回的`Type`字段值区分。
      
         1. 扣保通知类型为：PAY_FOR_STMT_NOT_ENOUGH*（商户结算资金不足，扣保证金）*
         2. 退保通知类型为：RETURN_PLATFORM_DEPOSIT（商户结算单退保&明细单退保）
   3. 品牌方收到扣保通知后，在商户余额充足的情况下，调用退保申请接口发起退保申请。
   
      1. 发起退保申请接口：`结算单退保申请接口<ant.mybank.bkcloudbatch.stmt.deposit.return>`，申请结果同步返回，退保结果异步返回。
      2. 退保申请通过`BatchNo+MerchantId+DepositPayId`关联至扣保通知，不填写退保金额。
   4. 退保申请提交后可通过查询接口获取最新退保状态。
   
      1. 查询接口：`退保结果查询接口<ant.mybank.bkcloudbatch.stmt.deposit.return.query>`
   5. 退保成功后品牌方会通过前述通知接口收到退保通知。
   
      1. 只有退保成功后才会通知。
      2. 接口会返回`RefundDepositOutTradeNo外部请求单号`和`DepositPayId扣保单编号`字段值，通过这两个字段值关联至扣保通知。
   </callout>

   1. 批次号：扣保通知返回，对应网商`BatchNo`字段。
   2. 商户：扣保通知返回，对应网商`MerchantId`字段。
   3. 扣保单号：扣保通知返回，对应网商`DepositPayId`字段。
   4. 金额：扣保通知返回，对应网商`Amount`字段。
   5. 退保流水号：发起退保申请时品牌方产生。对应网商`退保申请`和`退保结果查询`接口的`OutTradeNo`字段，`退保结果通知`接口的`RefundDepositOutTradeNo`字段值。
   
      1. 发起退保申请之前（扣保单状态为「待发起」时）显示为「-」。
   6. 网商操作单号：退保申请提交成功后立即返回，对应网商`OperateNo`字段。
   7. 退保状态：全部状态详见[退款扣保单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-KiPrdY7E5o28mXxvHfLcXfOznVc)。
   8. 失败原因：退保状态为「`FAIL`失败」时出现。对应退保结果查询接口`Msg`字段值。
   9. 操作
   
      1. 退保：状态为「待发起」的扣保单展示，点击后调用网商`结算单退保申请接口<ant.mybank.bkcloudbatch.stmt.deposit.return>`发起退保申请。
      2. 详情：点击后进入扣保单详情页。

#### 退保申请

<callout emoji="🎈">
退保申请须从扣保单发起，与扣保单一一对应。
</callout>

1. 状态为「待发起」的扣保单展示「退保」按钮。
2. 用户点击「退保」按钮后系统调用`结算单退保申请接口<ant.mybank.bkcloudbatch.stmt.deposit.return>`接口发起退保申请。

   1. 接口调用传参
   
      | **序号** | **参数名** | **参数描述** | **数据类型** | **长度** | **出现要求** | 传参 |
      |-|-|-|-|-|-|-|
      | 1 | IsvOrgId | 合作方机构号（网商银行分配） | String | 32 | M | `202211000000000004381` |
      | 2 | BatchNo | 批次号 | String | 32 | M | 对应扣保单中的批次号`BatchNo` |
      | 3 | TaskType | 任务类型  <br/>STMT_AVAILABLE_SUM_SHARE：  <br/>结算至余额并汇总分账 | String | 64 | M | 固定值：  <br/>`STMT_AVAILABLE_SUM_SHARE` |
      | 4 | MerchantId | 网商商户id | String | 32 | M | 对应扣保单中的网商商户号`MerchantId` |
      | 5 | OutTradeNo | 外部交易号 | String | 64 | M | 发起退保申请时创建，生成规则详见[退保流水号](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-ZibgdyXeRob9uJxDAg9c9AuqnCc)。 |
      | 6 | DepositPayId | 扣保单据号 | String | 64 | M | 对应扣保单中的扣保单号`DepositPayId` |
      | 7 | ExtInfo | 扩展信息，Map的json序列化后Base64 | String | 256 | O | 一般为空 |

#### 扣保单详情

<callout emoji="🎈">
1. 点击扣保单列表操作区的「详情」按钮进入扣保单详情。
</callout>

1. 批次号：补单保证金扣除通知接口中的`BatchNo`字段值返回。可关联至清算批次。
2. 商户：补单保证金扣除通知接口中的`MerchantId`字段值返回网商商户号，通过该商户号查询公司或门店名称及商户简称。前端显示格式为：{门店或公司名称}-{商户简称}。
3. 扣保单号：补单保证金扣除通知接口中的`DepositPayld`字段值返回。
4. 金额：补单保证金扣除通知接口中的`Amount`字段值返回。
5. 退保流水号：发起退保申请时结算单退保申请接口中的`OutTradeNo`字段值，退保成功后通过`补单保证金退回通知`接口的返回`RefundDepositOutTradeNo`字段值。
6. 网商操作单号：结算单退保申请被受理后网商同步返回`OperateNo`字段值。
7. 退保状态：扣保单状态，详见[退款扣保单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-KiPrdY7E5o28mXxvHfLcXfOznVc)。

   1. 退保：发起退保按钮，状态为「待发起」的扣保单展示，点击后调用网商`结算单退保申请接口<ant.mybank.bkcloudbatch.stmt.deposit.return>`发起退保申请。
8. 错误描述：状态为「退保失败」时可见，对应退保查询接口中`{Msg}`字段值。

