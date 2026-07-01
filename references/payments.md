## 签约授权

<callout emoji="❗">
1. 该功能是为了管理、查看用于通过商户子户向体系内其他子户或体系外银行卡/支付宝转账付款的授权与合约。
2. 此部分包含以下两种合约：

   1. 协议授权代扣：用于对体系内子户转账。以下简称为协议代扣。
   2. 加盟授权代付：用于对外部银行卡/支付宝转账。以下简称为授权代付。
3. 协议授权代扣合约：

   1. 由商户在入驻时完成签约授权，商户授权后网商通知品牌方合约号。商户：合约=1:1。
   2. 每次收到协议代扣的平台通知（授权/解约通知<ant.mybank.merchantprod.merchant.arrangement.info.notify>）时立即调`查询协议代扣授权状态<``ant.mybank.merchantprod.merchant.arrangement.info``.quer``y>`接口查一次合约最新状态。
4. 加盟授权代付合约：

   1. 由品牌方（平台）发起签约授权，商户授权完成后网商返回合约号。商户：合约：过桥户=1:1:1。
   2. 每次收到授权代付合约的平台通知（授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>）时立即调`查询当前授权协议内容接口地址：<ant.mybank.bkcloudfunds.protocol.arr.query>`接口查一次合约最新内容。
   3. 收到签约/修改通知（签约申请/协议变更申请（同步和异步））时`立即调查询申请单目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.query>`接口查询申请单最新状态。
</callout>

### 新增/修改授权代付合约-授权代付合约产生

<callout emoji="🎈">
1. 协议代扣的授权只能由商户在支付宝云资金小程序主动发起。
2. 授权代付的授权可由平台发起，该功能仅为**授权代付合约**发起授权。
3. 发起授权代付申请的前置步骤：商户已开通过桥西进户。

   1. 过桥西进户由商户在网商云资金小程序中自行开通，网商不会通知也无法查询是否已开通。
4. 合约产生接口：

   1. 协议代扣：网商通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口返回`合约号ArrangementNo`时创建。
   2. 授权代付：网商通过`1.7授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中返回`合约号AgreementNo`时创建合约。
</callout>

1. 页面表单填写说明

   1. 授权方：依次选择授权方公司或门店和授权方商户。支持关键词匹配。付款方商户名和网商商户号分别对应`AuthorizerInfo`中的`参与者名称participantName`和`参与者编号participantId`字段。
   
      1. 授权方门店和商户号选择后，系统需通过商户号查询该商户是否已有生效的合约：
      
         1. 有生效合约：将合约信息展示在页面表单中。用户修改完点提交时走修改逻辑。
         2. 无生效合约：页面合约信息为空，用户填写完点提交时走新增逻辑。
   2. 备注：文本框输入，不超过512个字符。
   3. 动账短信：单选，通知/不通知。
   4. 子场景和收款方：按场景聚类，分别填写每个场景的收款方信息。
   
      1. 收款方信息填写提示：
      
         1. 收款方支持银行卡和支付宝，五个场景最多可绑定200个授权方。
         
            - 银行卡支持对公和对私类型的银联借记卡，不支持信用卡；
            - 支付宝仅支持个人对私支付宝账户，不支持对公类型的支付宝账户。
      2. 子场景展示顺序及限制信息。
      
         1. 租金：`RENT`。该场景下单笔≤2.5万，所有收款方月度转账总和≤25万，最多可绑定5个收款方。
         2. 水电物业费：`FEE`。该场景下单笔≤2万，所有收款方月度转账总和≤10万，最多可绑定10个收款方。
         3. 合伙人：`PARTNER`。该场景下单笔≤10万，所有收款方月度转账总和≤40万，最多可绑定40个收款方。
         4. 工资：`SALARY` 。该场景下单笔≤2万，所有收款方月度转账总和≤25万，最多可绑定50个收款方。
         5. 报销代发：`CLAIM`。该场景下单笔≤1万，所有收款方月度转账总和≤10万，最多可绑定500个收款方。
      3. 收款方信息填写规则
      
         <callout emoji="🎈">
         1. 商户初次新增授权时，每个业务子场景默认不展示空白收款方信息，用户需点击「新增收款方」新增一组空白待填写的收款方信息。
         2. 收款方支持银行卡和支付宝。
         
            - 银行卡支持对公和对私类型的银联借记卡，不支持信用卡；
            - 支付宝仅支持个人对私类型的支付宝账户，不支持对公类型的支付宝账户。
         </callout>
      
         1. 户名：文本框输入，收款方账户名称。`participantName`字段。
         
            1. 银行卡：银行卡户名。
            2. 支付宝：支付宝户名。
         2. 账号：文本框输入，收款方账号。`participantId`字段。
         
            1. 银行卡：银行卡卡号。
            2. 支付宝：支付宝登录号，手机号或邮箱。
         3. 类型：下拉单选，对公对私类型，`bankCardHolderType`字段。
         
            1. 银行卡：银行卡可选择对公或对私。
            2. 支付宝：支付宝仅支持对私类型，不支持对公。页面信息提交时做校验。
         4. 联行号：对公银行卡联行号。`unitedBankCode`字段。
         
            1. 银行卡：银行卡且对公类型时必填。页面信息提交时做校验。
            2. 支付宝：不填。
      4. 新增收款方
      
         1. 点击后在按钮上方新增一组待填写的收款方信息。
         2. 每个场景有收款方数量限制，已添加的收款方数量达到场景上限时按钮变更为禁用态。
      5. 页面提交
      
         1. 取消：点击后展示二次确认弹窗。
         
            1. 弹窗内容：是否保存已填写内容？
            2. 弹窗按钮：
            
               1. 不保存：点击后不保存已填写数据，返回合约管理页。
               2. 保存：点击后保存已填写数据，返回合约管理页。
               3. 继续填写：弹窗消失，返回表单填写页，已填写数据保留。
         2. 提交：点击后系统依次执行以下操作
         
            1. 校验已填写数据有效性，如填写有误则直接在页面上将填写错误的内容边框标为红色，如填写无误则执行下一步。
            
               1. 必填项目不为空。
               2. 单个子场景绑定的银行卡+支付宝账号数量未超过限制。
               3. 五个子场景绑定的银行卡+支付宝账号总数量未超过限制（200个）。
            2. 生成系统流水号`OutTradeNo`。系统流水号生成规则详见系统[系统流水号生成](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-RysfduIBuo5cVixyQFLccw5Cnxc)。
            3. 判断报销代发`CLAIM`场景的收款方数量：
            
               1. 若收款方数量≤50，则调用`1.1. 协议签约申请&协议变更申请接口(同步)<ant.mybank.bkcloudfunds.protocol.sign.apply>`接口发起授权申请。
               2. 若收款方数量≥50，则调用`1.2. 协议签约申请&协议变更申请(异步接口)<ant.mybank.bkcloudfunds.protocol.sign.async.apply>`接口发起授权申请。
            4. 接口调用失败：则本地保存表单数据，页面上用toast提示失败原因。
            5. 如接口调用成功：授权记录中新增一条授权代付的授权记录数据。
2. 发起授权申请接口调用：

   <callout emoji="🎈">
   1. 提交按钮校验（接口调用前置校验）
   
      1. 信息完整性：每条收款方信息中户名，账号，类型，联行号，均不可为空。
      2. 5个子场景的收款方不可全部为空，至少要有一条收款方信息。
   2. 分为同步接口和异步接口，两个接口的入参一致，回参有所不同。
   
      1. 同步接口：`1.1. 协议签约申请&协议变更申请接口(同步)<ant.mybank.bkcloudfunds.protocol.sign.apply>`
      2. 异步接口：`1.2. 协议签约申请&协议变更申请(异步接口)<ant.mybank.bkcloudfunds.protocol.sign.async.apply>`
   </callout>

   1. 接口调用顺序
   
      1. 同步接口：调用成功后立即返回申请编号`AuthApplyNo`和商户确认链接`AuthSignUrl`。
      2. 异步接口：
      
         1. 调用成功后立即返回申请编号`AuthApplyNo`。
         2. 待网商处理完成后通过`协议签约异步申请结果通知<ant.mybank.bkcloudfunds.protocol.sign.apply.notify>`返回申请单状态`Status`，商户确认链接`AuthSignUrl`（`Status`为`SUCCESS`时返回），或错误码`AuthSignUrl`和错误描述`ErrorDesc`（`Status`为`FAIL`时返回）。
   2. 接口字段映射
   
      <table><colgroup><col/><col/><col/><col/><col/><col/><col/></colgroup><tbody><tr><td><b>参数名称</b></td><td><b>参数描述</b></td><td><b>数据类型</b></td><td><b>长度</b></td><td><b>出现要求</b></td><td><b>示例</b></td><td>传值</td></tr><tr><td>IsvOrgId</td><td>平台机构ID，由网商分配</td><td>String</td><td>32</td><td>M</td><td></td><td><code>202211000000000004381</code></td></tr><tr><td>OutBizNo</td><td>外部流水号</td><td>String</td><td>64</td><td>M</td><td>外部订单请求流水号，外部请求的唯一标识。</td><td>每一笔申请单单独生成，系统内不允许重复。</td></tr><tr><td>ApplyType</td><td>申请类型</td><td>String</td><td>32</td><td>M</td><td>整体协议授权的申请：<br/>新增：CREATE<br/>修改：ADJUST</td><td>根据商户是否已有关联的合约号：<br/>无合约号：新增：CREATE<br/>有合约号：修改：ADJUST</td></tr><tr><td>AgreementNo</td><td>网商授权代付的合约号<br/>[C]：ApplyType为ADJUST时必传</td><td>String</td><td>64</td><td>C</td><td>2024012314391234567</td><td>新增时不传。<br/>修改时传原合约号。</td></tr><tr><td>SceneCode</td><td>业务场景</td><td>String</td><td>32</td><td>M</td><td>合伙模式传值：<br/>PARTNER_CASCADE_PAY</td><td>固定值：<code>PARTNER_CASCADE_PAY</code></td></tr><tr><td>AuthorizerInfo</td><td>授权方信息</td><td>String</td><td>2048</td><td>M</td><td>map的json格式base64编码<br/>商户主体<br/><b>参见文档下「通用结构体」说明。</b></td><td>授权方商户信息，按网商要求上传。</td></tr><tr><td>AuthorizeeInfo</td><td>被授权方信息</td><td>String</td><td>2048</td><td>M</td><td>map的json格式base64编码<br/>平台主体<br/><b>参见文档下「通用结构体」说明。</b></td><td>平台信息：<ol><li seq="1">参与者编号：participantId。固定值：<code>202211000000000004381</code></li><li>参与者名称：participantName。固定值：<code>浙江可柔品牌管理有限公司</code></li><li>类型：participantType。固定值：<code>PLATFORM</code></li></ol></td></tr><tr><td>AuthDetail</td><td>授权事项</td><td>String</td><td>80000</td><td>M</td><td>map&lt;String, Object&gt;的json格式base64编码<br/><b>参见下文「授权事项」说明。</b></td><td><ol><li seq="1">按场景传收款方信息。场景详见<a href="https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-YNS9dxCPhoynxYxHaeJcO8HjnTp">授权代付场景</a>。</li></ol></td></tr><tr><td>++participantType</td><td>参与者类型</td><td>String</td><td>32</td><td>M</td><td>当前支持银行卡及支付宝<ul><li>银行卡：BANK_CARD</li><li>支付宝：ALIPAY_LOGON</li></ul></td><td><ol><li seq="1">系统通过用户填写的收款账号自动判断。<ul><li>银行卡：BANK_CARD→ 16-19位纯数字</li><li>支付宝：ALIPAY_LOGON→ 手机号11位，或邮箱有@</li></ul></li></ol></td></tr><tr><td>++participantId</td><td>参与者</td><td>String</td><td>64</td><td>M</td><td>当前支持银行卡及支付宝<ul><li>银行卡：银行卡号</li><li>支付宝：支付宝登录号</li></ul></td><td><ol><li seq="1">用户填写的「账号」</li></ol></td></tr><tr><td>++participantName</td><td>参与者名称</td><td>String</td><td>64</td><td>M</td><td>当前支持银行卡及支付宝<ul><li>银行卡：户名</li><li>支付宝：支付宝户名</li></ul></td><td><ol><li seq="1">用户填写的「户名」</li></ol></td></tr><tr><td>++bankCardHolderType</td><td>对公对私类型</td><td>String</td><td>32</td><td>M</td><td>【仅限BANK_CARD及ALIPAY_LOGON】<br/>对公：CORPORATION<br/>对私：INDIVIDUAL<br/>支付宝暂仅支持对私类型</td><td><ol><li seq="1">银行卡：支持对公或对私两种类型</li><li>支付宝：仅支持对私类型</li></ol></td></tr><tr><td>++unitedBankCode</td><td>【仅限BANK_CARD】<br/>人行联行号<br/><b>[C]：对公类型必填</b></td><td>String</td><td>64</td><td>C</td><td>例如网商银行的联行号：323331000001</td><td><ol><li seq="1">银行卡且对公类型必填。</li></ol></td></tr><tr><td>Memo</td><td>备注</td><td>String</td><td>512</td><td>O</td><td></td><td>表单中用户填写的备注文本框内容。</td></tr><tr><td>SmsProhibitFlag</td><td>是否禁止动账短信通知(Y/N)</td><td>String</td><td>2</td><td>O</td><td>Y - 禁止动账短信通知<br/>N - 发送动账短信通知<br/>注意：为空时默认发送短信(N)</td><td>表单中用户选择的是否通知。<br/>不通知：Y<br/>通知：N</td></tr><tr><td>TransitionDetail<br/>                                        </td><td>协议过桥信息</td><td>String</td><td>512</td><td>O</td><td>过桥西进户账号、户名<br/>map&lt;String, String&gt;的json格式base64编码<br/><b>参见下文「过桥信息TransitionDetail」说明。</b><br/>若该字段为空，选择最新的企业西进户作为过桥商户</td><td>不传。</td></tr></tbody></table>

### 合约管理

#### 合约列表

<callout emoji="🎈">
1. 一个合约只能归属一个商户。
2. 合约产生后，对该合约的修改，解约，解约审核动作，合约号都不会发生变化。
3. 解约后（已失效），重新签约会产生新的合约号。
4. 通过商户简称/编号在该列表中查询合约时，可以出现多个合约号，但是同一类型的合约只能有一个是已生效状态，且只能是签约/修改时间更晚的那个。
5. 该列表包含`协议代扣`和`授权代付`两种合约。
6. 合约数据获取的接口

   1. 协议代扣：网商通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口返回`合约号ArrangementNo`时创建。
   2. 授权代付：网商通过`1.7授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中返回`合约号AgreementNo`时创建合约。
</callout>

1. 筛选

   1. 合约号：对应列表中的合约号列，文本框输入，支持关键词筛选（非完全匹配）。
   2. 合约类型：对应列表中的合约类型列，下拉单选，选项包含协议代扣，和授权代付。
   3. 授权方名称：对应列表中的授权方名称列的名称，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 公司：公司名称，含总部公司和区域公司。
      2. 门店：门店名称。
   4. 授权方编码：对应列表中的授权方门店列的门店编码，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 公司：公司编码，含总部公司和区域公司。
      2. 门店：门店编码。
   5. 授权方商户简称：对应列表中的授权方商户列的商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   6. 授权方商户号：对应列表中的授权方商户列的网商商户号，文本框输入，支持关键词筛选（非完全匹配）。
   7. 合约状态：对应列表中的合约状态列，下拉单选，选项包含协议代扣和授权代付两种合约去重后的全部状态。详见[协议代扣合约状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-DQaMdqLulobsdFxuPvAccRlPnkc)和[授权代付合约状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-UGlNdJ8yWohGNrxtnlIcRWVSnub)。
   
      1. 「已生效」可筛选协议代扣和授权代付两个类型的已生效合约。
      2. 「已失效」可筛选协议代扣和授权代付两个类型的已失效合约。
      3. 全部状态：
      
         1. 不存在
         2. 已申请未生效
         3. 已生效
         4. 解约中待平台确认
         5. 已失效 
         6. 已取消
2. 操作

   1. 签约授权：发起新的「授权代付」授权。点击后打开「[签约授权>新的授权](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-FkwPd05VnozqHMxBjpscbwG6n5d)」页面。
3. 列表

   1. 协议代扣
   
      1. 合约号：
      
         1. 协议代扣：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约号ArrangementNo`字段返回。
      2. 合约类型：
      
         1. 协议代扣：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约类型ArrangementType`字段返回。字段值为：`SUB_ACCOUNT_WITHHOLD`，前端展示为：协议代扣。
      3. 授权方名称：网商商户号对应的公司或门店名称。
      4. 授权方编码：商户号对应的公司或门店编码。
      5. 授权方商户简称：
      
         1. 协议代扣：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号MerchantId`字段值对应的商户简称。
      6. 授权方网商商户号：
      
         1. 协议代扣：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号MerchantId`字段返回。
      7. 动账短信：
      
         1. 协议代扣：N\A不存在，展示为「-」。
      8. 合约状态：
      
         1. 展示协议代扣合约的状态，状态详见[协议代扣合约状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-DQaMdqLulobsdFxuPvAccRlPnkc)。
      9. 操作
      
         1. 详情：点击跳转至合约详情页面。
         2. 授权记录：点击跳转至授权记录页面，带入网商商户号做筛选。
   2. 授权代付
   
      1. 合约号：
      
         1. 授权代付：商户签约授权完成后通过`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段返回。
      2. 合约类型：
      
         1. 授权代付：由平台调用`签约申请/协议变更申请`同步或异步接口发起的授权申请获得的合约，可以通过合约号来源判断，即合约号来自`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段，则该合约类型为授权代付，前端展示为：授权代付。
      3. 授权方名称：网商商户号对应的公司或门店名称。
      4. 授权方编码：商户号对应的公司或门店编码。
      5. 授权方商户简称：
      
         1. 授权代付：商户签约授权完成后通过`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方信息：AuthorizerInfo`中的`参与者名称：participantName`返回。也可以用网商商户号查。
      6. 授权方网商商户号：
      
         1. 授权代付：商户签约授权完成后通过`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方信息：AuthorizerInfo`中的`参与者编号：participantId`返回。
      7. 动账短信：
      
         1. 授权代付：
         
            1. 商户签约授权完成后通过`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口拿到合约号后，再通过`查询当前授权协议内容ant.mybank.bkcloudfunds.protocol.arr.query`接口查询申合约最新内容，接口返回的`是否禁止动账短信通知：SmsProhibitFlag`字段的值。
            
               1. Y - 不通知
               2. N - 通知。
      8. 合约状态：
      
         1. 展示授权代付合约的状态，状态详见[授权代付合约状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-UGlNdJ8yWohGNrxtnlIcRWVSnub)。
      9. 操作
      
         1. 详情：点击跳转至合约详情页面。
         2. 授权记录：点击跳转至授权记录页面，带入网商商户号做筛选。

#### 合约详情

##### 协议代扣

1. 合约号：`ArrangementNo`字段的值。
2. 合约类型：ArrangementType字段的值。字段值为：`SUB_ACCOUNT_WITHHOLD`，前端展示为：协议代扣。
3. 授权方：依次展示{公司或门店名称}-{商户简称}-{网商商户号}，中间用「-」连接。
4. 最新申请单：合约关联的最新通知单。协议代扣通知单相关规则见后文的授权记录。
5. 合约状态：协议代扣通知接口`ArrangementNo`字段的值，或查询接口`Status`值。
6. 更新时间：该合约关联的最后一条申请单的更新时间。格式：yyyy-MM-dd HH:mm:ss

##### 授权代付

1. 合约号：`ArrangementNo`字段的值。
2. 合约类型：根据合约号来源判断，前端展示为：授权代付。
3. 授权方：依次展示{公司或门店名称}-{商户简称}-{网商商户号}，中间用「-」连接。网商商户号`participantId`和商户简称`participantName`通过`AuthorizerInfo`字段获取，门店名称通过网商商户号反查获得。
4. 动账短信：`是否禁止动账短信通知：SmsProhibitFlag`字段的值，不通知/通知。
5. 过桥户：{户名}-{账号}，发起授权申请时填写的过桥西进户的户名和账号，未填写时网商使用商户最新过桥西进户，如果没有值则展示为「-」。
6. 业务场景：对应`SceneCode`字段的值`PARTNER_CASCADE_PAY`，授权代付合约的业务场景均展示为：合伙模式。
7. 子场景限额：由网商控制，通过`1.6.查询当前授权协议内容<ant.mybank.bkcloudfunds.protocol.arr.query>`接口`agreementLimitInfo`字段返回。

   1. 单笔限额: {singleAmountLimit}，前端以元为单位，精确到小数点后2位，格式为「xx.yy元」。
   2. 日限额: {dayAvailableLimitAmt}，前端以元为单位，精确到小数点后2位，格式为「xx.yy元」。
   3. 月限额: {monthAmountLimit}，前端以元为单位，精确到小数点后2位，格式为「xx.yy元」。
8. 最新申请单：依次展示{申请单系统流水号OutBizNo}-{申请单状态AuthApplyStatus}中间用「-」连接。授权代付合约关联的最新申请单规则见后文的授权记录。
9. 合约状态：授权代付的合约状态，状态详见[授权代付合约状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-UGlNdJ8yWohGNrxtnlIcRWVSnub)。
10. 完结时间：`{完结时间FinishTime}`格式：yyyy-MM-dd HH:mm:ss。
11. 业务子场景、子场景限额和子场景收款方：按子场景聚类展示每个子场景下的授权方信息，业务子场景为`subSceneCode`字段的值，子场景限额为`agreementLimitInfo`字段的值，收款方为`receiptParticipantList`字段列表的值。

    <callout emoji="🎈">
    1. 列表中出现的银行卡账号和支付宝账号均需脱敏。脱敏规则详见[银行账号和支付宝账号脱敏规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MeW6doV0AoFnY0xWXjFcFY1anve)。
    </callout>

    1. 子场景：共有5个子场景，按如下顺序：
    
       1. 租金：`RENT`
       2. 水电物业费：`FEE`
       3. 合伙人：`PARTNER`
       4. 工资：`SALARY` 
       5. 报销代发：`CLAIM`
    2. 子场景限额：按子场景，分别展示每个子场景的限额信息，金额以万为单位。
    
       1. 前端显示格式为：该场景下单笔≤{singleAmountLimit}万，所有收款方日转账总和≤{dayAvailableLimitAmt}万，所有收款方月度转账总和≤{monthAmountLimit}万。
       2. 显隐规则：「该场景下」固定显示，后面的「单笔≤{singleAmountLimit}万，」「所有收款方日转账总和≤{dayAvailableLimitAmt}万，」，「所有收款方月度转账总和≤{monthAmountLimit}万」根据接口返回的限额值，有限额时显示，无限额时不显示。
       3. 如，某一场景接口返回了单笔限额2.5万，月度限额25万，无日限额，则前端显示为：「该场景下单笔≤2.5万，所有收款方月度转账总和≤25万」。
    3. 收款方信息展示：
    
       1. 户名：收款方账户名称。`participantName`字段。
       
          1. 银行卡：户名
          2. 支付宝：支付宝户名
       2. 账号：收款方账号。`participantId`字段。
       
          1. 银行卡：银行卡号
          2. 支付宝：支付宝登录号
       3. 类型：对公对私类型，`bankCardHolderType`字段。
       
          1. 对公：CORPORATION
          2. 对私：INDIVIDUAL
       4. 联行号：对公银行卡联行号。`unitedBankCode`字段。
       
          1. 仅对公银行卡展示联行号，对私银行卡及支付宝展示为「-」。

### 授权记录（授权申请单）

#### 授权记录（申请单）的产生

<callout emoji="🎈">
1. 授权记录（也称为申请单）是合约的产生过程。

   1. 协议代扣接口文档地址：https://loan-platform.yuque.com/vo42xq/dpd6q7/hz4cxl#okx5e
   2. 授权代付接口文档地址：https://loan-platform.yuque.com/vo42xq/dpd6q7/kfcdymo1frk3es5p#odona
</callout>

1. 协议代扣

   1. 签约：商户在小程序中发起，网商通知平台，平台接收到通知即视为一条记录。
   2. 解约：商户在小程序中发起，网商通知平台，平台接收到通知即视为一条记录。
   3. 解约审核：商户发起解约申请后，平台侧调用审核接口进行审核确认时产生一条记录。
2. 授权代付

   1. 签约：由平台发起，接口调用成功网商返回申请编号即视为产生一条签约记录，记录详情通过查询申请单目前状态接口获取。
   2. 修改：由平台发起，接口调用成功网商返回申请编号即视为产生一条签约记录，记录详情通过查询申请单目前状态接口获取。
   3. 解约：由商户在小程序中发起后网商通过合同变更通知平台，平台接收到网商通知即视为一条记录，平台侧无需审核，平台侧无解约入口。

#### 授权记录列表

<callout emoji="🎈">
1. 一个合约可对应多个授权记录，通过合约号可查询该合约的签约，修改，解约，解约审核的授权记录。
</callout>

1. 筛选

   1. 系统流水号：对应列表中的合约类型列，文本框输入，支持关键词筛选（非完全匹配）。
   2. 合约类型：对应列表中的合约类型列，下拉单选，选项包含协议代扣，和授权代付。
   3. 合约号：对应列表中的合约号列，文本框输入，支持关键词筛选（非完全匹配）。
   4. 授权方名称：对应列表中的授权方名称列的名称，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 公司：公司名称，含总部公司和区域公司。
      2. 门店：门店名称。
   5. 授权方编码：对应列表中的授权方门店列的门店编码，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 公司：公司编码，含总部公司和区域公司。
      2. 门店：门店编码。
   6. 授权方商户简称：对应列表中的授权方商户列的商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   7. 授权方商户号：对应列表中的授权方商户列的网商商户号，文本框输入，支持关键词筛选（非完全匹配）。
   8. 状态：对应列表中的状态列，下拉单选，选项包含协议代扣和授权代付两种合约的所有授权记录的状态。详见[协议代扣申请单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Ipu3dyILCo1GnuxB2IUcZ0pEnIh)和[授权代付申请单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-OvwsdQPKpoimOcxX6PXcIiBnnjh)。
2. 操作

   1. 无
3. 列表

   1. 协议代扣
   
      1. 系统流水号
      
         1. 协议代扣：系统流水号生成规则详见[系统流水号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-VK4EdIBqqonQUyxt9hmcXTRLnuf)。
         
            1. 签约、解约：商户完成签约或发起解约申请时网商通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口发送通知，收到通知时为该条记录生成系统流水号。
            2. 解约审核：商户发起解约申请，平台调用网商`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口审核时系统产生一条记录并生成系统流水号。
      2. 合约类型
      
         1. 协议代扣：前端展示为「协议代扣」。
         
            1. 签约、解约：商户完成签约或发起解约申请时网商通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口发送通知，接口中`合约类型ArrangementType`字段返回值为：`SUB_ACCOUNT_WITHHOLD`。
            2. 解约审核：商户发起解约申请，平台调用网商`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口审核时根据接口中传参`合约号ArrangementNo`字段判断。
      3. 合约号：
      
         1. 协议代扣：
         
            1. 签约、解约：
            
               1. 商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约号ArrangementNo`字段返回。
               2. 通过`1.3协议代扣授权状态查询接口<``ant.mybank.merchantprod.merchant.arrangement.info``.query>`获得`合约号ArrangementNo`跟前一步的合约号做校验。
            2. 解约审核：网商`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口的`合约号ArrangementNo`字段值。
      4. 申请类型：
      
         1. 协议代扣：通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中的`当前合约状态ArrangementStatus`字段和`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口的调用判断。
         
            1. 签约：对应`授权/解约通知`中`当前合约状态`字段值`已生效：VALID `状态。
            2. 解约：对应`授权/解约通知`中`当前合约状态`字段值`解约中待平台确认：INVALID_TO_BE_CONFIRM`状态。
            3. 解约审核：调用`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口创建的申请单。
      5. 授权方名称：
      
         1. 协议代扣：`1.1授权/解约成功通知接口<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号Merchantld`字段值对应的公司或门店名称。
      6. 授权方编码：
      
         1. 协议代扣：`1.1授权/解约成功通知接口<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号Merchantld`字段值对应的公司或门店编码。
      7. 授权方商户简称：
      
         1. 协议代扣：商户签约授权完成后通过`1.1授权/解约成功通知接口<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号MerchantId`字段值对应的商户简称。
      8. 授权方网商商户号：
      
         1. 协议代扣：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`网商商户号MerchantId`字段返回。
      9. 备注
      
         1. 协议代扣：N\A不存在，展示为「-」。
      10. 动账短信
      
          1. 协议代扣：N\A不存在，展示为「-」。
      11. 状态：协议代扣申请单状态，详见[协议代扣申请单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MtJ0dE40WohAm4xOi1FcH1Ghnxe)。
      12. 操作
      
          1. 协议代扣：
          
             1. 详情：点击进入协议代扣申请单详情页面。
             2. 审核：状态为「解约待审核」状态的申请单可执行该操作。点击后打开审核弹窗。
             
                1. 审核弹窗：
                
                   1. 授权方：{公司或门店名称}-{商户简称}
                   2. 合约类型：固定值：协议代扣
                   3. 审核结果：
                   
                      1. 同意：对应网商接口`AuditResult`字段值`AGREE -同意`。
                      2. 拒绝：对应网商接口`AuditResult`字段值`REJECT-拒绝`。
                   4. 审核结果说明文字：
                   
                      1. 同意：同意后，商户的协议代扣合约将失效，该商户将无法对外付款。
                      2. 拒绝：拒绝后，该商户的协议代扣合约状态不发生变化。
                   5. 确定：点击后调用网商`1.2 解约申请审核确认接口<ant.mybank.merchantprod.merchant.arrangement.audit>`接口。
   2. 授权代付
   
      1. 系统流水号
      
         1. 授权代付：平台调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付申请时系统生成的`系统流水号OutBizNo`。发起授权代付申请详见[发起授权代付申请](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MGZvd67hxodImTxWjutcS8ApnOc)。系统流水号生成规则详见[系统流水号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-LjFjdzbGHoHARRx0I3xcRGpknsb)。
      2. 合约类型
      
         1. 授权代付：由平台调用`签约申请/协议变更申请`同步或异步接口发起的授权申请获得的合约，也可以通过合约号来源判断，如合约号来自`授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段，则该合约类型为授权代付，前端展示为：授权代付。
      3. 合约号
      
         1. 授权代付：商户签约授权完成后通过`1.7授权合同变更通知接口<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段返回。
      4. 申请类型
      
         1. 授权代付：通过`签约申请/协议变更申请<ant.mybank.bkcloudfunds.protocol.sign.apply>`和`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`申请类型ApplyType`字段判断。
         
            1. 签约：对应字段值`新增：CREATE`。
            2. 修改：对应字段值`修改：ADJUST`。
            3. 解约：对应字段值`解约：INVALID`。
      5. 授权方名称：
      
         1. 授权代付：
         
            1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权方AuthorizerInfo`字段值中商户号对应的公司或门店名称。
            2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方AuthorizerInfo`字段值中商户号对应的公司或门店名称。
      6. 授权方编码：
      
         1. 授权代付：
         
            1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权方AuthorizerInfo`字段值中商户号对应的公司或门店编码。
            2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方AuthorizerInfo`字段值中商户号对应的公司或门店编码。
      7. 授权方商户简称：
      
         1. 授权代付：
         
            1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权方AuthorizerInfo`字段值中商户号对应的商户简称。
            2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方AuthorizerInfo`字段值中商户号对应的商户简称。
      8. 授权方网商商户号：
      
         1. 授权代付：
         
            1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权方AuthorizerInfo`字段值中的网商商户号。
            2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`授权方AuthorizerInfo`字段值中的网商商户号。
   3. 备注
   
      1. 授权代付：
      
         1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口返回的`备注：Memo`字段值。
         2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口返回的`备注：Memo`字段值。
   4. 动账短信
   
      1. 授权代付：
      
         1. 签约、修改：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口返回的`是否禁止动账短信通知：SmsProhibitFlag`字段的值
         2. 解约：`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口返回的`是否禁止动账短信通知：SmsProhibitFlag`字段的值
         
            1. Y - 不通知
            2. N - 通知。
   5. 状态：授权代付申请单状态，详见[授权代付申请单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-EGfxdYbBUoAnzDxNLOcctkBonjh)。
   
      1. 授权代付申请单状态为「待商户确认」时，后方展示复制图标，鼠标悬浮至图标上方时用文字气泡Tooltip展示提示文字「复制商户确认链接」，点击后将完整的确认链接复制到剪贴板。
   6. 操作
   
      1. 授权代付：
      
         1. 撤销：待确认状态的授权代付申请单可撤销，点击后弹出二次确认弹窗。
         
            1. 弹窗内容：确定撤销吗？撤销后如需再次签约可再次发起签约授权。
            2. 取消：弹窗管理，申请单状态不变。
            3. 确定：调用网商`1.5. 取消申请<ant.mybank.bkcloudfunds.protocol.sign.apply.cancel>`接口取消授权代付申请单，成功后状态变更为closed。
         2. 详情：点击进入授权代付申请单详情页面。

#### 授权记录详情（申请单详情）

##### 协议代扣

<callout emoji="🎈">
协议代扣申请单来源
1. 签约：商户在网商云资金小程序发起签约时网商通过`授权/解约通知接口<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`通知平台，对应字段`当前合约状态ArrangementStatus`值`已生效:VALID`。
2. 解约：商户在网商云资金小程序发起解约时网商通过`授权/解约通知接口<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`通知平台，对应字段`当前合约状态ArrangementStatus`值`解约中待平台确认:INVALID_TO_BE_CONFIRM`。
3. 解约审核：调用`1.2 解约申请审核确认接口<ant.mybank.merchantprod.merchant.arrangement.audit>`对商户解约申请进行审核时产生的申请单。
</callout>

1. 系统流水号： 商户完成签约时网商通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口发送通知，收到通知时为该条记录生成系统流水号。
2. 申请时间：

   1. 申请类型为签约：本系统接收到网商通知的时间，格式：yyyy-MM-dd HH:mm:ss。
   2. 申请类型为解约：本系统接收到网商通知的时间，格式：yyyy-MM-dd HH:mm:ss。
   3. 申请类型为解约审核：本系统调用网商`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口的时间。
3. 申请类型：通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中的`当前合约状态ArrangementStatus`字段和`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口的调用判断。

   1. 签约：对应`授权/解约通知`中`当前合约状态`字段值`已生效：VALID `状态。
   2. 解约：对应`授权/解约通知`中`当前合约状态`字段值`解约中待平台确认：INVALID_TO_BE_CONFIRM`状态。
   3. 解约审核：调用`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口产生的审核单（在协议代扣场景中统一称为通知单或申请单）。
4. 合约：展示{合约号}-{合约状态}

   1. 签约、解约：商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约号ArrangementNo`字段返回。合约状态按接口返回展示。
   2. 解约审核：网商`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`接口的`合约号ArrangementNo`字段值。合约状态按接口返回展示。
5. 合约类型：可直接通过商户签约授权完成后通过`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约类型ArrangementType`字段返回值判断，字段值为：`SUB_ACCOUNT_WITHHOLD`。也可以通过合约号来源判断，如合约号来自`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`接口中`合约号ArrangementNo`字段。前端展示为：协议代扣。
6. 授权方：即该申请单发起方。

   1. 签约、解约：签约和解约申请单由公司或门店发起。{公司或门店名称}-{商户简称}-{网商商户号}。
   2. 解约审核：解约审核申请单由平台发起。{平台名称（品牌方）}-{IsvOrgId}（一般为固定值：`浙江可柔品牌管理有限公司-202211000000000004381`）。

##### 授权代付

<callout emoji="🎈">
授权代付申请单来源：
1. 签约：平台调用`签约申请/协议变更申请`接口发起新的授权代付合约签约请求。
2. 修改：平台调用`签约申请/协议变更申请`接口修改已有授权代付合约请求。
3. 解约：商户修改后网商通过`1.7.授权合同变更通知`接口通知平台合约失效请求。
</callout>

1. 系统流水号：平台调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付申请时系统生成的`系统流水号OutBizNo`。发起授权代付申请详见[发起授权代付申请](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MGZvd67hxodImTxWjutcS8ApnOc)。系统流水号生成规则详见[系统流水号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-LjFjdzbGHoHARRx0I3xcRGpknsb)。
2. 申请时间：每次产生新的申请单时，需同步调用`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口查询申请单最新状态时返回的`请求时间RequestTime`字段值。
3. 申请类型：

   1. 签约：对应调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付申请时提交的`申请类型ApplyType`字段值的`CREATE`。
   2. 修改：对应调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付申请时提交的`申请类型ApplyType`字段值的`ADJUST`。
   3. 解约：由商户发起，对应网商通过`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`申请类型ApplyType`字段值的`INVALID`。
4. 申请编号：

   1. 签约：对应调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付签约申请成功后网商返回的`申请编号AuthApplyNo`字段值。
   2. 修改：对应调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付修改申请成功后网商返回的`申请编号AuthApplyNo`字段值。
   3. 解约：由商户发起，对应网商通过`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`申请编号AuthApplyNo`字段值。
5. 合约号：

   1. 签约：调用`签约申请/协议变更申请`（同步或异步）接口后，网商通过`1.7. 授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段的值。
   2. 修改：
   
      1. 对应调用`签约申请/协议变更申请`（同步或异步）接口发起授权代付签约申请时提交的`合约号AgreementNo`字段的值。
      2. 有新的修改申请单时，也可以调用`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口查询申请单最新状态时返回的`合约号AgreementNo`字段的值。
   3. 解约：由商户发起，对应网商通过`1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>`接口中`合约号AgreementNo`字段的值。
6. 合约类型：授权代付合约的合约类型为：`授权代付`。
7. 申请单状态：详见[授权代付申请单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-EGfxdYbBUoAnzDxNLOcctkBonjh)。
8. 确认链接：展示网商返回的商户确认链接，对应网商`AuthSignUrl`字段值，超长后用「……」，链接后面展示「复制」按钮，点击后将完整的确认链接复制到剪贴板。

   1. 申请单状态为「待商户确认」时出现。
9. 错误描述：调用`签约申请/协议变更申请`异步接口时`1.3. 协议签约异步申请结果通知<ant.mybank.bkcloudfunds.protocol.sign.apply.notify>`接口返回的`错误描述信息ErrorDesc`字段的值。

   1. 申请单状态为「申请失败FAIL」时出现。
10. 完结时间：格式：yyyy-MM-dd HH:mm:ss，`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口查询申请单最新状态时返回的`完结时间FinishTime`字段的值。

    1. 终态时返回，如果未返回，则显示为「-」。
11. 合约：{合约号}-「合约状态」。如该申请单已经产生合约号，则显示，如果没有合约号，则显示为「-」。

    1. 签约：商户确认后通过`1.7.授权合同变更通知`接口返回合约号才有合约号。
    2. 修改：有合约号，合约号状态为「已生效」。
    3. 解约：有合约号。合约状态按接口返回展示。
12. 业务场景：合伙模式。对应`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`业务场景SceneCode`字段值`PARTNER_CASCADE_PAY`。
13. 授权方：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权方AuthorizerInfo`字段的值。

    1. 授权方是公司或门店：{公司或门店名称}-{商户简称}-{网商商户号}
    2. 授权方是平台：{平台名称（品牌方）}-{IsvOrgId}（如：`浙江可柔品牌管理有限公司-202211000000000004381`）。
    3. 授权方是网商：{网商银行}（如：网商银行）
14. 被授权方：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`被授权方AuthorizerInfo`字段的值。

    1. 授权方是门店：{门店名称}-{商户简称}-{网商商户号}
    2. 授权方是平台：{平台名称（品牌方）}-{IsvOrgId}（如：`浙江可柔品牌管理有限公司-202211000000000004381`）。
    3. 授权方是网商：{网商银行}（如：网商银行）
15. 发起方：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`发起方InitiatorInfo`字段的值。

    1. 发起方是门店：{门店名称}-{商户简称}-{网商商户号}
    2. 发起方是平台：{平台名称（品牌方）}-{IsvOrgId}（如：`浙江可柔品牌管理有限公司-202211000000000004381`）。
    3. 发起方是网商：{网商银行}（如：网商银行）
16. 最终操作方：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`最终操作方AdvancingInfo`字段的值。

    1. 最终操作方是门店：{门店名称}-{商户简称}-{网商商户号}
    2. 最终操作方是平台：{平台名称（品牌方）}-{IsvOrgId}（如：`浙江可柔品牌管理有限公司-202211000000000004381`）。
    3. 最终操作方是网商：{网商银行}（如：网商银行）
17. 备注：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`备注Memo`字段的值。
18. 动账短信：`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`是否禁止动账短信通知(Y/N)SmsProhibitFlag`字段的值。

    1. Y - 不通知
    2. N - 通知。
19. 过桥户：{户名}-{账号}。发起新签授权代付协议后，调用`1.4. 查询申请单目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.query>`接口查询申请单最新状态，接口返回的`协议过桥信息TransitionDetail`字段的值。如接口未返回，则显示为「-」。

    1. 户名：accountName
    2. 账号：accountNo
20. 业务子场景和收款方：按场景聚类，分别填写每个场景的收款方信息。`1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.auerv>`接口中`授权事项AuthDetail`字段的值。

    <callout emoji="🎈">
    1. 列表中出现的银行卡账号和支付宝账号均需脱敏。脱敏规则详见[银行账号和支付宝账号脱敏规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MeW6doV0AoFnY0xWXjFcFY1anve)。
    </callout>

    1. 子场景展示顺序及限制信息。
    
       1. 租金：`RENT`。该场景下单笔≤2.5万，所有收款方月度转账总和≤25万，最多可绑定5个收款方。
       2. 水电物业费：`FEE`。该场景下单笔≤2万，所有收款方月度转账总和≤10万，最多可绑定10个收款方。
       3. 合伙人：`PARTNER`。该场景下单笔≤10万，所有收款方月度转账总和≤40万，最多可绑定40个收款方。
       4. 工资：`SALARY` 。该场景下单笔≤2万，所有收款方月度转账总和≤25万，最多可绑定50个收款方。
       5. 报销代发：`CLAIM`。该场景下单笔≤1万，所有收款方月度转账总和≤10万，最多可绑定500个收款方。
    2. 收款方信息填写
    
       1. 户名：收款方账户名称。`participantName`字段。
       
          1. 银行卡：银行卡户名。
          2. 支付宝：支付宝户名。
       2. 账号：收款方账号。`participantId`字段。
       
          1. 银行卡：银行卡卡号。
          2. 支付宝：支付宝登录号。
       3. 类型：对公对私类型，`bankCardHolderType`字段。
       
          1. 银行卡：银行卡可选择对公或对私。
          2. 支付宝：支付宝仅支持对私类型，不支持对公。页面信息提交时做校验。
       4. 联行号：对公银行卡联行号。`unitedBankCode`字段。
       
          1. 银行卡：银行卡且对公类型时必填。页面信息提交时做校验。
          2. 支付宝：N\A不存在，展示为「-」。


## 付款

### 付款记录

<callout emoji="🎈">
1. 接口调用：

   1. 协议代扣：分别由通知接口和查询接口，建议通过通知接口收到通知后再用查询接口查一次付款单数据。
   2. 授权代付：分别由通知接口和查询接口，建议通过通知接口收到通知后再用查询接口查一次付款单数据。
2. 数据来源接口

   1. 协议代扣：2.2和2.3两个接口的参数字段一致。
   
      1. 发起付款（创建付款单）：2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>
      2. 付款结果通知：2.2协议授权代扣通知结果<ant.mybank.bkcloudfunds.protocol.witHHold.result.notify>
      3. 查询付款结果：2.3协议授权代扣查询结果<ant.mybank.bkcloudfunds.protocol.witHHold.query>
   2. 授权代付：2.2和2.3两个接口的参数字段一致。
   
      1. 发起付款：2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>
      2. 付款结果通知：2.2.授权代付结果通知<ant.mybank.bkcloudfunds.trade.operate.result.notify>
      3. 查询付款结果：2.3.授权代付结果查询<ant.mybank.bkcloudfunds.trade.operate.result.query>
</callout>

1. 筛选

   1. 业务流水号：对应列表中的系统流水号列，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 使用小技巧：仅输入业务流水号 后8位（年月日），可筛选批量付款批次中所有的付款单。
   2. 网商交易号：对应列表中的网商交易号列，文本框输入，支持关键词筛选（非完全匹配）。
   3. 付款方
   
      1. 付款方名称：对应列表中的付款方列的付款方名称，文本框输入，支持关键词筛选（非完全匹配）。
      2. 付款方商户简称：对应列表中的付款方列的付款方商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   4. 收款方
   
      1. 收款方名称：对应列表中的付款方列的收款方名称，文本框输入，支持关键词筛选（非完全匹配）。
      2. 收款方商户简称：对应列表中的付款方列的收款方商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   5. 状态：对应列表中的状态列，下拉单选，选项包含协议代扣和授权代付两种付款记录的所有状态。详见[协议代扣付款记录状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-E9jbd0vPvoxB6jx1k1ycghfWnmd)和[授权代付付款记录状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-RyJCdoCPloXO9bxXB7fceetenEf)。
2. 操作

   1. 发起付款：点击后跳转至批量付款页面，用户可通过顶部标签切换至单笔付款。
   2. 更新付款状态：点击后根据付款类型分别调用网商接口查询付款记录结果。
   
      <callout emoji="🎈">
      协议代扣：`2.3协议授权代扣查询结果<ant.mybank.bkcloudfunds.protocol.witHHold.query>`。
      授权代付：`2.3授权代付结果查询<ant.mybank.bkcloudfunds.trade.operate.result.query>`。
      </callout>
   
      1. 如未勾选任何记录：查询全部「处理中」状态的支付记录的最新结果，含协议代扣和授权代付两种类型的支付记录。
      2. 如勾选记录中包含非「处理中」状态的记录，系统依次执行以下动作：
      
         1. 对已选择记录中非「处理中」状态的记录进行过滤。
         2. 对已选择记录中「处理中」状态的记录执行更新付款状态操作。
         3. 执行结果通知：
         
            1. 执行成功：toast提示：「付款状态更新成功，请刷新列表查看。」
            2. 执行失败：toast提示：「付款状态更新失败，请稍后重试。」
3. 付款单列表

   1. 业务流水号：调用网商付款接口时系统生成的流水号，对应网商`OutTradeNo`字段，业务流水号生成规则详见[业务流水号生成规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-YJTrdjutUoVT9QxhBtacdVIdn2f)。
   2. 网商交易号：支付接口调用成功后网商返回
   
      1. 协议代扣：对应网商接口中的`当前操作交易号OperateNo`字段值。
      2. 授权代付：对应网商接口中的`支付网商操作号OperateNo`字段值。
   3. 付款方：该付款单中的付款方主体和商户信息。
   
      1. 协议代扣：对应网商`2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口中的`付款方商户号PayerId`字段值，通过该字段值查询到的付款方信息。
      
         1. 2.2通知接口和2.3查询接口**不**会返回该字段。
      2. 授权代付：对应网商`2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>`接口中的`付款方（授权方）主体信息PayerParticipant`字段值，通过该字段值查询到的付款方信息。
      
         1. 2.2通知接口和2.3查询接口**不**会返回该字段。
      3. 付款方为公司时：展示公司名称和付款商户简称。
      4. 付款方为门店时：展示门店名称和付款商户简称。
   4. 付款金额：单位元，到小数点后2位。
   
      1. 协议代扣：对应网商`2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口中的`交易金额（分）TotalAmount`字段值。
      
         1. 2.2通知接口和2.3查询接口也会返回该字段。
      2. 授权代付：对应网商`2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>`接口中的`支付金额（单位：分）TotalAmount`字段值。
      
         1. 2.2通知接口和2.3查询接口也会返回该字段。
   5. 收款方：
   
      1. 协议代扣：该付款单中的收款方主体和商户简称。对应网商`2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口中的`收款方ID PayeeId`字段值（`网商商户号`），通过该字段值查询到的收款方信息。
      
         1. 2.2通知接口和2.3查询接口**不**会直接返回该字段，在调用2.1接口时需做记录。
         2. 收款方为公司时：展示公司名称和付款商户简称。
         3. 收款方为门店时：展示门店名称和付款商户简称。
      2. 授权代付：该付款单中的收款方户名和账号。对应网商`2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>`接口中的`收款方主体信息PayeeParticipant`字段值（网商商户号），通过该字段值查询到的收款方信息。
      
         <callout emoji="🎈">
         1. 列表中出现的银行卡账号和支付宝账号均需脱敏。脱敏规则详见[银行账号和支付宝账号脱敏规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MeW6doV0AoFnY0xWXjFcFY1anve)。
         </callout>
      
         1. 2.2通知接口和2.3查询接口**不**会返回该字段，在调用2.1接口时需做记录。
   6. 备注：用户创建付款单时填写的备注信息
   
      1. 协议代扣：对应网商`协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口中的`备注Memo`字段值。
      
         1. 2.2通知接口和2.3查询接口也会返回该字段。
      2. 授权代付：对应网商`授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>`接口中的`备注Memo`字段值。
      
         1. 2.2通知接口和2.3查询接口也会返回该字段。
   7. 状态：按付款方式，展示对应付款单的状态。详见[协议代扣付款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-JVLSdFbDhoXLS6xPtNVcpy9cnLd)和[授权代付付款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-QVKPdNdTHoysw9xNlV0cWFbingh)。
   
      1. 处理中：网商已受理付款请求，正在处理中。
      2. 成功：付款执行成功，资金已划转。
      3. 失败：付款执行失败，资金未划转。展示错误信息。
   8. 完结时间：付款单网商侧完结时间，格式：yyyy-MM-dd HH:mm:ss。
   
      1. 协议代扣：对应网商
      
         1. `2.2协议授权代扣通知结果<ant.mybank.bkcloudfunds.protocol.witHHold.result.notify>`接口返回的`交易完结时间FinishDate`字段值。
         2. `2.3协议授权代扣查询结果<ant.mybank.bkcloudfunds.protocol.witHHold.query>`接口返回的`交易完结时间FinishDate`字段值。
      2. 授权代付：对应网商
      
         1. `2.2授权代付结果通知<ant.mybank.bkcloudfunds.trade.operate.result.notify>`接口中的`交易完结时间FinishDate`字段值。
         2. `2.3授权代付结果查询<ant.mybank.bkcloudfunds.trade.operate.result.query>`接口中的`交易完结时间FinishDate`字段值。
   9. 操作
   
      1. 退款：点击后打开退款申请弹窗。按钮显示条件需同时满足：
      
         1. 付款方式为「协议代扣」。
         2. 状态为「成功」或「部分退款」。
         3. 最大可退金额＞0，最大可退金额计算规则详见[协议代扣退款](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Kpa5d7Dy0oYzUpxUSercwU3Knqx)。
      2. 详情：点击后进入付款单详情页。

### 付款记录详情

<callout emoji="🎈">
1. 接口调用和数据来源同付款单列表。
</callout>

#### 协议代扣

##### 付款信息

1. 业务流水号：发起付款申请时系统生成的业务流水号，对应网商`OutTradeNo`字段值。
2. 付款方式：展示为「对内付款（协议代扣）」，对应发起付款页面中的付款方式选项。
3. 网商交易号：调用网商接口发起付款申请成功后网商返回，对应网商`OperateNo`字段值。
4. 业务场景：对应`2.1协议授权代扣`接口中的`业务场景Scene`字段值，一般为`品牌协议代扣支持冻结和账号场景`。
5. 付款金额：付款金额数字为2位小数，单位元，格式为`{x.xx}元`，对应网商`TotalAmount`字段值。

   1. 退款：点击后打开退款申请弹窗。按钮显示条件同退款列表。
6. 币种：人民币，对应网商`Currency`字段值。
7. 冻结部分出金：商户冻结子户出款金额，数字为2位小数，单位元，格式为`{x.xx}元`对应网商FreezeAmount字段值。
8. 可用部分出金：商户可用子户出款金额，数字为2位小数，单位元，格式为`{x.xx}元`对应网商AvailableAmount字段值。
9. 付款方：付款方主体信息和商户简称。对应网商`PayerId`字段值对应的商户信息。

   1. 付款方为公司时：展示{公司名称}-{付款商户简称}-{付款方网商商户号}。
   2. 付款方为门店时：展示{门店名称}-{付款商户简称}-{付款方网商商户号}。
10. 付款方类型：商户。对应网商`PayerType`字段值`MERCHANT`。
11. 收款方：收款方主体信息和商户简称。对应网商`PayeeId`字段值网商商户对应的商户信息。

    1. 收款方为公司时：展示{公司名称}-{收款商户简称}-{收款方网商商户号}。
    2. 收款方为门店时：展示{门店名称}-{收款商户简称}-{收款方网商商户号}。
12. 收款方类型：商户或平台。对应网商`PayeeType`字段值。

    1. MERCHANT：商户
    2. PLATFORM：平台
13. 备注：发起付款申请时填写的备注信息，对应网商`Memo`字段值。
14. 指定付方使用信息：付款时出款账户的使用顺序，对应网商`PayerSpecifiedInfo`字段值。按字段值中的`priority`优先级数字从小到大依次排列。如

    1. 可用子户冻结余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`BALANCE_FREEZE`字段值。
    2. 可用子户解冻余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`BALANCE_AVAILABLE`字段值。
    3. 保证金户余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`TRADE_DEPOSIT_AVAILABLE`字段值。
15. 订单类型：对应网商`OrderType`字段值。

    1. 多笔合并支付 ：`IMME_MERGE_SINGLE_PAY`
    2. 单笔支付：`MERGE_SINGLE_PAY`
16. 网商订单号：网商侧返回的订单号，对应网商`OrderNo`字段值。
17. 状态：付款单状态，详见[协议代扣付款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-JVLSdFbDhoXLS6xPtNVcpy9cnLd)。
18. 交易完结时间：格式：yyyy-MM-dd HH:mm:ss，对应网商`交易完结时间FinishDate`字段值。
19. 错误码，对应网商`ErrorCode`字段值。状态为「FAIL」时出现。
20. 错误描述：对应网商`ErrorDesc`字段值，状态为「FAIL」时出现。

##### 退款信息

<callout emoji="🎈">
付款单关联的退款单信息汇总，退库单详细信息详见[协议代扣退款](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-AmwEdM31PocOftxACZjcNgsznld)。
</callout>

1. 已退款金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，该付款单关联的状态为「成功」的退款单的退款金额总和。
2. 退款在途金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，该付款单关联的状态为「处理中」的退款单的退款金额总和。
3. 最大可退金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，最大可退金额=付款金额-已退款金额-退款在途金额。

   1. 退款：按钮，点击后打开退款申请弹窗。按钮显示条件需同时满足：
   
      1. 付款方式为「协议代扣」。
      2. 状态为「成功」或「部分退款」。
      3. 最大可退金额＞0，最大可退金额计算规则详见[协议代扣退款](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Kpa5d7Dy0oYzUpxUSercwU3Knqx)。
4. 退款记录：付款单关联的退款单列表。

   1. 表格字段含义及取值在[退款记录](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-JxlLd427lo70JVxcFO0cILUSngc)中有详细说明。
   2. 「详情」按钮交互逻辑与退款记录列表一致，点击后跳转至[退款记录详情](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-B30kdqv0KoDSvPxuagVc4PEbnEc)页。

#### 授权代付

1. 业务流水号：发起付款申请时系统生成的业务流水号，对应网商`OutTradeNo`字段值。
2. 付款方式：展示为「对外付款（授权代付）」，对应发起付款页面中的付款方式选项。
3. 网商交易号：调用网商接口发起付款申请成功后网商返回，对应网商`OperateNo`字段值。
4. 关联网商订单号：对应网商`RelateOrderNo`字段值。
5. 产品场景码：固定值：「合伙模式联动场景」，发起支付时网商`SceneCode`字段值`PARTNER_CASCADE_PAY`。
6. 子场景码：发起支付时网商SubSceneCode字段值

   1. 租金：`RENT`
   2. 水电物业费：`FEE`
   3. 合伙人：`PARTNER`
   4. 工资：`SALARY` 
   5. 报销代发：`CLAIM`
7. 合约号：发起支付时网商`AgreementNo`字段值。
8. 付款方：付款方主体信息和商户简称。对应网商`PayerParticipant`字段值对应的商户信息。

   1. 付款方为公司时：展示{公司名称}-{付款商户简称}-{付款方网商商户号}。
   2. 付款方为门店时：展示{门店名称}-{付款商户简称}-{付款方网商商户号}。
9. 收款方：{户名}-{账号}。付款方主体信息和商户简称。对应网商`PayeeParticipant`字段值对应的商户信息。

   <callout emoji="🎈">
   1. 列表中出现的银行卡账号和支付宝账号均需脱敏。脱敏规则详见[银行账号和支付宝账号脱敏规则](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MeW6doV0AoFnY0xWXjFcFY1anve)。
   </callout>
10. 支付金额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应网商`TotalAmount`字段值。
11. 币种：人民币，对应网商`Currency`字段值。
12. ~~付方资产信息，需要指定付方出资份额时必填（可用子户可用部分出资金额，可用子户冻结部分出金，保证金子户出资金额）~~
13. 指定付方使用信息付款时出款账户的使用顺序，对应网商`PayerSpecifiedInfo`字段值。按字段值中的`priority`优先级数字从小到大依次排列。如

    1. 可用子户冻结余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`BALANCE_FREEZE`字段值。
    2. 可用子户解冻余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`BALANCE_AVAILABLE`字段值。
    3. 保证金户余额：金额数字为2位小数，单位元，格式为`{x.xx}元`，对应`TRADE_DEPOSIT_AVAILABLE`字段值。
14. 交易请求时间：格式：yyyy-MM-dd HH:mm:ss，对应网商`RequestTime`字段值。
15. 交易完结时间：格式：yyyy-MM-dd HH:mm:ss，对应网商`FinishDate`字段值。
16. 备注：发起付款申请时填写的备注信息，对应网商`Memo`字段值。
17. 单品牌多SaaS：对应网商`MultiSaasScene`字段值。

    1. 是：Y
    2. 否：N
18. 状态：付款单状态，详见[权代付付款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-QVKPdNdTHoysw9xNlV0cWFbingh)。
19. 错误码，对应网商`ErrorCode`字段值。状态为「FAIL」时出现。
20. 错误描述：对应网商`ErrorDesc`字段值，状态为「FAIL」时出现。

### 批量付款

<callout emoji="🎈">
用户在前置操作中发起付款时，默认进入「批次付款」标签页。
</callout>

1. 填写批量付款表格并上传

   1. 付款方式：用户需先选择付款方式，付款方式会影响后面的空白模板和导入后的处理逻辑。
   
      1. 对内付款：即前文的协议代扣。
      2. 对外付款：即前文的授权代付。
   2. 下载空白模板：根据前面选择的付款方式，调用浏览器下载对应的空白模板。
   
      1. 对内付款（协议代扣）表格关键内容
      
         1. 对内付款（协议代扣）填写须知：
         2. 请勿修改表格结构。
         3. 红色字段必填，黑色字段选填
         4. 付款方公司/门店名称、付款方商户简称：输入名称后自动从「商户信息表」中匹配，须确保公司/门店名称、商户简称和商户信息表中的对应关系一致。
         5. 付款方商户号：选择好付款方商户简称后系统自动从「商户信息表」中匹配对应的付款方商户号，请勿手动修改。
         6. 付款金额：即转账金额，单位：元，保留小数点后2位。
         7. 收款方公司/门店名称、收款方商户简称：输入名称后自动从「商户信息表」中匹配，须确保公司/门店名称、商户简称和商户信息表中的对应关系一致。
         8. 收款方商户号：选择好付款方商户简称后系统自动从「商户信息表」中匹配对应的付款方商户号，请勿手动修改。
         9. 备注可填写该批付款的备注内容。
         10. 填写完成后，请复制全部已填写单元格内容，再粘贴为「值」，付款方商户号和收款方商户号两列不要保留公式。
      2. 对外付款（授权代付）表格关键内容
      
         1. 对外付款（授权代付）填写须知：
         2. 请勿修改表格结构。
         3. 红色字段必填，黑色字段选填
         4. 付款方公司/门店名称、付款方商户简称：输入名称后自动从「商户信息表」中匹配，须确保公司/门店名称、商户简称和商户信息表中的对应关系一致。
         5. 付款方商户号：选择好付款方商户简称后系统自动从「商户信息表」中匹配对应的付款方商户号，请勿手动修改。
         6. 付款金额：即转账金额，单位：元，保留小数点后2位。
         7. 6.收款方户名、账号：可填写银行卡或支付宝信息，银行卡填写银行卡号，支付宝填写支付宝登录账号。请确保收款方信息已在系统商户详情→ 外部商户页面的外部账户列表中。
         8. 备注可填写该批付款的备注内容。
         9. 填写完成后，请复制全部已填写单元格内容，再粘贴为「值」，付款方商户号列不要保留公式。
   3. 上传完善后的模板
   
      1. 文本提示：在下载的模板填写信息后，可直接将文件拖拽到  此处进行上传。支持格式：XLSX
      2. 选择文件：点击后打开本地文件管理器，从本地选择Excel后上传。
      3. 拖拽上传：支持用户拖拽Excel文件至虚线框内上传表格。
      4. 校验表格内容并解析。
   4. 提交：打开二次确认弹窗
   
      1. 弹窗内容：付款请求提交后不可撤销，请谨慎操作。
      
         1. 取消：弹窗关闭，保留已上传的表格内容。
         2. 提交：系统依次执行以下动作：
         
            1. 生成付款批次号：批次号生成规则详见[批量付款批次号](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-GqG9dFjiRotO9nxreZIcRGjPngf)。
            2. 提交成功后弹窗内容变更为：「批量付款请求已提交，正在等待网商银行处理，稍后可刷新付款记录页面查看。」
            3. 处理上传的批量付款表格。
            
               1. 校验表格中的付款单内容。
               2. 校验通过后调用对应的网商接口发起付款请求。付款流程逻辑和单笔付款一致。
2. 导入历史

   1. 筛选
   
      1. 批次号：对应列表中的付款批次号列，文本框输入，支持关键词筛选（非完全匹配）。
      2. 上传时间：对应列表中的上传时间列，通过下拉日期自定义时间段筛选。
      3. 状态：对应列表中的状态列，下拉单选，全部状态详见[批量付款批次状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-Ovx0dCG5GoBoxQxxthycThScn1d)。
   2. 操作
   
      1. 无
   3. 列表
   
      1. 付款批次号：前面提交时生成的付款批次号。
      2. 上传时间：批量付款信息表的上传时间。
      3. 状态：也就是付款批次的状态，状态说明详见[批量付款批次状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-SnYtdxVZsoG3LyxkHA5cdN13nse)。
      4. 操作：根据状态，可执行操作有所不同。
      
         1. 处理中：-
         2. 成功：下载
         3. 失败：下载
         4. 部分成功：下载
   4. 批量付款历史结果表下载
   
      1. 下载规则：原上传文件名+{上传时间}。
      2. 文件内容表头：在原导入模板的表头后面增加一列，每一条付款信息后面展示结果：
      
         1. 结果
         
            1. 成功：固定值「成功」，不展示其他内容。
            2. 解析失败：展示为「解析失败，{失败原因}」。
            3. 支付失败：展示为「支付失败，{失败原因}」。
            4. 失败：{其他失败原因，如服务异常等}

### 单笔付款

<callout emoji="🎈">
1. 根据费用场景（对内/对外），需调用网商不同的接口。

   1. 对内：协议代扣。2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>
   2. 对外：授权代付。2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>
</callout>

#### 对内付款（协议代扣）

1. 付款方

   1. 选择付款方门店：支持文本筛选的下拉框。用户输入文本后系统匹配门店名称在下拉框展示可选择的门店，用户点击后选择。
   2. 选择付款商户：支持文本筛选的下拉框。根据前面选择的门店，下拉框展示该门店关联的商户，如果门店只有一个商户则默认展示该商户。
2. 付款方式：选择「对内付款（协议代扣）」。

   1. 如果商户未开通「协议代扣」（无生效合约），勾选时toast通知「该商户暂未签约协议代扣，请联系商户完成协议代扣签约授权后再发起付款。」
3. 费用场景：单选费用场景。

   1. 费用场景说明文字：如果增加或修改费用场景，请点击[管理费用场景](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-MhfJdr4qToeFvIxiIofc6HfqnFe)。
   2. 费用场景管理页：
   
      1. 筛选费用场景
      
         1. 费用场景：对应列表中的场景名称列，文字匹配，支持关键词筛选（非完全匹配）。
         2. 状态：对应列表中的状态列，全部，已启用，已禁用。下拉单选。
      2. 操作
      
         1. 添加：添加费用场景，支持批量添加
         
            1. 名称：必填，费用场景名称文字。
            2. 新增费用场景：支持批量添加多个费用场景，点击后添加第二个费用场景。
            
               1. 从第二个费用场景开始，文本框后面展示「移除」图标，点击后可移除该费用场景文本框。
               2. 费用场景文本框至少保留一个。
            3. 状态：启用，禁用。单选，默认为启用，选择时有对应的状态说明文字。
            
               1. 启用：启用状态下，选择费用场景时将正常展示该场景。
               2. 禁用：禁用状态下，选择费用场景列表不展示该项场景。
      3. 列表
      
         1. 场景名称：费用场景名称文字。
         2. 状态：费用场景启用/禁用状态
         3. 操作
         
            1. 禁用：已启用的费用场景展示该按钮，点击后弹窗提示「禁用状态下，选择费用场景列表不展示该项场景。」。
            2. 启用：已禁用业务属性展示该按钮，点击后弹窗提示「启用状态下，选择费用场景时将正常展示该场景。」
            3. 编辑：仅可修改单个费用场景信息
            
               1. 名称：费用场景名称文字
               2. 状态：启用，禁用。单选，默认带入原状态，选择时有对应的状态说明文字，说明文字与添加时一致。
4. 收款方及金额

   1. 默认展示一组空白收款方。
   2. 用户可点击左下角的「新增收款方」按钮增加一组空白收款方。
   3. 从第二组收款方信息开始，后面展示删除按钮，可点击收款方后面的删除按钮删除这一组收款方信息。
   4. 至少保留一组收款方信息。
   5. 收款方信息填写：
   
      1. 选择收款方门店：支持文本筛选的下拉框。用户输入文本后系统匹配门店名称在下拉框展示可选择的门店，用户点击后选择。
      2. 选择收款商户：支持文本筛选的下拉框。根据前面选择的门店，下拉框展示该门店关联的商户，如果门店只有一个商户则默认展示该商户。
      3. 填写付款金额：付款金额以「元」为单位，支持小数点后两位。
5. 备注：文本框，不超过128字节。
6. 提交：

   1. 点击后系统进行数据有效性校验，如付款方商户ID有效性，费用类型，收款方信息完整性。
   2. 校验通过后调用网商`2.1授权协议支付申请接口<ant.mybank.bkcloudfunds.protocol.pay.apply>`接口发起支付申请。
   3. 接口调用失败时直接展示错误信息。
   4. 接口调用成功时页面变更为提交成功页。
   
      1. 标题：提交成功
      2. 文本：付款申请已提交，正在等待网商银行处理，稍后可刷新列表查看结果。
      3. 按钮：
      
         1. 返回列表：返回付款记录列表
         2. 再发起一笔付款：返回单笔付款页面。

#### 对外付款（授权代付）

1. 付款方

   1. 选择付款方门店：支持文本筛选的下拉框。用户输入文本后系统匹配门店名称在下拉框展示可选择的门店，用户点击后选择。
   2. 选择付款商户：支持文本筛选的下拉框。根据前面选择的门店，下拉框展示该门店关联的商户，如果门店只有一个商户则默认展示该商户。
2. 付款方式：选择「对外付款（授权代付）」。

   1. 如果商户未开通「授权代付」（无生效合约），勾选时toast通知「该商户暂未签约授权代付，请联系商户完成授权代付签约授权后再发起付款。」
3. 备注：文本框，不超过512字节。
4. 收款方及金额

   1. 填写备注：先勾选收款账户，并填写付款金额。如未找到收款账户，需前往签约授权完成签约授权。
   
      1. 签约授权：用蓝色字体标注，点击后跳转至「签约授权」-「合约管理」页面。
   2. 根据前面选择的付款方商户，系统拉取该商户生效的合约号，然后按场景展示该合约号对应合约中的各场景的收款账号。
   
      1. 如果用户在收款账户中没找到目标账户，需点击前面蓝色的「签约授权」文字回到签约授权-合约管理页面，点击签约授权按钮新增/修改商户合约以增加目标收款账户。
   3. 场景及限额信息：每个场景标题下方展示该场景的限额信息。
   
      1. 租金：该场景下单笔≤2.5万，所有收款方月度转账总和≤25万，最多可绑定5个收款方。
      2. 水电物业费：该场景下单笔≤2万，所有收款方月度转账总和≤10万，最多可绑定10个收款方。
      3. 合伙人：该场景下单笔≤10万，所有收款方月度转账总和≤40万，最多可绑定40个收款方。
      4. 工资：该场景下单笔≤2万，所有收款方月度转账总和≤25万，最多可绑定50个收款方。
      5. 报销代发：该场景下单笔≤1万，所有收款方月度转账总和≤10万，最多可绑定500个收款方。
   4. 勾选收款方并填写付款金额。
   
      1. 在每个场景中分别勾选收款账户。
      2. 填写后面对应的付款金额：付款金额以「元」为单位，支持小数点后两位。
      3. 需注意每个场景的限额信息。超过限额时网商会付款失败。
5. 提交：

   1. 点击后系统进行数据有效性校验，如付款方商户ID有效性，费用类型，收款方信息完整性。
   2. 校验通过后调用网商`2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口发起支付申请。
   3. 接口调用失败时直接展示错误信息。
   4. 接口调用成功时页面变更为提交成功页。
   
      1. 标题：提交成功
      2. 文本：付款申请已提交，正在等待网上银行处理，稍后可刷新列表查看结果。
      3. 按钮：
      
         1. 返回列表：返回付款记录列表
         2. 再发起一笔付款：返回单笔付款页面。

### 发起付款接口调用

#### 协议代扣

<table><colgroup><col/><col/><col/><col/><col/><col/><col/><col/></colgroup><thead><tr><th><b>序号</b></th><th><b>参数名</b></th><th><b>参数描述</b></th><th><b>数据类型</b></th><th><b>长度</b></th><th><b>出现要求</b></th><th><b>示例</b></th><th>传参</th></tr></thead><tbody><tr><td colspan="7"><b>基本参数</b></td><td></td></tr><tr><td>1</td><td>IsvOrgId</td><td>合作方机构号（网商银行分配）。</td><td>String</td><td>32</td><td>M</td><td></td><td>固定值：<code>202211000000000004381</code></td></tr><tr><td>2</td><td>OutTradeNo</td><td>代扣业务订单号</td><td>String</td><td>64</td><td>ME</td><td></td><td>{业务流水号}</td></tr><tr><td>3</td><td>Scene</td><td>业务场景：<br/>品牌协议代扣场景：PROTOCOL_WITHHOLD<br/>品牌协议代扣支持冻结场景：PROTOCOL_WITHHOLD_SUPPORT_FREEZE<br/>品牌协议代扣支持冻结和账号场景：PROTOCOL_WITHHOLD_SUPPORT_COMPONENT</td><td>String</td><td>32</td><td>M</td><td></td><td>固定值：PROTOCOL_WITHHOLD_SUPPORT_COMPONENT</td></tr><tr><td>4</td><td>TotalAmount</td><td>交易金额（分）</td><td>Number</td><td></td><td>M</td><td></td><td>{付款金额}</td></tr><tr><td><del>5</del></td><td>FreezeAmount</td><td>冻结部分出金（分）</td><td>Number</td><td></td><td>C</td><td>非必传<br/>PROTOCOL_WITHHOLD_SUPPORT_FREEZE场景下出现</td><td>传空</td></tr><tr><td><del>6</del></td><td>AvailableAmount</td><td>可用部分金额（分）</td><td>Number</td><td></td><td>C</td><td>非必传PROTOCOL_WITHHOLD_SUPPORT_FREEZE场景下出现</td><td>传空</td></tr><tr><td>7</td><td>Currency</td><td>币种</td><td>String</td><td>3</td><td>M</td><td>CNY</td><td>固定值：CNY</td></tr><tr><td>8</td><td>PayerId</td><td>付款方商户号</td><td>String</td><td>64</td><td>M</td><td></td><td>{付款方商户号}</td></tr><tr><td>9</td><td>PayerType</td><td>付款方类型：</td><td>String</td><td>16</td><td>M</td><td>MERCHANT</td><td>MERCHANT</td></tr><tr><td>10</td><td>PayeeId</td><td>收款方ID</td><td>String</td><td>64</td><td>M</td><td></td><td>{收款方商户号}</td></tr><tr><td>11</td><td>PayeeType</td><td>收款方类型</td><td>String</td><td>16</td><td>M</td><td>MERCHANT<br/>PLATFORM</td><td>MERCHANT</td></tr><tr><td>12</td><td>Memo</td><td>备注（可填写订单描述信息）</td><td>String</td><td>128</td><td>O</td><td></td><td>{备注}</td></tr><tr><td>13</td><td>PayerSpecifiedInfo</td><td>指定付方使用信息场景为本次新增场景时，外部需要指定时该字段必填！！不填的话由网商内部根据isv来进行配置</td><td>String</td><td>512</td><td><b>O</b></td><td>PayerSpecifiedInfo对象json结构进行base64encode </td><td>固定值：见下面的代码块</td></tr><tr><td>14</td><td>ExtInfo</td><td>扩展信息</td><td>String</td><td>512</td><td>O</td><td>map</td><td></td></tr></tbody></table>

PayerSpecifiedInfo → specifiedMerchantAmtComposition

```JSON
{
    "specifiedMerchantAmtComposition": {
        "componentPriorityList": [
            {
                "merchantBalanceComponent": "TRADE_DEPOSIT_AVAILABLE",// 保证金户
                "priority": 3
            },
            {
                "merchantBalanceComponent": "BALANCE_AVAILABLE",     // 可用子户解冻金额
                "priority": 2
            },
            {
                "merchantBalanceComponent": "BALANCE_FREEZE",        // 可用子户冻结金额
                "priority": 1
            }
        ]
    }
}
```

#### 授权代付

<table><colgroup><col/><col/><col/><col/><col/><col/><col/></colgroup><tbody><tr><td><b>参数名称</b></td><td><b>类型</b></td><td><b>长度</b></td><td><b>必填</b></td><td><b>参数描述</b></td><td><b>示例</b></td><td>传参</td></tr><tr><td colspan="6"><b>基本参数</b></td><td></td></tr><tr><td>IsvOrgId</td><td>String</td><td>32</td><td>M</td><td>合作方机构号（网商银行分配）</td><td> </td><td>固定值：202211000000000004381</td></tr><tr><td>OutTradeNo</td><td>String</td><td>64</td><td>M</td><td>外部订单请求流水号，外部请求的唯一标识。<br/><b>格式标准：</b>需要在尾部添加时间戳，格式为yyyyMMdd。<ul><li>外部需要保证重复请求不更换时间戳，否则会导致幂等击穿</li></ul></td><td>xxxxxx20230802</td><td>{业务流水号}</td></tr><tr><td>SceneCode</td><td>String</td><td>32</td><td>M</td><td>产品场景码。用于区分产品场景，映射平台操作配置。<ul><li>合伙模式联动场景：PARTNER_CASCADE_PAY</li></ul></td><td>PARTNER_CASCADE_PAY</td><td>固定值：<code>PARTNER_CASCADE_PAY</code></td></tr><tr><td>SubSceneCode</td><td>String</td><td>32</td><td>M</td><td>子场景码。用于区分细分各子场景，</td><td>SALARY</td><td><ul><li>合伙人：PARTNER</li><li>物业：RENT</li><li>水电煤：FEE</li><li>员工工资：SALARY</li><li>报销代发：CLAIM</li></ul></td></tr><tr><td>AgreementNo</td><td>String</td><td>64</td><td>M</td><td>协议支付合约号。签约接口返回的合约号。</td><td></td><td></td></tr><tr><td>PayerParticipant</td><td>String</td><td>2048</td><td>M</td><td>付款方（授权方）主体信息。具体参数见下文</td><td>Jsontostring格式<br/>base64编码</td><td></td></tr><tr><td>PayeeParticipant</td><td>String</td><td>2048</td><td>M</td><td>收款方主体信息。具体参数见下文</td><td>Jsontostring格式<br/>base64编码</td><td></td></tr><tr><td>TotalAmount</td><td>Number</td><td></td><td>M </td><td>支付金额（单位：分）</td><td>300</td><td></td></tr><tr><td>Currency</td><td>String</td><td>3</td><td>M</td><td>币种编码（如CNY）</td><td> </td><td></td></tr><tr><td>PayerFundInfo</td><td>String </td><td></td><td>O</td><td>付方资产信息，需要指定付方出资份额时必填</td><td>Jsontostring格式<br/>base64编码<ul><li>为空：<b>优先冻结部分出资，不足的由可用部分出资</b></li><li>不为空：<b>根据指定的出资金额出资</b></li></ul></td><td></td></tr><tr><td>PayerSpecifiedInfo</td><td>String</td><td>1024</td><td>O</td><td>指定付方使用信息<br/><b>场景为本次新增场景时，外部需要指定时该字段必填！！</b><br/><b>不填的话由网商内部根据isv来进行配置</b><br/><b>PayerFundInfo和PayerSpecifiedInfo不可同时存在</b></td><td>PayerSpecifiedInfo对象json结构进行base64encode </td><td></td></tr><tr><td>RequestTime</td><td>String</td><td>64</td><td>M</td><td>交易请求时间  yyyyMMddHHmmss</td><td></td><td></td></tr><tr><td>Memo</td><td>String</td><td>512</td><td>C</td><td>备注（可填写订单描述信息）</td><td></td><td></td></tr><tr><td>NotifyUrl</td><td>String</td><td>256</td><td>O</td><td>动态通知地址</td><td></td><td></td></tr><tr><td>MultiSaasScene</td><td>String</td><td>2</td><td>C</td><td>是否单品牌多SaaS场景：Y/N<br/>单品牌多SaaS场景必填</td><td>N </td><td></td></tr><tr><td>PassbackParams</td><td>String</td><td>1024</td><td>O</td><td>外部回传参数<br/>如果请求时传递了该参数，查询/回调时会回传该参数</td><td>map的Jsontostring格式<br/>base64编码</td><td></td></tr><tr><td>ExtInfo</td><td>String</td><td>1024</td><td>O</td><td>业务定制化扩展参数</td><td>map的Jsontostring格式<br/>base64编码</td><td></td></tr></tbody></table>

### 协议代扣退款

<callout emoji="🎈">
1. 协议代扣退款从付款单发起。
2. 一笔付款单可发起多次退款，退款总金额不超过原付款金额。

   1. 已退款金额：该付款单关联的状态为「成功」的退款单的金额总和。
   2. 退款在途金额：该付款单关联的状态为「处理中」的退款单的金额总和。
   3. 最大可退金额：最大可退金额=付款金额-已退款金额-退款在途金额。
3. 接口：

   1. 协议代扣退款申请接口<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>
   2. 协议代扣退款结果通知<ant.mybank.bkcloudfunds.protocol.witHHold.refund.result.notify>
   3. 协议代扣退款结果查询接口<ant.mybank.bkcloudfunds.protocol.witHHold.refund.query>
</callout>

#### 发起退款

1. 发起协议代扣退款：在付款记录列表、付款记录详情、协议代扣详情中点击「退款」按钮发起协议代扣退款。
2. 协议代扣退款弹窗：

   1. 业务流水号：带入原付款单业务流水号`OutTradeNo`。
   2. 付款方：带入原付款单付款方信息，格式为：{公司或门店名称}-{商户简称}。
   3. 收款方：带入原付款单收款方信息，格式为：{公司或门店名称}-{商户简称}。
   4. 付款金额：带入原付款单付款金额{TotalAmount}字段值，格式为：x.xx元，保留2位小数。
   5. 已退款金额：该付款单关联的状态为「成功」的退款单的退款金额总和。
   6. 退款在途金额：该付款单关联的状态为「处理中」的退款单的退款金额总和。
   7. 最大可退金额：最大可退金额=付款金额-已退款金额-退款在途金额。
   8. 退款金额：先单选全额退款或部分退款，默认选中全额退款
   
      1. 全额退款：单选全额退款时，将最大可退金额带入到退款金额文本框且不可修改。
      
         1. 备注文本：
         
            1. 将按最大可退金额发起退款。
            2. 最大可退金额=付款金额-已退款金额-退款在途金额。
      2. 部分退款：单选部分退款时，由用户输入退款金额，仅支持数字且保留两位小数。
      
         1. 退款金额文本框提示文字更新为：输入退款金额，精确到小数点后2位。
         2. 备注文本：
         
            1. 金额必须大于0且不超过最大可退金额。
            2. 最大可退金额=付款金额-已退款金额-退款在途金额。
   9. 退款原因：必填，文本域输入框，最多可输入128个字。
   10. 备注：非必填，文本域输入框，最多可输入128个字。
   11. 提交：用户点击确认后系统调用网商`协议代扣退款申请接口<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>`发起协议代扣退款申请。点击取消则关闭协议代扣退款申请弹窗。
   
       1. 前置校验：
       
          1. 必填项不为空。退款原因不为空且不超过256个字符。备注不超过256个字符。
          2. 退款金额为纯数字，且≤最大可退金额。
       2. 校验不通过：弹窗不关闭，仅通过以下方式报错。
       
          1. 必填项为空或不合法：将必填项文本框标红。
          2. 退款金额＞最大可退金额：toast提示：「退款金额不可超过最大可退金额，请重新输入。」
       3. 校验通过，调用网商协议代扣退款申请接口发起退款申请
       
          1. 接口调用成功，即网商返回退款网商订单号`{RefundOrderNo}`：
          
             1. 退款记录中新增一条退款记录数据，状态为「处理中」。
             2. 弹窗关闭，toast提示：「退款请求已提交，正在等待网商银行处理，稍后可刷新退款记录页面查看。」
          2. 接口调用失败，弹窗内toast提示失败原因，保留已填写内容以便用户修改后重试。
       4. 接口调用：`协议代扣退款申请接口<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>`
       
          | 序号 | 参数名 | 参数描述 | 类型 | 长度 | 必填 | 传值 |
          |-|-|-|-|-|-|-|
          | 1 | IsvOrgId | 合作方机构号（网商银行分配） | String | 64 | M | 固定值：`202211000000000004381` |
          | 2 | ParticipantType | 退款付方类型，即原支付单收方PayeeType。可选值：MERCHANT（商户）、PLATFORM（平台） | String | 16 | M | 原付款单收方`PayeeType` |
          | 3 | ParticipantId | 退款付方ID，即原支付单收方PayeeId。如果是商户则填 merchantId，如果是平台则填 isvOrgId | String | 64 | M | 原付款单收方`PayeeId` |
          | 4 | RelateOrderNo | 原支付单网商订单号OrderNo（原协议代扣订单号） | String | 64 | M | 原付款单订单号OrderNo |
          | 5 | RelateTransNo | 关联网商支付流水号。大额来账单次订单可不填，订单累计类型必填 | String | 64 | C | 原付款单网商支付流水号OperateNo |
          | 6 | OutRefundNo | 退款外部交易号。系统生成，唯一。同笔退款交易状态未明需重试时使用同一交易号 | String | 64 | M | 提交退款申请时系统生成，规则详见[协议代扣退款流水号](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-XBandRYG3omv3mxSmQTc01arnwf) |
          | 7 | RefundAmount | 订单退款金额，向渠道退款金额（单位：分） | Number | - | M | 用户提交的{退款金额} |
          | 8 | Currency | 币种，必须同原交易 | String | 3 | M | 同付款单 |
          | 9 | RefundReason | 退款原因 | String | 256 | M | 用户提交的{退款原因} |
          | 10 | ExtraInfo | 扩展信息 | String | 256 | O | 传空 |
          | 11 | Memo | 备注 | String | 256 | O | 用户提交的{备注} |

#### 退款记录

<callout emoji="🎈">
1. 退款申请提交成功后即创建一条退款记录。
2. 退款记录状态变更分别有通知接口和查询接口，建议通过通知接口收到通知后再用查询接口查一次退款单数据。
3. 数据来源接口

   1. 发起退款（创建退款单）：1.协议代扣退款申请接口`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>`
   2. 退款结果通知：2.协议代扣退款结果通知`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.result.notify>`
   3. 查询退款结果：3.协议代扣退款结果查询接口`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.query>`
</callout>

1. 筛选

   1. 退款流水号：对应列表中的退款流水号列，文本框输入，支持关键词筛选（非完全匹配）。
   
      1. 使用小技巧：仅输入退款流水号后8位（年月日），可快速定位当天的退款记录。
   2. 网商退款单号：对应列表中的网商退款单号列，文本框输入，支持关键词筛选（非完全匹配）。对应网商退款申请接口出参和退款通知/查询接口中的`RefundOrderNo`字段。
   3. 退款方
   
      1. 退款方名称：对应列表中的退款方列的退款方公司或门店名称，文本框输入，支持关键词筛选（非完全匹配）。
      2. 退款方商户简称：对应列表中的退款方列的退款方商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   4. 收款方
   
      1. 收款方名称：对应列表中的收款方列的退款方公司或门店名称，文本框输入，支持关键词筛选（非完全匹配）。
      2. 收款方商户简称：对应列表中的收款方列的退款方商户简称，文本框输入，支持关键词筛选（非完全匹配）。
   5. 状态：对应列表中的状态列，下拉单选，选项包含退款记录的所有状态。详见[协议代扣退款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-E1LZd8dlaonD3AxmXpAcpcbenKg)。
2. 操作

   1. 更新退款状态：点击后调用网商接口查询退款记录结果。

   <callout emoji="🎈">
   `接口：3.协议代扣退款结果查询接口<ant.mybank.bkcloudfunds.protocol.witHHold.refund.query>`
   </callout>

   1. 如未勾选任何记录：查询全部「处理中」状态的退款记录的最新结果。
   2. 如勾选记录中包含非「处理中」状态的记录，系统依次执行以下动作：
   
      1. 对已选择记录中非「处理中」状态的记录进行过滤。
      2. 对已选择记录中「处理中」状态的记录执行更新付款状态操作。
      3. 执行结果通知：
      
         1. 执行成功：toast提示：「退款状态更新成功，请刷新列表查看。」
         2. 执行失败：toast提示：「退款状态更新失败，请稍后重试。」
3. 列表

   <callout emoji="🎈">
   1. 列表数据来源：
   
      1. 发起退款（创建退款单）：1.协议代扣退款申请接口`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>`
      2. 退款结果通知：2.协议代扣退款结果通知`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.result.notify>`
      3. 查询退款结果：3.协议代扣退款结果查询接口`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.query>`
   </callout>

   1. 退款流水号：系统生成，唯一。对应网商`OutRefundNo`字段，退款流水号生成规则详见[协议代扣退款流水号](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-XBandRYG3omv3mxSmQTc01arnwf)。
   2. 网商退款单号：退款申请接口调用成功后网商返回，对应退款申请接口回参的`RefundOrderNo`字段值。
   3. 退款方：该退款单中的退款方主体和商户信息。退款方即原付款单中的收款方。对应网商退款申请接口`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.apply>`中的`ParticipantId`字段值（即原付款单的`PayeeId`），通过该字段值查询到的退款方信息。退款通知接口和退款查询接口也会返回该字段。
   
      1. 收款方为公司时：展示{公司名称}-{商户简称}。
      2. 收款方为门店时：展示{门店名称}-{商户简称}。
   4. 退款金额：该笔退款单的退款金额。单位元，到小数点后2位。对应网商退款申请接口，退款通知接口和退款查询接口中的`RefundAmount`字段值（单位为分，系统转换为元）。
   5. 收款方：对应网商`2.1协议授权代扣接口<ant.mybank.bkcloudfunds.order.witHHold.apply>`接口中的`付款方商户号PayerId`字段值，通过该字段值查询到的付款方信息。
   
      1. 收款方为公司时：展示{公司名称}-{商户简称}。
      2. 收款方为门店时：展示{门店名称}-{商户简称}。
   6. 退款原因：对应网商退款申请接口中的`RefundReason`字段值。发起退款时用户填写。
   7. 备注：对应网商退款申请接口中的`Memo`字段值。发起退款时用户填写。
   8. 状态：退款单状态，详见[协议代扣退款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-E1LZd8dlaonD3AxmXpAcpcbenKg)。
   9. 错误描述：退款单状态为「FAIL」时出现。对应退保结果查询接口`ErrorDesc`字段值。鼠标悬浮至提示符号时气泡展示完整错误描述。
   10. 完结时间：退款单网商侧完结时间，格式：yyyy-MM-dd HH:mm:ss。仅状态为「SUCCESS」的退款单出现，FAIL和DEALING状态的退款单完结时间显示为「-」。
   
       1. 对应网商退款结果通知接口和退款结果查询接口返回的`RefundFinishDate`字段值。
   11. 操作
   
       1. 详情：点击后进入退款单详情页。

#### 退款记录详情

<callout emoji="🎈">
退款记录信息：接口调用和数据来源同退款单列表。
付款信息：接口调用和数据来源同协议代扣付款单详情。
</callout>

1. 退款信息

   1. 退款流水号：系统生成，唯一。格式为`{3位自增数字编号}_{YYYYMMDD}`，退款申请发起时产生，对应网商`OutRefundNo`字段值。
   2. 退款方式：固定值：`对内退款（协议代扣退款）`。
   3. 网商退款单号：调用网商退款申请接口成功后网商返回，对应网商`RefundOrderNo`字段值。
   4. 退款方：即原付款单中的收款方。对应网商`ParticipantId`字段值对应的商户信息。
   
      1. 退款方为公司时：展示[公司名称]–(商户简称)。
      2. 退款方为门店时：展示[门店名称]–(商户简称)。
   5. 退款金额：数字为2位小数，单位元，格式为`{x.xx}元`，对应网商`RefundAmount`字段值。
   
      1. 冻结部分出金：退款方冻结子户退回金额，对应网商`退款结果通知`接口和`退款结果查询接口`的`FreezeAmount`字段值。
      2. 可用部分出金：退款方可用子户退回金额，对应网商`退款结果通知`接口和`退款结果查询接口`的`AvailableAmount`字段值。
   6. 收款方：对应网商协议授权代扣接口中的`PayerId`字段值对应的商户信息。
   
      1. 收款方为公司时：展示{公司名称}-{商户简称}。
      2. 收款方为门店时：展示{门店名称}-{商户简称}。
   7. 退款原因：发起退款申请时填写的退款原因，对应网商`RefundReason`字段值。
   8. 备注：发起退款申请时填写的备注信息，对应网商`Memo`字段值。
   9. 状态：退款单状态。处理中 / 成功 / 失败。状态为「失败」时鼠标悬浮至状态标签展示失败原因（对应网商`ErrorDesc`字段值）。
   10. 完成时间：退款单网商侧完结时间，格式：`yyyy-MM-dd HH:mm:ss`，对应网商`RefundFinishDate`字段值。仅状态为「成功」的退款单出现，处理中和失败状态显示为「-」。
2. 付款信息

   <callout emoji="🎈">
   1. 展示该退款单关联的原付款单信息。
   2. 数据来源于接口调用同协议代扣付款单详情。
   </callout>

   1. 业务流水号：原付款单的业务流水号，点击可跳转至对应的付款单详情页。
   2. 网商交易号：对应网商协议代扣接口的`OperateNo`字段值。
   3. 付款金额：数字为2位小数，单位元，格式为`{x.xx}元`，对应网商协议代扣接口的`TotalAmount`字段值。
   4. 状态：付款单状态，详见[协议代扣付款单状态](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-JVLSdFbDhoXLS6xPtNVcpy9cnLd)。
   5. 交易完结时间：原付款单完结时间，格式：`yyyy-MM-dd HH:mm:ss`，对应网商协议代扣通知和查询接口的`交易完结时间FinishDate`字段值。
   6. 已退款金额：该付款单下所有状态为「成功」的退款单退款金额总和。
   7. 退款在途金额：该付款单下所有状态为「处理中」的退款单退款金额总和。
   8. 最大可退金额：原付款金额 - 已成功退款金额 - 处理中退款金额。
   
      1. 退款：
      
         1. 最大可退金额＞0时展示该按钮；最大可退金额≤0时隐藏该按钮。
         2. 点击后发起退款，交互和接口调用详见[协议代扣发起退款](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-J2wqd4kKgoh6ZTxuT1JcJQwQnWd)。
   9. 退款记录：原付款单关联的退款单列表。
   
      1. 表格字段含义及取值在[退款记录](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-JxlLd427lo70JVxcFO0cILUSngc)中有详细说明。
      2. 「详情」按钮交互逻辑与退款记录列表一致，点击后跳转至[退款记录详情](https://bcno92iwldd2.feishu.cn/docx/P4eedyyrhoWE5HxC1AtcCPvtnWc#share-B30kdqv0KoDSvPxuagVc4PEbnEc)页。
