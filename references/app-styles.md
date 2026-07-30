# App 原型风格库：15 种（in-screen HTML 原生优先）

> **2026-07 新增**。专治「App 原型多样性差」的结构性病根：此前 App 任务走 Fallback 三方向时，秒数轮盘错用「网页 20 种」（那是 landing page 风格，塞进 393×852 屏内只剩色块），逻辑二/三没有 App 参照锚点，唯一兜底又是单一的「衬线 display + 单 accent」品位锚点——三个方向殊途同归，必然千篇一律。
>
> 本库 15 种全部按 **in-screen 还原度** 标注（393×852 移动屏内、纯 HTML/CSS/React、无生图），并区分「温度带」——大胆款故意占多数，把模型的确定性偏差往多样推。
>
> ⚖️ **定位同 design-styles.md**：这是「没思路时翻的弹药」，不是「必须从这里选」的清单。用户给了 design system / 品牌 / 参考 App，设计就从那里长出来，别套库。

## 这个库怎么用

1. **何时启用**：任务路由命中「App / iOS 原型」且进入 Fallback 三方向时，**逻辑一（秒数轮盘）从本库 15 种取**（`秒数 % 15 + 1`），不再从 design-styles.md 网页半区取。逻辑二参照真实获奖 App、逻辑三选最适合该产品的工作室。
2. **温度配比**：三方向里至少 1 个大胆款（轮盘未抽中大胆时，逻辑三兜底选大胆）；❌ 三版不要都落在「米白+衬线+单 accent」。
3. **还原度**：≥90% 闭眼做；70-90% 个别细节降级（如实标注降级点）；<70% 默认不进轮盘池（除非用户确认有生图能力）。
4. **in-screen 落地**：App 风格的主要战场是「屏内」——壁纸级 hero 不是 App 的事。每种风格给了「首屏签名」（让用户在 1 台 iPhone 里一眼认出这是什么风格）。
5. **色彩/字体推导**：照搬 `design-styles.md` 的「色彩推导协议」三步法（采样→收敛→论证）——本库 hex 是示例锚点不是配方；字体配对先过 `references/typography.md` 用烂名单。
6. **骨架约束不变**：设备框仍用 `assets/ios_frame.jsx` / `android_frame.jsx`，交付仍是「平铺 4-6 屏 + 每台可交互」——本库只决定**屏内长什么样**，不碰架构。

---

## 大胆派（6 种）

**1. 新拟态玻璃层叠 Glassmorphism** `大胆·in-screen 还原 85%`
- 参照：iOS 16+ 锁屏小组件生态、Apple Weather / Fitness 的毛玻璃卡层、Linear mobile 概念稿
- 适配：AI 助手、健康/天气、金融 dashboard、需要「未来感系统级」气质的工具
- 视觉 DNA：深色/渐变底 + 多层 `backdrop-filter: blur(20px)` 半透明卡（rgba 白 8-15%）+ 1px 半透明高光描边（`border: 1px solid rgba(255,255,255,.18)`）+ 层间大 gap 营造 Z 轴纵深。字体 SF 系/Inter 负字距。
- 首屏签名：一张渐变氛围底 + 2-3 张错位叠放的毛玻璃卡，卡片内容半透到底色。
- 降级点：动态光照反射（随陀螺仪动的高光）→ 静态 `linear-gradient` 高光边替代。
- 字体：Inter / Geist（负字距 -0.02em）

**2. 糖果圆角游戏化 Candy-Playful（Duolingo 系）** `大胆·还原 92%`
- 参照：Duolingo（Johnson Banks）、Habitica、Forest、各类儿童教育 App
- 适配：教育、习惯养成、健康生活、面向大众/亲子的消费级 App
- 视觉 DNA：高饱和糖果色块（主色 + 2-3 个高饱和辅助色）+ 大圆角卡（radius 16-24）+ **凸起 3D 按钮**（`box-shadow: 0 4px 0 深色` + `:active translateY(4px)` 消阴影=按压感）+ 进度环/连续签到火焰/勋章位 + 圆润超粗标题。
- 首屏签名：一个凸起 3D 主按钮 + 一个进度气泡/勋章卡，配色一眼糖果。
- 降级点：吉祥物插画 → CSS 几何形 / emoji / 抽象圆角色块替代。
- 字体：Baloo 2 / Nunito（超粗圆体标题）+ Nunito Sans 正文

**3. Y2K 复古未来 Y2K Retro-Futurism** `大胆·还原 75%`
- 参照：Spotify Wrapped 年度卡、Y2K 美学复兴（金属渐变/像素/霓虹）、早期 iMac 糖果透明感
- 适配：社交、音乐、Z 世代产品、年度回顾/数据人格卡、个性表达类 App
- 视觉 DNA：高饱和撞色（品红×青×橙）或金属银灰渐变 + 膨胀感大字/数字 + 像素点缀 + 网格线/扫描线纹理 + 圆形头像框彩色描边。故意「过度设计」。
- 首屏签名：一个撞色满版卡 + 膨胀感大数字（text-shadow 多层叠立体）+ 像素 emoji 点缀。
- 降级点：真 3D 金属字 → `background-clip: text` + 多层渐变模拟；液态金属 → 静态渐变。
- 字体：Archivo Black / Anton（超粗）+ Space Grotesk

**4. 暗黑霓虹数据感 Neon-Dark Data** `大胆·还原 88%`
- 参照：特斯拉 App、Whoop / Oura 健康环、加密货币交易所（Binance/Coinbase Pro 暗色）、赛博仪表盘
- 适配：健康监测、金融交易、运动数据、AI 算力/模型监控、车载
- 视觉 DNA：近黑底 `#0A0A0F` + 1-2 个霓虹 accent（电光青 `#00E5FF` / 荧光绿 `#39FF14` / 品红）+ 发光描边（`box-shadow: 0 0 12px accent/40%`）+ 细线图表/sparkline + 等宽数字（tabular-nums）。信息高密度。
- 首屏签名：全屏黑底 + 一条霓虹 sparkline 大图 + 等宽超大实时数字。
- 降级点：实时粒子/流光 → CSS `animation` 脉冲光晕近似。
- 字体：Inter + Geist Mono / JetBrains Mono（数据）

**5. 大胆大字报 Big-Type Editorial App** `大胆·还原 90%`
- 参照：Apple Music「浏览」大字区、Airbnb 2023 改版、Kinfolk / 独立杂志 App
- 适配：内容/阅读、音乐、时尚电商、生活方式、品牌向产品
- 视觉 DNA：超大 display 标题（clamp 40-64px，衬线或超粗无衬线）占屏宽 + 极端字重对比 + 图文 1:1 分割卡 + 大量负空间 + 黑白为主 + 1 个克制点缀色。像把杂志跨页塞进手机。
- 首屏签名：一个顶天立地的超大标题（换行刻意断在不常规处）+ 下方一张内容卡。
- 降级点：真实时装大片 → 高质感 Unsplash 图或纯色块+大字替代（版式仍成立）。
- 字体：Fraunces / Playfair Display（衬线）或 Archivo Expanded / Anton（超粗无衬线）

**6. 拼贴手绘手帐感 Collage / Scrapbook** `大胆·还原 72%`
- 参照：Pinterest 拼贴板、Notion 手帐模板社区、独立日记 App（Day One 手帐风）、zine 文化
- 适配：日记/笔记、旅行记录、兴趣收藏、女性向生活方式、UGC 社区
- 视觉 DNA：米色/牛皮纸底 + 错位旋转的卡片（`transform: rotate(±2-4deg)`）+ 胶带/回形针 CSS 小件 + 手写感字体点缀 + 撕纸边（clip-path 锯齿）+ 图章式标签。刻意「不完美」。
- 首屏签名：2-3 张错位旋转的照片卡 + 一个胶带贴纸 + 手写体一句标注。
- 降级点：真实纸张纹理 → 纯色+极淡噪点（SVG feTurbulence opacity≤0.05）模拟；手写英文→Caveat/Gochi Hand，中文手写体降级为楷体/圆体。
- 字体：Caveat / Gochi Hand（手写点缀）+ Inter 正文

---

## 中性派（5 种）

**7. 新拟物软质卡片 Soft-Neumorphism（慎用·限定暖色）** `中性·还原 80%`
- 参照：2020 Dribbble 新拟物潮（修正版：提高对比度）、智能家居控制面板、冥想 App
- 适配：智能家居 IoT 控制、冥想/白噪音、极简工具（计算器/计时器）、单功能小产品
- 视觉 DNA：**暖灰/奶白同色系底与卡**（底色 `#E8ECF0` 或暖米，卡片同底色）+ 双侧阴影浮雕（`box-shadow: 6px 6px 12px 暗部, -6px -6px 12px 亮部`）+ 圆形/胶囊控件为主 + 1 个柔和 accent。**⚠️ 可读性硬底线必须守**：正文对比度 ≥4.5:1，浮雕只做控件不做文字底。
- 首屏签名：一个大圆形浮雕旋钮/开关 + 同色系胶囊按钮组。
- 降级点：真实按压物理反馈 → `:active` 内阴影反转模拟。
- 字体：Nunito / Manrope（圆润几何）

**8. Bento 便当格信息矩阵 Bento-Grid App** `中性·还原 95%`
- 参照：Apple Keynote bento 时代、小米澎湃 OS 桌面卡、各类「功能全览」dashboard
- 适配：AI 工具、健康/运动总览、智能家居总控、理财总览、多功能聚合 App
- 视觉 DNA：浅灰/奶白或近黑底 + 不等高圆角卡矩阵（2×2 / 大小混排 `grid-template-areas`）+ 每卡一个独立信息单元（大数字 / sparkline / 图标+短句 / 迷你进度环）+ 发丝描边 + 微阴影。一屏尽览全局。
- 首屏签名：一组 4-6 格不等高 bento 卡，至少 1 格是大数字、1 格是 sparkline。
- 降级点：卡内迷你实时图表 → 静态内联 SVG sparkline。
- 字体：Inter / Geist + Geist Mono（数字）

**9. 极简瑞士功能流 Swiss-Functional** `中性·还原 98%`
- 参照：Things 3、Apple 原生系统 App（设置/备忘录/日历）、Vercel/Linear 的设计克制
- 适配：效率工具、待办/笔记、系统级工具、B 端移动化、需要「隐形设计」的产品
- 视觉 DNA：纯白/系统灰底 + 黑字 + 1px 发丝分割线（`#E0E0E0`）+ 系统字栈 + 单 accent（系统蓝/品牌色）只用在可点元素 + 高密度列表 + 克制圆角（8-10）。零装饰，靠间距与对齐说话。
- 首屏签名：一个干净的导航栏 + 高密度列表流，唯一彩色是可点按钮/链接。
- 降级点：无（这是最稳的 HTML 原生路径）。
- 字体：-apple-system 栈 / Inter / IBM Plex Sans

**10. 温暖编辑出版物 Warm-Editorial App** `中性·还原 97%`
- 参照：Anthropic/Claude 暖纸感、纽约时报 / 纽约客 App、Penguin 平装书排印、Readwise Reader
- 适配：阅读/长文、播客、深度内容订阅、文化/思想类产品、电子书
- 视觉 DNA：奶油纸底 `#F5F0E8` + 近黑正文 + 赤陶橙/赭石单 accent + **衬线标题 × 无衬线正文混排** + 书籍式舒适行高（1.7）+ 节制分隔线 + 章节式排版。像把一本好杂志装进手机。
- 首屏签名：奶油底 + 一个衬线大标题 + 一段舒适行高的正文预览。
- 降级点：真实封面摄影 → 衬线大字+色块替代（版式成立）。
- 字体：Newsreader / Source Serif（衬线标题）+ Inter 正文

**11. 专业密表数据 Pro-Dense Table** `中性·还原 96%`
- 参照：彭博终端移动版、Wind/同花顺、Garmin Connect、专业记账（随手记 Pro）
- 适配：金融行情、运动数据分析、专业记账、B 端数据工具、科研监测
- 视觉 DNA：白或深底 + 高密度表格/列表（行高紧凑、tabular-nums 右对齐数字）+ 红涨绿跌/状态色体系 + 迷你趋势箭头 + 分组 sticky 表头 + 等宽数字。信息密度即专业感。
- 首屏签名：一屏高密度数据表（≥8 行）+ sticky 分组头 + 右对齐等宽数字列。
- 降级点：实时行情流 → 静态合理数据 + 1-2 个 CSS 脉冲点表示「Live」。
- 字体：Inter + Geist Mono / IBM Plex Mono（数字列）

---

## 安静派（4 种）

**12. 留白画廊策展 Gallery-Minimal** `安静·还原 85%`
- 参照：Artsy's art App、VSCO、Apple Photos 的「内容至上」、高端电商（SSENSE）
- 适配：摄影/艺术、作品集、高端时尚电商、展览/博物馆、设计作品展示
- 视觉 DNA：纯黑或纯白大留白底 + 内容图本身提供全部色彩 + 极细小字 metadata（EXIF 式）+ 单列居中大图 + UI 退隐（导航用极淡灰）。克制到「界面消失」。
- 首屏签名：一张占屏 70% 的大图 + 下方一行极细灰小字 caption。
- 降级点：真实高质摄影作品 → 策展感 Unsplash 图（必须内容必需，过真图诚实性测试）。
- 字体：Inter 细字重（300）/ Cormorant（衬线奢侈感）

**13. 日式空寂和纸感 Wabi-Sabi / Kenya-Hara** `安静·还原 78%`
- 参照：原研哉「白」、MUJI App、无印良品/茑屋书店数字物料、东方美学冥想 App
- 适配：冥想/茶/香道、东方生活方式、极简手帐、高端民宿/餐饮、东方美学品牌
- 视觉 DNA：和纸白/米灰底（`#FAF8F4`）+ 大量「间」（留白）+ 极细发丝竖线/小方块点缀 + 竖排文字位（可选）+ 1 个侘寂 accent（苔绿/柿涩/蓝染）+ 内容极少而精。气质>信息。
- 首屏签名：大片留白 + 一个竖排标题（`writing-mode: vertical-rl`）+ 一个小 accent 方块。
- 降级点：真实和纸纹理 → 纯色+极淡噪点；日文/中文书法字 → 衬线细字重替代。
- 字体：Noto Serif SC / Cormorant（衬线细）+ Inter 细正文

**14. 经典 iOS 原生 Classic-iOS Native** `安静·还原 99%`
- 参照：Apple HIG 官方组件（设置/健康/快捷指令原生感）、SF Symbols 语言
- 适配：需要「像系统原生」可信感的工具、B 端、面向大众无风格门槛的产品、适老化
- 视觉 DNA：系统分组列表（inset-grouped 圆角组卡）+ 系统蓝 `#007AFF` 可点色 + SF 系字 + 标准导航栏（大标题滚动收缩）+ 标准开关/分段控件/滑动条。零个性即个性。
- 首屏签名：标准大标题导航 + inset-grouped 分组圆角列表 + 系统开关。
- 降级点：SF Symbols → 内联 SVG stroke 图标近似。
- 字体：-apple-system 栈

**15. 终端极客等宽 Terminal-Mono** `安静·还原 90%`
- 参照：Terminal.app、各类 SSH/监控工具（Termius）、开发者工具移动版、Hacker News 客户端
- 适配：开发者工具、服务器监控、日志查看、极客向效率、CLI 产品移动端
- 视觉 DNA：炭黑底 `#0B0D14` + 等宽字为主角 + 终端绿/琥珀/青单色输出 + 命令行提示符（`$`/`>`）+ ASCII 分隔线 + 无圆角或小圆角 + 发光光标块。像把终端揣进口袋。
- 首屏签名：一块等宽字终端输出流 + 底部一个命令输入行 + 闪烁光标块。
- 降级点：真实打字机效果 → CSS `steps()` 光标闪烁，输出流静态。
- 字体：Geist Mono / JetBrains Mono / IBM Plex Mono

---

## 三方向配比速查（Fallback Phase 4 在 App 场景的落法）

| 逻辑 | 在 App 场景做什么 |
|------|------------------|
| 🎲 秒数轮盘 | `秒数 % 15 + 1` 从本库取号（还原度 ≥70% 可入池，70-90% 须标注降级点；<70% 不进池） |
| 🏆 现实参照 | 选 1 个获奖真实 App（Apple Design Award / Material Design Awards）WebSearch 核实设计语言后迁移 |
| 🧠 最佳设计师 | 选最适合该产品的移动设计工作室（如 Fantasy / Ueno / Ramotion / 该品类标杆团队），至少 1 个大胆款兜底 |

> 三版仍须遵守：布局骨架互异（不许共用屏结构只换色）、可读性硬底线（正文≥14px/标签≥12px/对比度≥4.5:1）、真图用 Phase 3.5 取的共用素材。

---

**版本**：v1.0（2026-07 新增，补 App 原型风格多样性短板）| **下次 review**：2027-01（每半年 review 参照案例是否仍有代表性）
**适用**：App / iOS / Android 原型任务的 Fallback 三方向 + 无 design context 时的兜底弹药
