## 区域划分

1. 筛选区域

   1. 区域名称：文字匹配，支持关键词筛选（非完全匹配）。
   2. 状态：全部，已启用，已禁用。
2. 添加区域：支持批量添加

   1. 名称：必填，区域名称文字。
   2. 新增区域：支持批量添加多个区域，点击后添加第二个区域的名称。
   3. 状态：启用，禁用。单选，默认为启用，选择时有对应的状态说明文字。
   
      1. 启用：启用状态下，选择区域时将正常展示该区域。
      2. 禁用：禁用状态下，选择区域列表不展示该项区域。
3. 区域展示列表

   1. 区域名称：区域名称文字。
   2. 状态：区域启用/禁用状态
   3. 操作
   
      1. 禁用：已启用的区域展示该按钮，点击后弹窗提示「禁用状态下，选择区域列表不展示该项区域。」。
      2. 启用：已禁用区域展示该按钮，点击后弹窗提示「启用状态下，选择区域时将正常展示该区域。」
      3. 编辑：仅可修改单个区域信息
      
         1. 区域名称：区域名称文字
         2. 状态：启用，禁用。单选，默认带入原状态，选择时有对应的状态说明文字。


## 业务属性

1. 筛选业务属性

   1. 业务属性名称：文字匹配，支持关键词筛选（非完全匹配）。
   2. 状态：全部，已启用，已禁用。单选。
2. 添加业务属性：支持批量添加

   1. 名称：必填，业务属性名称文字。
   2. 新增业务属性：支持批量添加多个业务属性，点击后添加第二个业务属性名称。
   3. 状态：启用，禁用。单选，默认为启用，选择时有对应的状态说明文字。
   
      1. 启用：启用状态下，选择业务属性时将正常展示该业务属性。
      2. 禁用：禁用状态下，选择业务属性列表不展示该项业务属性。
3. 业务属性展示列表

   1. 业务属性名称：业务属性名称文字。
   2. 状态：业务属性启用/禁用状态
   3. 操作
   
      1. 禁用：已启用的业务属性展示该按钮，点击后弹窗提示「禁用状态下，选择业务属性列表不展示该项业务属性。」。
      2. 启用：已禁用业务属性展示该按钮，点击后弹窗提示「启用状态下，选择业务属性时将正常展示该业务属性。」
      3. 编辑：仅可修改单个业务属性信息
      
         1. 业务属性名称：业务属性名称文字
         2. 状态：启用，禁用。单选，默认带入原状态，选择时有对应的状态说明文字。


## 角色

1. 超级管理员角色：拥有所有业务模块的所有管理权限。


## 账户

1. 预置一个管理员账户

   1. 账户：admin
   2. 密码：care2026

---


## 公司和门店编码生成规则

### 总部公司编码

1. 格式：`{CARE}BD{3位自增数字编号}`
2. 示例：CAREBD001，表示可柔品牌在系统内添加的第一个总部公司。
3. 解释

   1. {CARE}：品牌名缩写，可柔品牌的所有总部公司统一为「CARE」开头。
   2. BD：固定值，BRAND的缩写。
   3. {3位自增编号}：表示系统内添加的第几个公司，自增，顺序按公司主体在本系统中的创建顺序决定。
4. 删改规则：总部公司编码一经生成不可删除，不可修改。

### 区域公司编码

1. 格式：`{CARE}REG{001}{3位自增数字编号}`
2. 示例：CAREREG001001，表示可柔品牌在编号为001的区域系统内添加的1个区域公司。
3. 解释：

   1. {CARE}：品牌名，可柔品牌的所有区域公司统一为「CARE」开头。
   2. REG：固定值，Regional的缩写。
   3. {001}：区域编号，随新增区域自增，因为区域名称和格式长度不确定。
   4. {3位自增编号}：表示该区域内添加的第几个公司，顺序按公司主体在本系统中的创建顺序决定。
4. 删改规则：区域公司编码一经生成不可删除，不可修改。

### 门店编码

1. 格式：`{品牌名}{省份缩写}{YYYYMMDD}{3位自增数字编号}`
2. 示例：CAREBJ20260415001
3. 解释：

   1. `{品牌名}`：品牌名缩写，可柔品牌的所有门店统一为「CARE」开头。
   2. `{省份缩写}`：见下表。
   3. `{YYYYMMDD}`：店铺创建日期。
   4. `{3位自增编号}`：该地区对应日期的第几家店，不跨日期计算，也不会跨省份计算，顺序按门店在本系统中的创建顺序决定。
4. 删改规则：门店编码一经生成不可删除，不可修改。

   <sheet sheet-id="uQ8Vv7" token="B7wdsRcsChjCl8tcsLtcNW3snFd"></sheet>

### 外部商户号（商户编码）

1. 格式：`{商户关联主体的编码}_{2位自增数字}`
2. 示例：`CAREBJ20260415001_01`，表示编码为CAREBJ20260415001的门店关联的第一个商户
3. 解释

   1. `{商户关联主体的编码}`：如果是总部公司则为总部公司编码，区域公司为区域公司编码，门店为门店编码。
   2. `-`：固定值，连接符号。
   3. `{2位自增编号}`：表示商户对应主体添加的第几个商户，自增，顺序按关联主体在本系统中新增注册码的时间顺序决定。
4. 删改规则：外部商户号一经生成不可删除，不可修改。


## 商户入驻状态

1. 入驻状态包含网商以下接口返回值：

   1. 商户预入驻结果查询接口`<ant.mybank.merchantprod.merch.register.query>`中的预入驻状态`RegisterStatus`字段。
   2. 预入驻激活结果通知接口中的`RegisterStatus`字段。
   3. 预入驻激活结果查询接口`< ant.mybank.merchantprod.merch.applet.register.query>`中的`RegisterStatus`字段。
   4. 小程序入驻商户注册通知接口`<ant.mybank.merchantprod.merch.notify>`中的`RegisterStatus`字段。
   5. 小程序入驻结果查询接口`<ant.mybank.merchantprod.merch.applet.register.query>`中的`RegisterStatus`字段。
2. 状态说明

   1. 未入驻：商户在本系统（「新增注册码」按钮）刚创建时的初始状态。
   2. 预入驻审核中：商户预入驻申请提交后等待网商审核时的状态。
   
      1. 调用网商`商户预入驻接口<ant.mybank.bkmerchantprod.merch.applet.pre.register>`成功后获得`OrderNo`后的状态。
      2. 调用网商`商户预入驻结果查询接口<ant.mybank.merchantprod.merch.register.query>`返回的`RegisterStatus`字段`0：审核中`状态。
   3. 待激活：商户预入驻成功，等待继续激活时的状态。
   
      1. 调用网商`商户预入驻结果查询接口<ant.mybank.merchantprod.merch.register.query>`返回的`RegisterStatus`字段`1：成功`状态。
   4. 预入驻失败：商户预入驻失败，会返回失败原因
   
      1. 调用网商`商户预入驻结果查询接口<ant.mybank.merchantprod.merch.register.query>`返回的`RegisterStatus`字段`2：失败`状态。
   5. 激活中：预入驻+激活的商户在预入驻成功后通过激活接口执行激活操作后通过以下接口查询到的激活状态。小程序入驻商户发起入驻后通过以下接口查询到的激活状态。
   
      1. 网商`激活结果通知接口`返回的注册中状态。
      2. 调用网商`激活结果查询接口< ant.mybank.merchantprod.merch.applet.register.query>`返回的`RegisterStatus`字段`0：注册中`状态。
      3. 调用网商`小程序入驻结果查询接口<ant.mybank.merchantprod.merch.applet.register.query>`返回的`RegisterStatus`字段`0：注册中`状态。
   6. 激活成功：预入驻商户激活成功，小程序入驻商户入驻成功。
   
      1. 网商`激活结果通知接口`返回的成功状态。
      2. 调用网商预入驻`激活结果查询接口< ant.mybank.merchantprod.merch.applet.register.query>`返回的`RegisterStatus`字段`1：成功`状态。
      3. 小程序入驻`商户注册通知接口<ant.mybank.merchantprod.merch.notify>`返回的`RegisterStatus`字段`1：成功`状态。
      4. 调用网商`小程序入驻结果查询接口<ant.mybank.merchantprod.merch.applet.register.query>`返回的`RegisterStatus`字段`1：成功`状态。
   7. 激活失败：商户激活失败
   
      1. 网商`激活结果通知接口`返回的失败状态。
      2. 网商预入驻`激活结果查询接口< ant.mybank.merchantprod.merch.applet.register.query>`返回的`RegisterStatus`字段`2：失败`状态。
      3. 小程序入驻`商户注册通知接口<ant.mybank.merchantprod.merch.notify>`返回的`RegisterStatus`字段`2：失败`状态。
3. 商户入驻状态与网商接口字段映射

   | 前端展示的状态 | `商户预入驻结果查询`接口 | `预入驻激活结果通知`接口 | `预入驻激活查询`接口 | 小程序入驻`商户注册通知`接口 | 小程序`入驻结果查询`接口 |
   |-|-|-|-|-|-|
   | 未入驻 | - | - | - | - | - |
   | 预入驻审核中 | 0：审核中 | - | - | - | - |
   | 待激活 | 1：成功  | - | - | - | - |
   | 预入驻失败 | 2：失败 | - | - | - | - |
   | 激活中 | - | 商户激活查询接口一致 | 0：注册中 | - | 0：注册中 |
   | 激活成功 | - | 商户激活查询接口一致 | 1：成功 | 1：成功 | 1：成功 |
   | 激活失败 | - | 商户激活查询接口一致 | 2：失败 | 2：失败 | - |
4. 状态流转

   <whiteboard token="SdTywFBLmhs0HEblmjbcPlaqnSb"></whiteboard>


## 资金账单下载

<callout emoji="🎈">
1. 接口文档：[https://loan-platform.yuque.com/vo42xq/kv7qv1/rgws07ofvxr0koge](https://loan-platform.yuque.com/vo42xq/kv7qv1/rgws07ofvxr0koge)
2. 接口地址：<ant.mybank.bkmbp.stmt.fund.stmt.apply> 1.0.0
</callout>

1. 入参

   <table><colgroup><col/><col/><col/><col/><col/></colgroup><thead><tr><th><b>序号</b></th><th><b>参数名</b></th><th><b>参数描述</b></th><th><b>示例</b></th><th>入参说明</th></tr></thead><tbody><tr><td colspan="4"><b>基本参数</b></td><td></td></tr><tr><td>1</td><td>IsvOrgId</td><td>合作方机构号（网商银行分配）</td><td></td><td><code>202211000000000004381</code></td></tr><tr><td>2</td><td>Date</td><td>账单日期，格式为yyyyMMdd<br/>日期规则如下:<ol><li seq="1">Date &lt; Today (当日生成昨日对账单，所以申请时间需早于当日)</li><li>六个月前的当月一日 &lt;= Date</li><li>isv入驻时间 &lt;= Date</li></ol></td><td>20260612</td><td>最大查询范围：<br/>6个月前的当月1日&lt;= Date（入参）&lt; Today<br/>即可查询6个月前当月1日到昨天的账单</td></tr><tr><td>3</td><td>OutRequestNo</td><td>外部交易号。由合作方系统生成，只能包含字母、数字、下划线；需保证合作方系统不重复。</td><td></td><td>每次请求时自动生成<br/>{年月日}_{4位自增id}</td></tr><tr><td>4</td><td>Type</td><td>下载账单类型</td><td>OFF_MERCH_FUND_DETAIL_STMT：商户子户-明细OFF_MERCH_FUND_DETAIL_DAILY_STMT：商户子户-日汇总OFF_COMMON_FUND_DETAIL_STMT：平台清算专户-明细OFF_COMMON_FUND_DAILY_STMT：平台清算专户-日汇总</td><td>查询商户余额收支明细：OFF_MERCH_FUND_DETAIL_STMT<br/>包括商户可用子户和交易保证金子户的明细</td></tr><tr><td>5</td><td>FundAccountType</td><td>资金账号类型</td><td>资金账号类型：<br/>查询平台清算专户时必传：CLEARED<br/>下载如下两种账单类型时必传：<br/>OFF_COMMON_FUND_DETAIL_STMT：平台清算专户-明细OFF_COMMON_FUND_DAILY_STMT：平台清算专户-日汇总</td><td>查询商户余额收支明细：传空</td></tr></tbody></table>
2. 出参

   | **序号** | **参数名** | **参数描述** | **示例** | 参数说明 |
   |-|-|-|-|-|
   | 1.         | RespInfo | 返回码组件 |   |  |
   | 2.       | IsvOrgId | 网商分配的isv机构号 |  | `202211000000000004381` |
   | 3 | Date | 账单日期，格式为yyyyMMdd |  |  |
   | 4 | OutRequestNo | 外部交易号。由合作方系统生成，只能包含字母、数字、下划线；需保证合作方系统不重复 |  |  |
   | 5 | Type | 下载账单类型  <br/>OFF_MERCH_FUND_DETAIL_STMT：资金明细账单  <br/>OFF_MERCH_FUND_DETAIL_DAILY_STMT：资金明细日汇总账单  <br/>OFF_COMMON_FUND_DETAIL_STMT：通用资金变动明细账单  <br/>OFF_COMMON_FUND_DAILY_STMT：通用资金变动日汇总账单 |  |  |
   | 6 | DownloadUrl | 对账文件下载链接**(五分钟有效期)** | base64加密 | 对账文件下载链接(五分钟有效期) |

   1. 账单文件名称规则：
   
      1.   商户：
      
         1. 商户账户资金账单-【申请日期】
         2. 商户账户资金日汇总账单-【申请日期】
      2.  监管子户：
      
         1. 【平台名称】-平台监管子户资金变动日汇总账单-【申请日期】
         2. 【平台名称】-平台监管子户资金变动明细账单-【申请日期】
   2. 账单文件明细
   
      | 英文字段名 | 参数描述（中文名） | 字段值示例 | 字段值选项/示例 | 参数说明 |
      |-|-|-|-|-|
      | isv_org_id | 合作方机构号  <br/>（网商银行分配） | 202210066666666666666 |  | 202211000000000004381 |
      | id | 资金明细id | 202509171133423140000000000196029113 |  |  |
      | card_nbr | 业务账户编号 | 9900116208799402999 | 平台：9903开头的清算专户账号  <br/>商户：网商商户号 | 用这个字段区分商户 |
      | card_type | 业务账户类型 | PLATFORM_CUSTODY | BALANCE：商户交易资金（可用子户）  <br/>TRADE_DEPOSIT：商户充值资金（交易保证金户）  <br/>PLATFORM_CUSTODY：平台清算专户子户 | 商户子户：  <br/>可用子户：BALANCE：商户交易资金  <br/>保证金户：TRADE_DEPOSIT：商户充值资金  <br/>平台  <br/>平台清算专户：PLATFORM_CUSTODY：平台清算专户子户 |
      | gmt_acnt | 记账时间 | 2025/09/17 11:33:42 | yyyy-mm-dd HHmiss |  |
      | amt | 交易金额 | 1 | 单位：分 |  |
      | ccy | 币种（默认156，人民币） | 156 | 156 |  |
      | balance | 交易后余额 | 361 | 单位：分 |  |
      | in_out_flag | 收支标记 | 1 | 0：收入  <br/>1：支出 |  |
      | opst_card_name | 对手方名称 | 沈超 |  |  |
      | opst_card_no | 对手方卡号 | 22680100002669999999 |  |  |
      | opst_org_name | 对手方机构名称 | 浙江网商银行 |  |  |
      | remark | 备注 | （其它）创建D0订单并支付 |  |  |
      | order_no | 网商订单号 | 202509911703595364 |  |  |
      | trade_no | 网商操作流水号 | 2025091710152061006100910004601473 |  |  |
      | out_trade_no | 平台订单号 | 5a11753c74ce4f9ca5eeb83cdae7534d |  |  |


## 商户提现

### 提现业务流水号

<callout emoji="🎈">
1. 系统调用接口发起商户余额提现时需生成提现业务流水号
2. 系统流水号对应网商`商户单笔提现申请接口<ant.mybank.bkcloudfunds.withdraw.apply>`接口中的`OutTradeNo`字段。
</callout>

1. 格式：`{YYYYMMDD}{4位自增数字编号}`
2. 示例：20260509_0001，表示2026年5月9日生成的第1个提现业务流水号。
3. 释义

   1. {YYYYMMDD}：年月日，系统流水号生成日期。
   2. {4位自增数字编号}：表示该日期创建的第x个系统流水号，自增，顺序按系统中生成系统流水号的时间顺序决定。
4. 删改规则：系统流水号一经生成不可删除，不可修改。

   1. 系统流水号在系统中和申请单一一对应。

### 提现申请单状态

<callout emoji="🎈">
1. 商户通过小程序或者API接口发起提现。
2. 提现申请单状态来源

   1. 3 提现结果通知接口（异步接口）<ant.mybank.bkcloudfunds.withdraw.notify>
   2. 4 单笔提现查询接口（异步接口）<ant.mybank.bkcloudfunds.withdraw.query>
</callout>

1. 提现申请单状态来源

   <table><colgroup><col/><col/><col/><col/><col/></colgroup><thead><tr><th>查询方式</th><th>接口</th><th>状态字段</th><th>状态值</th><th>使用场景</th></tr></thead><tbody><tr><td>被动通知</td><td>3 提现结果通知接口（异步接口）&lt;ant.mybank.bkcloudfunds.withdraw.notify&gt;</td><td>状态<code>Status</code></td><td>SUCCESS=成功<br/>FAIL=失败</td><td><ol><li seq="1">商户发起提现申请后，网商处理提现请求，通知品牌方提现结果。</li></ol></td></tr><tr><td>主动触发</td><td>4 单笔提现查询接口（异步接口）&lt;ant.mybank.bkcloudfunds.withdraw.query&gt;</td><td>状态<code>Status</code></td><td>SUCCESS=成功<br/>DEALING=处理中<br/>FAIL=失败</td><td><ol><li seq="1">平台收到体下你通知后提现通知后主动查询确认提现申请单终态。</li><li>通过品牌商费用对账文件拿到新的提现单，通过此接口查询提现单详情和状态。</li></ol></td></tr></tbody></table>
2. 提现申请单状态与接口字段映射

   | 状态名称 | 3 提现结果通知接口（异步接口）  <br/>状态值（`Status`） | 4 单笔提现查询接口（异步接口）  <br/>状态值（`Status`） | 状态类型 | 说明 |
   |-|-|-|-|-|
   | 处理中 | - | DEALING=处理中 | 中间态 | 提现申请提交成功，等待网商处理 |
   | 成功 | SUCCESS=成功 | SUCCESS=成功 | 终态 | 提现到账，提现成功 |
   | 失败 | FAIL=失败 | FAIL=失败 | 终态 | 提现未到账，提现失败 |

### 品牌提现手续费

<callout emoji="🎈">
商户将其子户余额提现至银行卡时，会产生手续费，从系统角度来讲，手续费分为品牌手续费和网商手续费。
1. 品牌手续费：商户提现申请发起时，品牌方会从商户申请提现金额中扣除一笔钱作为品牌手续费。商户提现实际到账金额
2. 网商手续费：商户提现成功后，D+1网商从平台保证金户中扣除平台维度的手续费（已知包括提现手续费和授权代付手续费），D+2平台向网商申请对账文件，获取平台维度的手续费扣除明细。
</callout>

1. 品牌提现手续费在商户余额提现时在提现申请接口`商户单笔提现申请接口<ant.mybank.bkcloudfunds.withdraw.apply>`中直接向商户收取。
2. 品牌提现手续费默认比例0.1%，即品牌提现手续费=提现申请中填写的`提现金额`×`0.1%`。
3. 商户提现实际到账金额=提现申请中填写的`申请提现金额`-`品牌提现手续费`。

### 网商提现手续费

<callout emoji="🎈">
1. 商户提现产生的网商提现手续费数据通过品牌方费用对账文件获取。
2. 商户提现产生的网商提现手续费费用从品牌方保证金户扣除，具体流程如下：

   1. 发起商户提现：调用网商发起提现接口发起提现，提现实际到账金额=申请提现金额-品牌提现手续费，提现至商户结算卡。
   2. 网商收取手续费：网商次日（D+1）从品牌方8888结算户（保证金户）收取前一日品牌所有商户提现产生的手续费。
   
      1. 网商提现手续费=申请提现金额\*0.05%。
   3. 网商提现手续费账单：品牌方第三日（D+2）凌晨3点从网商拉取品牌方费用对账文件，即前一日品牌方向网商已支付的的手续费账单。
   
      1. 申请获取`品牌商费用对账文件`
      
         1. 接口文档：https://loan-platform.yuque.com/vo42xq/kv7qv1/kyiyc2hqw4722tsw
         2. 接口地址：`品牌商费用对账文件申请（适用于品牌自付费）<ant.mybank.bkmbp.stmt.fee.file.apply> 1.0.0`
         3. 核心入参:
         
            1. StartTime/EndTime：账单起止日期，格式为yyyyMMddHHmmss
            
               1. 如明细账单类型则截取前14位，闭区间（明细账单按此规则）
               2. 如日汇总类型则截取前8位，闭区间
               3. 如月汇总类型则截取前6位，闭区间
            2. OutRequestNo：业务流水号
            
               1. `{YYYYMMDD}{3位自增数字编号}`
            3. StmtType：账单类型
            
               1. 品牌商收费账单明细文件（PLAT_FEE_STMT_BILL）（明细账单传）
               2. 品牌商收费日账单文件（PLAT_FEE_DAY_SUMMARY_STMT_BILL）
               3. 品牌商收费月账单文件（PLAT_FEE_MON_SUMMARY_STMT_BILL）
         4. 核心出参：
         
            1. BackOrderNo：网商流水号
      2. 查询对账文件申请结果
      
         1. 接口文档：https://loan-platform.yuque.com/vo42xq/kv7qv1/yklamuh1wvxr3xkg
         2. 接口地址：<ant.mybank.bkmbp.stmt.apply.result.common.query> 1.0.0
         3. 核心入参：
         
            1. StmtType：账单类型
            
               1. 品牌商收费账单明细文件（PLAT_FEE_STMT_BILL）（明细账单传）
            2. OutRequestNo：业务流水号
            
               1. `{YYYYMMDD}{3位自增数字编号}`
            3. BackOrderNo：网商流水号
         4. 核心出参：
         
            1. 申请状态：Status
            2. 电子回单CDN下载链接：PdfDownloadUrl（有效期5分钟）
      3. 申请结果通知
      
         1. 接口文档：https://loan-platform.yuque.com/vo42xq/kv7qv1/yklamuh1wvxr3xkg
         2. 接口地址：<ant.mybank.bkmbp.stmt.apply.result.common.notify> 1.0.0
         3. 核心入参：
         
            1. 申请状态：Status
            2. 电子回单CDN下载链接：PdfDownloadUrl（有效期5分钟）
   4. 筛选提现手续费账单：从账单表格中筛选提现手续费账单（提现（小程序模式）和提现（API模式）），用筛选出的所有手续费账单跟前面提现通知接口返回的提现订单比对：
   
      1. 如果有新增的订单，则通过`4 单笔提现查询接口（异步接口）<ant.mybank.bkcloudfunds.withdraw.query> `接口查询提现订单详情，获取提现商户，将该提现记录展示在对应的商户提现记录列表。
</callout>


## 清算订单状态

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

### POS机绑定状态

1. 状态定义：

   1. 未绑定商户：POS未跟任何商户有绑定关系。
   2. 已绑定商户：POS跟商户已建立绑定关系。
2. 状态变更

   <whiteboard token="B5HawgqOdhB2Ptb6ze2ciGFUnrd"></whiteboard>


## 清算批次号生成规则

1. 格式：`{CARE}{YYYYMMDD}_{2位自增数字编号}`
2. 示例：CARE20260509_01，表示可柔品牌2026年5月9日生成的第一个清算批次。
3. 解释

   1. {CARE}：品牌名，可柔品牌的所有清算批次「CARE」开头。
   2. {YYYYMMDD}：年月日，清算批次创建日期。
   3. -：固定值，区分符号。
   4. {2位自增数字编号}：表示该品牌对应日期创建的第几个清算批次，自增，顺序按系统中新增批次的时间顺序决定。
4. 删改规则：清算批次号一经生成不可删除，不可修改。

   1. 清算批次号在清算文件和创建批次接口中一一对应使用。
   2. 清算文件在未使用（未清算）时可撤回或删除。重新生成清算文件和新建批次时清算批次号也按本规则生成新的批次号。


## 清算文件状态

1. 状态定义：

   1. 待上传：清算文件通过清算订单在本系统生成时的初始状态，此时尚未按网商规范进行文件上传。
   2. 已作废：「待上传」「上传失败」和「已撤回」状态的清算文件执行「作废」操作后的状态，作废后该文件不能再上传，也不能通过该文件新建批次，文件中的所有订单状态恢复为「已上送」。
   3. 上传失败：「待上传」状态的清算文件按网商规范发起文件上传操作失败（网络异常、参数校验驳回、网关报错等）时的状态。
   4. 已上传：「待上传」状态的文件已按照网商规范完成上传，文件层面已就绪，待创建清算批次。
   5. 已撤回：「已上传」状态的清算文件，在清算批次未上报之前可撤回（从网商网盘中删除）。
   6. 待上报：「已上传」状态的清算文件对应的清算批次创建成功，批次为「待上报」状态时的状态。
   7. 上报失败：「待上报」状态清算批次调用网商`创建批次接口`失败（网络异常、参数校验驳回、网关报错等）批次状态为「上报失败」时对应的清算文件的状态。
   8. 清算中：「待上报」状态的批次调用网商`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`上报清算批次成功后批次状态为「清算中」时对应的清算文件的状态。
   9. 清算成功：「清算中」状态的批次待网商侧整批清算流程执行完成后，系统通过`补单批次完结通知接口`和`批次查询接口`获得清算结果为「清算成功」时对应的清算文件的状态。
   10. 部分成功：「清算中」状态的批次待网商侧整批清算流程执行完成后，系统通过`补单批次完结通知接口`和`批次查询接口`获得清算结果为「部分成功」时对应的清算文件的状态。
   11. 清算失败：「清算中」状态的批次待网商侧整批清算流程执行完成后，系统通过`补单批次完结通知接口`和`批次查询接口`获得清算结果为「清算失败」时对应的清算文件的状态。
2. 状态流转

   <whiteboard token="CWeYwVia1hxlAWbWTYScvIQJnRc"></whiteboard>


## 清算批次状态

1. 状态说明

   1. 待上报：清算批次通过清算文件在本系统创建成功后的初始状态，此时本系统保存批次数据，未调用网商创建批次接口。
   2. 上报失败：「待上报」状态的批次调用网商`创建批次接口`失败（网络异常、参数错误、接口返回业务拒绝）时的状态，可通过是否拿到到网商`批次实例号`来判断。
   3. 已作废：「待上报」和「上报失败」状态的批次执行「作废」操作后的状态，已作废的批次不能再发起上报与清算。批次作废时对应的清算文件状态同步变更为「已作废」。
   4. 清算中：「待上报」状态的批次调用网商`创建批次接口<ant.mybank.bkcloudbatch.batch.create>`成功后网商处理清算批次中的状态，可通过是否拿到网商批次实例号`Batchlnstanceld`来判断。
   5. 清算成功：「清算中」状态的批次通过`批次完结通知`和`批次查询接口`获得的批次清算结果中的`SUCCESS`状态。
   6. 部分成功：通过`批次完结通知`或`批次查询接口`获得的批次清算结果中的`PART_SUCCESS`状态。
   7. 清算失败：通过`批次完结通知`或`批次查询接口`获得的批次清算结果中的`FAIL`状态。
2. 状态映射

   | 前端展示的状态 | `批次完结通知`接口 | `批次查询`接口 |
   |-|-|-|
   | 待上报 | - | - |
   | 上报失败 | - | - |
   | 已作废 | - | - |
   | 清算中 | - | DEALING |
   | 清算成功 | SUCCESS | SUCCESS |
   | 部分成功 | PART_SUCCESS | - |
   | 清算失败 | FAIL | FAIL |
3. 状态流转

   <whiteboard token="NM1Kw1ZT3h4lkabjg6ucJ7Kjnag"></whiteboard>

<whiteboard token="RCUCwvrtNhomFxbsCB7cWqiundc"></whiteboard>


## 退款扣保

### 扣保单状态

<callout emoji="🎈">
1. 退款扣保发生后，品牌方需调用退保接口发起退保申请。故扣保单状态分两部分来源：

   1. 系统定义。扣保单未发起退保申请时的初始状态由本系统定义。
   2. 从发起退保开始的后续状态从退保单映射。
   
      1. 退保单状态来源：`退保结果查询接口function：<ant.mybank.bkcloudbatch.stmt.deposit.return.query>`接口的`Status`字段。
</callout>

1. 状态说明

   1. 待发起：收到网商扣保通知时创建的扣保单的初始状态。
   2. 处理中：退保处理中状态有两种触发方式
   
      1. 调用申请退保接口成功，退保单状态变更为处理中，同时扣保单状态也变更为处理中。
      2. 调用网商退保结果查询接口，网商返回的`Status`字段的值为`DEALING`。
   3. 退保成功：退保成功状态有两种触发方式
   
      1. 收到退保通知时代表退保成功。
      2. 通过查询接口获得，对应查询接口返回`Status`字段的`SUCCESS`值。
   4. 退保失败：调用网商退保结果查询接口，网商返回的`Status`字段的值为`FAIL`。退保失败时接口同时返回失败原因`{Msg}`。
2. 状态映射

   | 状态名称 | `补单保证金扣除&退回通知` | 退保查询接口  <br/>状态值（Status） |
   |-|-|-|
   | 待发起 | - | - |
   | 处理中 | - | DEALING |
   | 退保成功 | 收到退保通知即代表退保成功 | SUCCESS |
   | 退保失败 | - | FAIL |

### 退保流水号

1. 格式：`{扣保单号}_{2位自增数字编号}`。
2. 示例：`DepositPayId_01`，表示扣保单号为DepositPayId的扣保单的第01个退保单流水号，原则上一个退保单只有一个扣保单。
3. 解释

   1. `DepositPayId`：扣保单据号，在`补单保证金扣除`通知接口中返回。
   2. -：固定值，连接符号。
   3. {2位自增数字编号}：表示该扣保单的第x个退保单，从01开始递增。
4. 删改规则：退保流水号一经生成不可删除，不可修改。

   1. 退保流水号和扣保单号一一对应。


## 合约变更系统流水号

<callout emoji="🎈">
1. 协议代扣和授权代付合约变更（签约，修改，解约，解约审核）时产生申请单，每个申请单有唯一的系统流水号。
2. 系统流水号对应网商接口中的`OutTradeNo`字段。
</callout>

1. 格式：`{N/W}{YYYYMMDD}{4位自增数字编号}`
2. 示例：N20260509_0001，表示2026年5月9日生成的第1个系统流水号。
3. 解释

   1. {N/W}：协议代扣或授权代付标识。
   
      1. N：指代协议代扣。协议代扣是体系内子户划转，对内，用N指代。
      2. W：指代授权代付。授权代付是对外部账户付款，对外，用W表示。
   2. {YYYYMMDD}：年月日，系统流水号生成日期。
   3. {4位自增数字编号}：表示该日期创建的第x个系统流水号，自增，顺序按系统中生成系统流水号的时间顺序决定。
4. 删改规则：系统流水号一经生成不可删除，不可修改。

   1. 系统流水号在系统中和申请单一一对应。


## 协议代扣

### 协议代扣申请单类型

| 申请类型 | 记录来源 | 触发方 | 来源：网商接口 | 核心参数 |
|-|-|-|-|-|
| 签约 | 商户在网商云资金小程序发起签约，网商通过通知接口通知平台 | 商户 | `授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>` | MerchantId,  <br/>ArrangementStatus=VALID, `当前合约状态：已生效VALID `  <br/>ArrangementNo, 合约号，商户签约完成后，网商通过 `授权/解约通知接口` 的 `ArrangementNo` 字段返回  <br/>ArrangementType=SUB_ACCOUNT_WITHHOLD，`合约类型：协议代扣` |
| 解约 | 商户在网商云资金小程序发起解约，网商通过通知接口通知平台 | 商户 | `授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>` | MerchantId,   <br/>ArrangementStatus=INVALID_TO_BE_CONFIRM, `当前合约状态：解约中待平台确认`  <br/>ArrangementNo |
| 解约审核 | 平台调用解约申请审核接口对商户解约申请进行审核 | 平台 | `解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>` | MerchantId,   <br/>AuditResult(AGREE/REJECT), 审核意见  <br/>ArrangementNo |

### 协议代扣申请单状态

1. 申请单状态来源：

   1. 签约、解约：`授权/解约通知<``ant.mybank.merchantprod.merchant.arrangement.info``.notify>`，字段`ArrangementStatus`。
   2. 解约审核单：解约申请审核接口（平台主动调用）`解约申请审核<ant.mybank.merchantprod.merchant.arrangement.audit>`，字段 `AuditResult`（平台传入）。
2. 申请单状态

   | 状态名称 | 状态值 | 状态类型 | 说明 |
   |-|-|-|-|
   | 已完成 | COMPLETED | 终态 | 申请单处理完成 |
   | 异常 | ERROR | 终态 | 预留状态  <br/>系统或服务异常导致处理失败，需人工介入 |

### 协议代扣合约状态

<callout emoji="❗">
1. 协议代扣合约状态来源

   1. 授权/解约成功通知接口<ant.mybank.merchantprod.merchant.arrangement.info.notify>
   2. 协议代扣授权状态查询接口<ant.mybank.merchantprod.merchant.arrangement.info.query>
</callout>

1. 合约状态来源

   <table><colgroup><col/><col/><col/><col/><col/></colgroup><thead><tr><th>查询方式</th><th>接口</th><th>状态字段</th><th>状态值</th><th>使用场景</th></tr></thead><tbody><tr><td>主动查询</td><td>1.3 协议代扣授权状态查询接口<br/><code>&lt;</code><code>ant.mybank.merchan tprod.merchant.arrangement.info</code><code>.query&gt;</code></td><td>合约状态<code>Status</code></td><td>1=NOT_EXIST（不存在）<br/>2=UN_VALID（已申请未生效）<br/>3=VALID（已生效）<br/>4=INVALID_TO_BE_CONFIRM（解约中待平台确认）</td><td><ol><li seq="1">按商户主动查询合约状态</li><li>收到网商通知后再次查询以确认合约状态</li></ol></td></tr><tr><td>主动触发</td><td>1.2解约申请审核确认接口<br/><code>&lt;ant.mybank.merchantprod.merchant.arrangement.audit&gt;</code></td><td>审核结果<code>AuditResult</code></td><td>AGREE -同意 → 1=NOT_EXIST（不存在）<br/>REJECT-拒绝→ 3=VALID（已生效）</td><td><ol><li seq="1">平台审核确认商户的解约申请</li></ol></td></tr><tr><td>被动通知</td><td>1.1授权/解约成功通知接口<code>&lt;</code><code>ant.mybank.merchantprod.merchant.arrangement.info</code><code>.notify&gt;</code></td><td>当前合约状态<code>ArrangementStatus</code></td><td>VALID（已生效）<br/>INVALID_TO_BE_CONFIRM（解约中待平台确认）</td><td><ol><li seq="1">商户签约后网商通知平台</li><li>商户申请解约时网商通知平台</li></ol></td></tr></tbody></table>
2. 合约状态说明与接口字段映射

   | 状态名称 | 1.3 协议代扣授权状态查询接口  <br/>状态值（`Status`） | 1.2解约申请审核确认接口  <br/>状态值（`AuditResult`） | 1.1 授权/解约成功通知接口  <br/>状态值（`ArrangementStatus`） | 状态类型 | 说明 |
   |-|-|-|-|-|-|
   | 不存在 | 1=NOT_EXIST（不存在） | AGREE -同意 |  | 终态 | 无该合约 |
   | 已申请未生效 | 2=UN_VALID（已申请未生效） |  |  | 中间态 | 商户已签约，待网商生效 |
   | 已生效 | 3=VALID（已生效） | REJECT-拒绝 | VALID（已生效） | 终态 | 合约生效，发起代扣 |
   | 解约中待平台确认 | 4=INVALID_TO_BE_CONFIRM  <br/>（解约中待平台确认） |  | INVALID_TO_BE_CONFIRM  <br/>（解约中待平台确认） | 中间态 | 商户发起解约申请，等待平台审核 |
   | 已失效（INVALID） | - | - | - | 终态 | 平台同意商户的解约申请  <br/>（该状态为被系统新增状态，避免业务歧义和避免商户二次签约时产生新的合约号的问题） |

<whiteboard token="SrcSwv8VDhCrjNbloA7cgWZPnoI"></whiteboard>


## 授权代付

方案介绍：<cite doc-id="UE98d1x14oAjiNxrZSYcBLIgnRV" file-type="docx" title="加盟授权代付方案（子户→ 结算卡→ 外部银行卡/支付宝）" type="doc"></cite>

### 授权代付业务子场景

收款方支持银行卡和支付宝，五个场景最多可绑定200个授权方。

| 子场景 | 场景码 | 单笔限额 | 月度总限额 | 收方账户数上限 | 签约生效规则 |
|-|-|-|-|-|-|
| **房租** | RENT | 2.5 万 | 25 万 | 5 | 首次签约：需门店法人签约授权  <br/>信息变更：需门店法人签约确认 |
| **水电物业费** | FEE | 2 万 | 10 万 | 10 | 首次签约：需门店法人签约授权  <br/>信息变更：需门店法人签约确认 |
| **合伙人分润** | PARTNER | 10 万 | 40 万 | 40 | 首次签约：需门店法人签约授权  <br/>信息变更：需门店法人签约确认，如法人未签约则 48h 后默认生效 |
| **工资代发** | SALARY | 2 万 | 25 万 | 50 | 首次签约：需门店法人签约授权  <br/>后续变更：需门店法人签约确认，如法人未签约则 48h 后默认生效 |
| **报销代发** | CLAIM | 1 万 | 10 万 | 200 个（默认） | 首次签约：需门店法人签约授权  <br/>后续变更：需门店法人签约确认，如法人未签约则 48h 后默认生效 |

### 授权代付申请单类型

1. 授权代付申请单类型与来源

| 申请类型 | 记录来源 | 触发方 | 来源：网商接口 | 核心参数 |
|-|-|-|-|-|
| **签约** | 平台调用签约申请接口发起授权申请 | 平台 | 1.1签约申请/协议变更申请（同步）`<ant.mybank.bkcloudfunds.protocol.sign.apply>`  <br/>1.2签约申请/协议变更申请（异步）`<ant.mybank.bkcloudfunds.protocol.sign.async.apply>`  <br/>1.4查询申请单 目前状态`<ant.mybank.bkcloudfunds.protocol.sign.apply.query>` | OutBizNo,   <br/>ApplyType=CREATE, 申请类型：新增  <br/>AuthorizerInfo（授权方信息），AuthorizeeInfo（被授权方信息），AuthDetail（授权事项） |
| **修改** | 平台调用修改申请接口修改已有授权合约 | 平台 | 1.1签约申请/协议变更申请（同步）`<ant.mybank.bkcloudfunds.protocol.sign.apply>`  <br/>1.2签约申请/协议变更申请（异步）`<ant.mybank.bkcloudfunds.protocol.sign.async.apply>` | ApplyType=ADJUST, 申请类型：修改  <br/>AgreementNo（合约号，修改时必传） |
| **解约** | 商户在小程序发起解约，网商通过授权合同变更通知接口通知平台 | 商户 | 1.7授权合同变更通知`<ant.mybank.bkcloudfunds.protocol.sign.notify>` | ApplyType=INVALID, 申请类型：失效  <br/>AgreementNo, 合约号  <br/>AgreementStatus=INVALID，合约状态 |

### 授权代付申请单状态

1. 申请单状态来源

   1. 1.3. 协议签约异步申请结果通知<ant.mybank.bkcloudfunds.protocol.sign.apply.notify>
   2. 1.4. 查询申请单 目前状态<ant.mybank.bkcloudfunds.protocol.sign.apply.query>
   3. 1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>
2. 状态映射

   | 状态名称 | 1.3. 协议签约异步申请结果通知  <br/>状态值（Status） | 1.4. 查询申请单目前状态接口  <br/>状态值（AuthApplyStatus） | 1.7.授权合同变更通知  <br/>状态值（AuthApplyStatus） | 状态类型 | 说明 |
   |-|-|-|-|-|-|
   | 已申请 |  | INIT：初始状态 |  | 中间态 | 调用签约接口发起申请后的初始状态 |
   | 待商户确认 |  | WAIT_CONFIRM：待确认 |  | 中间态 | 网商返回了确认链接，等待商户确认（可申请取消） |
   | 商户已确认 |  | CONFIRMED：已确认 |  | 中间态 | 商户已确认，系统签署合约中 |
   | 申请成功 | SUCCESS-签约申请成功 | SUCCESS：成功 | SUCCESS：成功 | 终态 | 签约成功，修改成功 |
   | 申请失败 | FAIL-签约申请失败 | FAIL：失败 | FAIL：失败 | 终态 | 签约申请失败（业务校验失败，签署/修改失败） |
   | 已关闭 |  | CLOSED：关闭/取消 | CLOSED：关闭 | 终态 | 申请单被关闭（已取消） |

### 授权代付合约状态

1. 合约状态来源

   1. 1.7.授权合同变更通知<ant.mybank.bkcloudfunds.protocol.sign.notify>
2. 状态映射

   | 状态名称 | 1.7.授权合同变更通知  <br/>状态值（AgreementStatus） | 状态类型 | 说明 |
   |-|-|-|-|
   | **已生效** | VALID | 终态 | 商户确认签约，合约生效 |
   | **已失效** | INVALID | 终态 | 商户发起解约，合约失效 |
   | **已取消** | CANCELLED | 终态 | 合约已取消（正常不应该出现这个状态） |

<whiteboard token="VsdfwraYUhBRlvbZFzLckkhOn5e"></whiteboard>


## 银行卡号和手机号脱敏规则

1. 银行卡：

   1. 规则：前 4 位 + 星号占位 + 最后 4 位
   2. 示例：`6222********1234`
2. 支付宝账号

   1. 手机号：
   
      1. 规则：前 4 位 + \*\*\* + 最后 4 位
      2. 示例：`1337***1234`
   2. 邮箱：
   
      1. 规则：前缀保留前 4 位 + `***` + @域名
      2. 
      3. `abcd***``@88.com`（前缀保留前 4 位，后面 \*\*\*，如果前缀部分≤4位则全部保留）


## 对外付款

### 业务流水号

#### 批量付款业务流水号

##### 批量付款批次号

1. 格式：`{3位自增数字编号}{YYYYMMDD}`
2. 示例：00120260525，表示系统内2026年5月25日的第一个001号付款批次。
3. 解释

   1. `{3位自增编号}`：表示系统内当日提交的第x个批次，自增，顺序按付款批次在本系统中的创建顺序决定。
   2. `{YYYYMMDD}`：批次号生成时的年月日。
4. 删改规则：付款批次号一经生成不可删除，不可修改。

##### 批量付款业务流水号

<callout emoji="🎈">
映射网商字段：
1. 协议代扣：代扣业务订单号，OutTradeNo
2. 授权代付：外部订单请求流水号。OutTradeNo
</callout>

1. 批量付款
2. 格式：`{3位自增数字编号}_{批量付款批次号}`
3. 示例：001_00120260528，表示系统内2026年05月28日的001付款批次内的第一笔001号付款单。
4. 解释

   1. `{3位自增编号}`：该批次的第x个付款单，自增，顺序按付款批次提交时业务订单的创建顺序决定。
   2. `-`：连接符。
   3. `{批量付款批次号}`：该付款记录所属批次的批次号。
5. 删改规则：业务流水号一经生成不可删除，不可修改。

#### 单笔付款业务流水号

<callout emoji="🎈">
1. 单笔付款业务流水号包括协议代扣和授权代付2个场景，其流水号生成规则一致。
2. 映射网商字段：

   1. 协议代扣：代扣业务订单号`OutTradeNo`。
   2. 授权代付：外部订单请求流水号`OutTradeNo`。
</callout>

1. 单笔付款
2. 格式：`{3位自增数字编号}_{501开始的3位自增数字编号}{YYYYMMDD}`
3. 示例：001_50120260528，表示系统内2026年05月28日的第一个单笔付款001号付款单。
4. 解释

   1. `{3位自增编号}`：该日期的第x个付款单，自增，顺序按付款批次提交时业务订单的创建顺序决定。
   2. `-`：连接符。
   3. `{501开始的3位自增数字编号}`：单笔付款从501开始，当前面的`{3位自增编号}`达到{999}时，向上增加一位变更为{502}，后面以此类推。
   4. `{YYYYMMDD}`：生成流水号的年月日。
5. 删改规则：业务流水号一经生成不可删除，不可修改。
6. 退款流水号在系统中与退款单一一对应。

### 付款单状态

#### 协议代扣付款单状态

<callout emoji="🎈">
1. 包含协议代扣批量支付和单笔支付的业务订单。
2. 状态来源接口：

   1. 被动通知：2.2协议授权代扣通知结果<ant.mybank.bkcloudfunds.protocol.witHHold.result.notify>
   2. 主动查询：2.3协议授权代扣查询结果<ant.mybank.bkcloudfunds.protocol.witHHold.query>
</callout>

1. 状态说明与接口字段映射

| 状态名称 | 2.2协议授权代扣通知结果  <br/>状态值（Status） | 2.3协议授权代扣查询结果  <br/>状态值（Status） | 状态类型 | 说明 |
|-|-|-|-|-|
| **处理中** | - | DEALING | 中间态 | 网商已受理代扣请求，正在处理中 |
| **成功** | SUCCESS | SUCCESS | 终态 | 代扣执行成功，资金已划转 |
| **失败** | FAIL | FAIL | 终态 | 代扣执行失败，资金未划转 |
| **部分退款** | - | - | 终态 | 该笔协议代扣付款单的已退款金额≥0且≤付款金额 |
| **全额退款** | - | - | 终态 | 该笔协议代扣付款单的已退款金额＝付款金额 |

#### 授权代付付款单状态

<callout emoji="🎈">
1. 包含授权代付批量支付和单笔支付的业务订单。
2. 状态来源接口：

   1. 被动通知：2.2授权代付结果通知<ant.mybank.bkcloudfunds.trade.operate.result.notify>
   2. 主动查询：2.3授权代付结果查询<ant.mybank.bkcloudfunds.trade.operate.result.query>
</callout>

1. 子场景状态说明与接口字段映射

| 状态名称 | 2.2. 授权代付结果通知  <br/>状态值（Status） | 2.3.授权代付结果查询  <br/>状态值（Status） | 状态类型 | 说明 |
|-|-|-|-|-|
| **处理中** | DEALING | DEALING | 中间态 | 网商已受理代付请求，正在异步执行 |
| **成功** | SUCCESS | SUCCESS | 终态 | 代付执行成功，资金已划转 |
| **失败** | FAIL | FAIL | 终态 | 代付执行失败，资金未划转 |

### 协议代扣退款

#### 退款流水号

1. 格式：`{3位自增数字编号}_{YYYYMMDD}`
2. 示例：001_20260525，表示系统内2026年5月25日创建的第一个001号协议代扣退款单。
3. 解释

   1. `{3位自增编号}`：表示系统内当日创建的第x个退款单，自增，顺序按退款单在本系统中的创建顺序决定。
   2. `{YYYYMMDD}`：退款单生成时的年月日。
4. 删改规则：退款流水号一经生成不可删除，不可修改。

#### 协议代扣退款单状态

<callout emoji="🎈">
状态来源接口：
1. 被动通知：协议代扣退款结果通知`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.result.notify>`
2. 主动查询：协议代扣退款结果查询`<ant.mybank.bkcloudfunds.protocol.witHHold.refund.query>`
</callout>

1. 状态说明与接口字段映射

   | 状态名称 | 退款结果通知  <br/>状态值（Status） | 退款结果查询  <br/>状态值（Status） | 状态类型 | 说明 | 对「最大可退金额」的影响 |
   |-|-|-|-|-|-|
   | **处理中** | - | DEALING | 中间态 | 网商已受理退款请求，正在处理中。  <br/>退款申请接口调用成功即视为「处理中」，不论网商是否已实时返回最终状态。 | 占用可退额度。退款申请提交后，在网商返回最终结果前，该笔退款金额会暂时占用可退额度，防止并发退款导致超退。 |
   | **成功** | SUCCESS | SUCCESS | 终态 | 退款执行成功，资金已退回 | 永久扣减可退额度。退款成功后，该笔退款金额从可退额度中永久扣除。 |
   | **失败** | FAIL | FAIL | 终态 | 退款执行失败，资金未退回 | 释放可退额度。退款失败后，该笔退款金额释放回可退额度，可重新发起退款。 |

### 批量付款批次状态

<callout emoji="🎈">
1. 批次状态包含了批次表格在本系统中的解析状态和该批次所有付款单在网商侧的付款状态。
</callout>

1. 状态说明

   <table><colgroup><col/><col/><col/><col/></colgroup><thead><tr><th>状态名称</th><th>状态值</th><th>状态类型</th><th>说明</th></tr></thead><tbody><tr><td>处理中</td><td>DEALING</td><td>中间态</td><td><ol><li seq="1">系统正在解析</li><li>系统解析成功，调用网商接口成功，网商正在处理付款请求，仍有未返回付款结果的付款单。</li></ol></td></tr><tr><td>成功</td><td>SUCCESS</td><td>终态</td><td><ol><li seq="1">该批次所有的付款单网商侧返回的结果全部为 SUCCESS</li></ol></td></tr><tr><td>失败</td><td>FAIL</td><td>终态</td><td><ol><li seq="1">全部解析失败</li><li>该批次所有的付款单网商侧返回的结果全部为 FAIL</li></ol></td></tr><tr><td>部分成功</td><td>PARTIAL_SUCCESS</td><td>终态</td><td><ol><li seq="1">部分解析失败，部分解析成功</li><li>解析成功的付款单，网商侧返回的付款结果部分为 SUCCESS，部分为 FAIL</li></ol></td></tr></tbody></table>

### 平台从商户后收取手续费

<callout emoji="🎈">
✅适用场景：

1. 授权代付网商手续费
🚫不适用场景：

1. 商户提现网商手续费（发起商户提现时平台通过品牌提现手续费`PlatformFee`直接收取了提现手续费）。
</callout>

1. 平台收取手续费：平台根据网商提供的品牌方费用对账文件，通过「协议代扣」接口向商户收取手续费（即提现手续费由商户承担）

   1. 接口文档：https://loan-platform.yuque.com/vo42xq/dpd6q7/hz4cxl
   2. 接口地址：`2.1 协议授权代扣接口<ant.mybank.bkcloudfunds.order.withhold.apply>`
   3. 核心入参：
   4.    PayerId 付款方商户号：提现商户的网商商户号
   5.    PayerType 付款方类型：MERCHANT
   6.    PayeeId 收款方ID：平台888开头的保证金户（结算户）
   7.    PayeeType 收款方类型：PLATFORM
