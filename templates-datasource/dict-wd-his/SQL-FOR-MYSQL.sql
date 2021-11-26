
CREATE TABLE BASE_AREA_ADDR
(
    ID          INT          NOT NULL COMMENT '编码',
    ZID         VARCHAR(20)   NOT NULL COMMENT '区域编码',
    PARENTZID   VARCHAR(20)       NULL COMMENT '上级编码',
    FULLNAME    VARCHAR(200)      NULL COMMENT '全称',
    PROVINCE    VARCHAR(200)      NULL COMMENT '省级',
    CITY        VARCHAR(200)      NULL COMMENT '地级',
    DISTRICT    VARCHAR(200)      NULL COMMENT '县级',
    SHORTNAME   VARCHAR(200)      NULL COMMENT '简称',
    AREACODE    VARCHAR(50)       NULL COMMENT '行政区划代码',
    CITYCODE    VARCHAR(50)       NULL COMMENT '区号',
    POSTCODE    VARCHAR(50)       NULL COMMENT '邮编',
    PINYINCODE  VARCHAR(200)      NULL COMMENT '拼音',
    SHORTPINYIN VARCHAR(200)      NULL COMMENT '简拼',
    LNG         VARCHAR(50)       NULL COMMENT '经度',
    LAT         VARCHAR(50)       NULL COMMENT '纬度',
    LEVELCODE   VARCHAR(50)       NULL COMMENT '等级代码',
    LEVELNAME   VARCHAR(50)       NULL COMMENT '等级',
    FULLPATH    VARCHAR(500)      NULL COMMENT '全称',
    EXTRA1      VARCHAR(500)      NULL COMMENT '备用字段1',
    EXTRA2      VARCHAR(500)      NULL COMMENT '备用字段2',
    EXTRA3      VARCHAR(500)      NULL COMMENT '备用字段3'
)
COMMENT '地区地址信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTDEPTPROPERTY
(
    DEPTCODE VARCHAR(20)  PRIMARY KEY,
    PNAME    VARCHAR(30)  ,
    SERVICER INT            NULL,
    IFUSE    INT        NOT NULL,
    CHOSCODE VARCHAR(20)
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTGYTJ
(
    ITEMCODE VARCHAR(4)              PRIMARY KEY COMMENT '途径编码',
    ITEMNAME VARCHAR(50)             NOT NULL COMMENT '途径名称',
    PYCODE   VARCHAR(10)                 NULL COMMENT '拼音码',
    WBCODE   VARCHAR(10)                 NULL COMMENT '五笔码',
    MZZYFLAG INT DEFAULT 2         NOT NULL COMMENT '使用场合',
    CHOSCODE VARCHAR(20)             COMMENT '医疗机构编码',
    IFUSE    INT DEFAULT 1         NOT NULL COMMENT '是否使用',
    UNIT     INT DEFAULT 1         COMMENT '(取值范围1---6)1-服药单；2-输液单;3-治疗单;4-执行单;5-皮试单',
    IFPS     INT DEFAULT 0         NOT NULL COMMENT '是否皮试途径',
    IFPQ     INT DEFAULT 0         NOT NULL COMMENT '是否瓶签',
    ZYDJ     VARCHAR(2) DEFAULT '1'  COMMENT '住院打印单据(取值范围1---6)',
    GYTYPE   INT                       NULL COMMENT '给药类型 1 中药 0 西药、中成药',
    ORDERID  VARCHAR(4)                  NULL COMMENT '排序'
)
COMMENT '给药途径表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTMZVIS
(
    CODE         VARCHAR(3)        PRIMARY KEY COMMENT '编码',
    NAME         VARCHAR(50)       NOT NULL COMMENT '诊室名称',
    PYCODE       VARCHAR(10)           NULL COMMENT '拼音码',
    WBCODE       VARCHAR(10)           NULL COMMENT '五笔码',
    DEPTID       INT             NOT NULL COMMENT '所属门诊科室编码(对应DictTotalDept里的DeptCode字段)',
    IFUSE        INT DEFAULT 1   NOT NULL COMMENT '是否使用',
    CHOSCODE     VARCHAR(20)       COMMENT '医疗机构编码',
    ISUSECALL    INT DEFAULT 0   COMMENT '是否使用叫号',
    CALLSCREENIP VARCHAR(20)           NULL COMMENT '叫号屏IP',
    LEFTMAC      VARCHAR(20)           NULL COMMENT '双医生双屏幕时，左屏幕电脑mac',
    RIGHTMAC     VARCHAR(20)           NULL COMMENT '双医生双屏幕时，右屏幕电脑mac',
    TYPE         INT DEFAULT 0   COMMENT '诊室类型对应字典表ID580'
)
COMMENT '门诊叫号屏' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTPROPERTY
(
    PCODE     CHAR(2)        NOT NULL,
    PNAME     VARCHAR(30)       NULL,
    INPUTCODE VARCHAR(15)       NULL,
    SERVICER  INT             NULL,
    COMMENTS  VARCHAR(400)      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTYZFREQUENCE
(
    ITEMCODE    VARCHAR(2)        PRIMARY KEY COMMENT '频率编码',
    ITEMNAME    VARCHAR(50)       NOT NULL COMMENT '频率名称',
    JCCODE      VARCHAR(20)           NULL COMMENT '简称',
    PYCODE      VARCHAR(10)           NULL COMMENT '拼音码',
    WBCODE      VARCHAR(10)           NULL COMMENT '五笔码',
    MZZYFLAG    INT DEFAULT 2   NOT NULL COMMENT '使用场合',
    CHOSCODE    VARCHAR(20)       COMMENT '医疗机构编码',
    IFUSE       INT DEFAULT 1   NOT NULL COMMENT '是否使用',
    PLTIMES     INT DEFAULT 0   NOT NULL COMMENT '执行次数(为0，表示不自动计费)',
    PLSPACE     INT DEFAULT 0   NOT NULL COMMENT '间隔数量(为0，表示不自动计费)',
    SPACEUNIT   VARCHAR(10)           NULL COMMENT '间隔单位(为空，表示不自动计费)',
    PERFORMDATE VARCHAR(60)           NULL COMMENT '默认执行时间'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICTYZKIND
(
    ITEMCODE VARCHAR(2)        PRIMARY KEY COMMENT '类别编码',
    ITEMNAME VARCHAR(50)       NOT NULL COMMENT '类别名称',
    PYCODE   VARCHAR(10)           NULL COMMENT '拼音码',
    WBCODE   VARCHAR(10)           NULL COMMENT '五笔码',
    IFLONG   INT DEFAULT 2   NOT NULL COMMENT '长临嘱',
    MZZYFLAG INT DEFAULT 2   NOT NULL COMMENT '使用场合',
    CHOSCODE VARCHAR(20)       COMMENT '医疗机构编码',
    IFUSE    INT DEFAULT 1   NOT NULL COMMENT '是否使用',
    IFZT     INT DEFAULT 0   NOT NULL COMMENT '是否嘱托'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_GROUP_BIND_MATERIAL
(
    HOSPITAL_CODE VARCHAR(30)           PRIMARY KEY COMMENT '机构编码',
    GROUP_ID      INT                  COMMENT '组套编码',
    MATERIAL_ID   VARCHAR(30)           COMMENT '材料编码',
    COUNT         INT                  NOT NULL COMMENT '材料数量',
    CREATE_DATE   DATE  COMMENT '创建时间'
)
COMMENT '组套项目绑定材料' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_HOS_MENU_SETTING
(
    HOSPITAL_CODE VARCHAR(20)           PRIMARY KEY COMMENT '机构编码',
    ID            INT                  COMMENT '编码',
    PID           INT                  NOT NULL COMMENT '上机编码',
    NAME          VARCHAR(200)          NOT NULL COMMENT '菜单名称',
    ICON          VARCHAR(200)             NULL COMMENT '图标',
    `RIGHT`         INT                  NOT NULL COMMENT '菜单访问权限',
    CREATE_DATE   DATE              COMMENT '创建时间',
    ORDER_NO      INT                  NOT NULL COMMENT '排序',
    IS_SHOW       INT                  NOT NULL COMMENT '是否显示',
    IS_ONLY_ONE   INT                  NOT NULL COMMENT '是否单界面',
    IS_NODE       INT                  NOT NULL COMMENT '是否节点',
    MENU_ID       INT                      NULL COMMENT '菜单id'
)
COMMENT '机构菜单配置' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_ICD_TO_YIBAO
(
    ICD_CODE  VARCHAR(100)      NOT NULL COMMENT '国标码',
    ICD_NAME  VARCHAR(200)      NOT NULL COMMENT '国标码名称',
    DIAG_CODE VARCHAR(100)      NOT NULL COMMENT '医保诊断编码',
    DIAG_NAME VARCHAR(200)      NOT NULL COMMENT '医保诊断名称',
    YBID      INT DEFAULT 0   NOT NULL COMMENT '医保ID'
)
COMMENT '国标码医保码对码' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_MENUS
(
    ID         INT          NOT NULL,
    NAME       VARCHAR(200)  NOT NULL,
    SYS_MODULE VARCHAR(500)  NOT NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_SURGERY_TO_YIBAO
(
    ICD_CODE     VARCHAR(100)      NOT NULL COMMENT '国标码',
    ICD_NAME     VARCHAR(200)      NOT NULL COMMENT '国标码名称',
    SURGERY_CODE VARCHAR(100)      NOT NULL COMMENT '医保诊断编码',
    SURGERY_NAME VARCHAR(200)      NOT NULL COMMENT '医保诊断名称',
    YBID         INT DEFAULT 0   NOT NULL COMMENT '医保ID'
)
COMMENT '国标码医保码对码' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_USER_UPDATE_FILE
(
    USER_ACCT     VARCHAR(20)           NULL COMMENT '用户账号',
    HAVE_DOWNLOAD INT DEFAULT 0        COMMENT '是否已下载(1:已下载 0:未下载-默认)',
    FILE_NAME     VARCHAR(200)          NULL COMMENT '文件名称',
    CREATE_DATE   DATE              COMMENT '创建时间'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE DICT_ZY_YZ_ZHUTUO
(
    ID            VARCHAR(40)           NOT NULL,
    HOSPITAL_CODE VARCHAR(20)           NOT NULL,
    DEPT_CODE     INT                  NOT NULL,
    CONTENT       VARCHAR(800)          NOT NULL,
    PY_CODE       VARCHAR(800)          NOT NULL,
    WB_CODE       VARCHAR(800)          NOT NULL,
    CREATE_DATE   DATE
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ENSUREFAREITEM
(
    YLLB                 VARCHAR(20)      NOT NULL COMMENT '医疗类别(医疗统一编码)',
    HOSPLEVEL            INT            NOT NULL COMMENT '医院等级',
    ITEMCODE             VARCHAR(200)     NOT NULL COMMENT '医保编码',
    ITEMNAME             VARCHAR(200)     NOT NULL COMMENT '医保名称',
    PYCODE               VARCHAR(100)         NULL COMMENT '拼音码',
    WBCODE               VARCHAR(100)         NULL COMMENT '五笔码',
    PRICELMT             INT DEFAULT 0  COMMENT '限价',
    SELFRATE             INT DEFAULT 0  COMMENT '自负比例',
    CHARGETYPE           VARCHAR(20)          NULL COMMENT '缴费类型(甲乙类)',
    UNIT                 VARCHAR(500)         NULL COMMENT '单位',
    SPEC                 VARCHAR(500)         NULL COMMENT '规格',
    PRODUCER             VARCHAR(200)         NULL COMMENT '厂家',
    YPCLASS              VARCHAR(40)          NULL COMMENT '类型（1 药品 2 诊疗 3 服务设施 4 医用材料）',
    PZWH                 VARCHAR(500)         NULL COMMENT '标准文号 ',
    TJCLASS              VARCHAR(4)           NULL COMMENT '特价类',
    YBTYPE               VARCHAR(20)          NULL COMMENT '医保项目类型编码',
    YBFARETYPE           VARCHAR(50)          NULL COMMENT '医保项目类型名称',
    LICNO                VARCHAR(100)         NULL COMMENT '本位码药品',
    JXCODE               VARCHAR(50)          NULL COMMENT '剂型编码',
    UPLOAD_ID            VARCHAR(36)          NULL COMMENT '上传流水号',
    JXNAME               VARCHAR(100)         NULL COMMENT '剂型名称',
    COUNTRYYBCODE        VARCHAR(200)         NULL COMMENT '国家医保目录编码',
    COUNTRYYBNAME        VARCHAR(200)         NULL COMMENT '国家医保名称',
    PROVINCEYBCODE       VARCHAR(200)         NULL COMMENT '省医保编码',
    PROVINCEYBNAME       VARCHAR(200)         NULL COMMENT '省医保名称',
    BEGINDATE            DATE                  NULL,
    ENDDATE              DATE                  NULL,
    MIN_PACKAGE_NUM      VARCHAR(50)          NULL COMMENT '最小包装数量',
    MIN_PREPARATION_UNIT VARCHAR(50)          NULL COMMENT '最小制剂单位',
    MIN_PACKAGE_UNIT     VARCHAR(50)          NULL COMMENT '最小包装单位',
    MIN_COST_UNIT        VARCHAR(50)          NULL COMMENT '最小计价单位',
    AREA_CODE            VARCHAR(10)          NULL COMMENT '区域编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GYTJBINDITEM
(
    CHOSCODE VARCHAR(50)  PRIMARY KEY,
    GYCODE   VARCHAR(4)   COMMENT '给药途径编码',
    ITEMCODE VARCHAR(50)  COMMENT '项目编码',
    ITEMNAME VARCHAR(50)      NULL COMMENT '项目名称',
    QUANTITY INT            NULL COMMENT '数量',
    ID       INT        NOT NULL,
    ITEMTYPE INT        COMMENT '0 药品 1 诊疗'
)
COMMENT '给药途径绑定项目' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_DB_ERROR_MSG
(
    ERROR_CODE   INT          PRIMARY KEY,
    SHOW_MESSAGE VARCHAR(300)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_DJLX
(
    BRLX    INT DEFAULT 0   NOT NULL COMMENT '病人类型(0 自费  其他医保)',
    CODE    VARCHAR(10)      NOT NULL COMMENT '编码',
    NAME    VARCHAR(50)      NOT NULL COMMENT '支付名称',
    TYPE    INT DEFAULT 1   NOT NULL COMMENT '1 门诊  2 住院',
    STATUS  INT DEFAULT 0   COMMENT '0 使用  1  停止',
    ORDERNO INT DEFAULT 0   COMMENT '顺序'
)
COMMENT '登记类型（门诊类型、住院类型）' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_ERROR_LOG
(
    HOSPCODE   VARCHAR(20)                NULL COMMENT '机构编码',
    ERRCODE    INT DEFAULT 0        NOT NULL COMMENT '错误码',
    REQUESTMSG BIT                        NULL COMMENT '请求信息',
    ERRORMSG   BIT                        NULL COMMENT '错误信息',
    USERID     INT                      NULL COMMENT '操作员编码',
    RECDATE    DATE              COMMENT '记录日期'
)
COMMENT '公用错误日志' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_PAYTYPE
(
    CHOSCODE VARCHAR(20) DEFAULT '0 '  PRIMARY KEY COMMENT '医疗机构代码',
    PAYCODE  VARCHAR(3)                COMMENT '支付编码',
    PAYNAME  VARCHAR(20)               NOT NULL COMMENT '支付名称',
    TYPE     INT DEFAULT 1           COMMENT '1 门诊   2 住院',
    STATUS   INT DEFAULT 0           COMMENT '使用状态   0 使用  1 停用',
    ORDERNO  INT DEFAULT 1           COMMENT '排序',
    PYCODE   VARCHAR(20)                   NULL COMMENT '拼音码',
    WBCODE   VARCHAR(20)                   NULL COMMENT '五笔码',
    ZJCODE   VARCHAR(20)                   NULL COMMENT '助记码'
)
COMMENT '支付方式' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_RESERVATION
(
    CHOSCODE              VARCHAR(20)      NOT NULL COMMENT '机构编码',
    RESERVATIONNO         VARCHAR(20)          NULL COMMENT '预约号码',
    RESERVATIONDATE       DATE              NOT NULL COMMENT '预约时间（yyyy-mm-dd)',
    TYPE                  INT            NOT NULL COMMENT '预约类型   1  门诊  2 住院  3 网上预约',
    ISFUZHEN              INT DEFAULT 0  COMMENT '是否复诊   0 否 1 是',
    DOCTORID              VARCHAR(20)          NULL COMMENT '预约医生ID',
    DOCTORNAME            VARCHAR(50)          NULL COMMENT '预约医生姓名',
    DEPTID                VARCHAR(20)          NULL COMMENT '预约科室ID',
    DEPTNAME              VARCHAR(100)         NULL COMMENT '预约科室名称',
    PATIENTNO             VARCHAR(20)          NULL COMMENT '患者流水号（预约时住院号或者门诊号流水号）',
    PATIENTNAME           VARCHAR(50)      NOT NULL COMMENT '患者姓名',
    PATIENTSEXCODE        VARCHAR(2)       NOT NULL COMMENT '患者性别',
    PATIENTAGE            VARCHAR(3)       NOT NULL COMMENT '患者年龄',
    PATIENTAGEUNIT        VARCHAR(1)           NULL COMMENT '患者年龄单位',
    PYCODE                VARCHAR(20)          NULL COMMENT '患者名称拼音码',
    WBCODE                VARCHAR(20)          NULL COMMENT '患者名称五笔码',
    CONTACTNUMBER         VARCHAR(20)          NULL COMMENT '联系电话',
    CONTACTADDRESS        VARCHAR(500)         NULL COMMENT '联系地址',
    CARDTYPE              INT            NOT NULL COMMENT '证件类型（字典表53）',
    CARDNO                VARCHAR(20)      NOT NULL COMMENT '证件号码',
    STATUS                INT                NULL COMMENT '预约结果   0  预约  1 就诊  2  取消  3 作废',
    JIUZHENDATE           DATE                  NULL COMMENT '就诊时间',
    JIUZHENNO             VARCHAR(20)          NULL COMMENT '就诊编码(新的住院号或者门诊号流水号）',
    RETURNVISITNUMBER     INT                NULL COMMENT '回访次数',
    RETURNVISITDOCTORID   VARCHAR(20)          NULL COMMENT '回访医生ID',
    RETURNVISITDOCTORNAME VARCHAR(50)          NULL COMMENT '回访人姓名',
    RETURNVISITDOCTORDATE DATE                  NULL COMMENT '回访时间',
    ICDCODE               VARCHAR(50)          NULL COMMENT '疾病编码',
    ICDNAME               VARCHAR(500)         NULL COMMENT '疾病名称',
    ID                    INT            NOT NULL COMMENT '主键'
)
COMMENT '公用预约记录表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE GY_USER_MANAGE_DEPT
(
    USERID   INT        PRIMARY KEY COMMENT '用户编码',
    DEPTID   INT        COMMENT '科室编码',
    CHOSCODE VARCHAR(20)  COMMENT '机构编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HIS_BASE_COMMON_YAOPIN
(
    YAOPINCODE      VARCHAR(50)           PRIMARY KEY COMMENT '药品编码',
    YAOPINNAME      VARCHAR(300)          NOT NULL COMMENT '药品名称',
    PINYINCODE      VARCHAR(200)              NULL COMMENT '拼音码',
    WUBICODE        VARCHAR(200)              NULL COMMENT '五笔码',
    ISUSE           INT DEFAULT 1        NOT NULL COMMENT '使用状态(1:使用 0:停用)',
    BASETYPE        INT DEFAULT 0        NOT NULL COMMENT '基本药物类别(0:非基药 1:基药)',
    REMARK          VARCHAR(500)              NULL COMMENT '备注',
    DELETEFLAG      INT DEFAULT 0        NOT NULL COMMENT '删除标记(1:删除 0:正常)',
    PIZHUNWENHAO    VARCHAR(100)              NULL COMMENT '批准文号',
    WENHAOREMARK    VARCHAR(200)              NULL COMMENT '批准文号备注',
    CHANGJIA        VARCHAR(160)              NULL COMMENT '生产厂家',
    GUIGE           VARCHAR(200)              NULL COMMENT '规格',
    JIXING          VARCHAR(50)               NULL COMMENT '剂型',
    DANJIA          INT                      NULL COMMENT '单价-乡级',
    BAOZHUANGTYPE   VARCHAR(20)               NULL COMMENT '包装类型(项目单位表：盒|袋)',
    BAOZHUANGDANWEI VARCHAR(20)               NULL COMMENT '包装单位-计价单位(项目单位表：粒|板)',
    SHULIANG        VARCHAR(20)               NULL COMMENT '包装数量(如20粒盒)',
    DANJIAXIAN      INT                      NULL COMMENT '单价-县级',
    DANJIASHI       INT                      NULL COMMENT '单价-市级',
    DANJIASHENG     INT                      NULL COMMENT '单价-省级',
    MZJIJIAXISHU    INT                      NULL COMMENT '门诊计价系数',
    MZJILIANGDANWEI VARCHAR(20)               NULL COMMENT '门诊单次计量单位',
    ZYJIJIAXISHU    INT                      NULL COMMENT '住院计价系数',
    ZYJILIANGDANWEI VARCHAR(20)               NULL COMMENT '住院单次计量单位',
    CORETYPE        VARCHAR(20)           NOT NULL COMMENT '来源(1:贵州省 99:自定义药品)',
    YAOPINTYPE      INT                      NULL COMMENT '药品类型(2字典表1:西药 2:中成药 3:中草药 4:一次性耗材 5:办公用品 6:固定资产 7:医用材料 8:疫苗)',
    FEIYONGTYPE     INT                      NULL COMMENT '费用类别(费用类别表 1:西药费 2:成药费 3:中药费 56:材料费 )',
    CAIWUTYPE       VARCHAR(5)                NULL COMMENT '财务类别(财务分类表)',
    KANGSHENGSU     INT DEFAULT 0        COMMENT '抗生素(1:是 0:否)',
    DUMA            INT DEFAULT 0        COMMENT '毒麻(1:是 0:否)',
    JINGSHEN        INT DEFAULT 0        COMMENT '精神二类(1:是 0:否)',
    YONGYAOTISHI    VARCHAR(200)              NULL COMMENT '用药提示',
    YONGYAOBEIZHU   VARCHAR(200)              NULL COMMENT '用药备注',
    TIAOMA          VARCHAR(50)               NULL COMMENT '药品条码',
    CREATEDATE      DATE              COMMENT '创建时间',
    UPDATETIME      DATE              COMMENT '修改时间',
    ISCANUSE        INT DEFAULT 0        COMMENT '是否可以使用(即完整  0:默认值 1:完整)'
)
COMMENT 'HIS基础药品表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HIS_BASE_COMMON_ZHENLIAO
(
    ZLCODE      VARCHAR(30)    NOT NULL COMMENT '项目编码',
    ZLNAME      VARCHAR(200)   NOT NULL COMMENT '项目名称',
    PINYINCODE  VARCHAR(200)       NULL COMMENT '拼音码',
    FEIYONGTYPE INT               NULL COMMENT '费用类别(费用类别表 1:西药费 2:成药费 3:中药费 56:材料费 )',
    CAIWUTYPE   VARCHAR(5)         NULL COMMENT '财务类别(财务分类表)',
    DANJIA      INT               NULL COMMENT '单价',
    WENHAO      VARCHAR(200)       NULL COMMENT '批准文号',
    BEIZHU      VARCHAR(200)      NULL COMMENT '备注',
    CORETYPE    INT           NOT NULL COMMENT '统一中心编码(字典表1353)',
    UNIT        VARCHAR(50)        NULL COMMENT '单位',
    WUBICODE    VARCHAR(200)       NULL COMMENT '五笔吗 ',
    SHENG_JIA   INT               NULL COMMENT '省价',
    SHI_JIA     INT               NULL COMMENT '市价',
    XIAN_JIA    INT               NULL COMMENT '县价',
    QU_JIA      INT               NULL COMMENT '区价'
)
COMMENT '诊疗项目' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HIS_BASE_YAOPIN_YB_RELATION
(
    YLLB       VARCHAR(20)   PRIMARY KEY COMMENT '医疗类别(医疗统一编码)',
    HISYPCODE  VARCHAR(30)   COMMENT '药品中心统一编码',
    HISYPNAME  VARCHAR(200)  NULL COMMENT '药品中心统一名称',
    CORETYPE   INT          COMMENT '药品中心编码(1:贵州 99:其他)',
    YBYPCODE   VARCHAR(30)   COMMENT '医保药品编码',
    YBYPNAME   VARCHAR(200)  NULL COMMENT '医保药品名称',
    CHARGETYPE VARCHAR(50)   NULL COMMENT '缴费类型'
)
COMMENT 'His药品与医保对码关系' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HIS_BASE_ZHENLIAO_YB_RELATION
(
    YLLB       VARCHAR(20)   PRIMARY KEY COMMENT '医疗类别(医疗统一编码)',
    HISZLCODE  VARCHAR(30)   COMMENT '诊疗中心统一编码',
    HISZLNAME  VARCHAR(200)  NULL COMMENT '诊疗中心统一名称',
    CORETYPE   INT          COMMENT '诊疗中心编码(1:贵州 99:其他)',
    YBZLCODE   VARCHAR(30)   COMMENT '医保诊疗编码',
    YBZLNAME   VARCHAR(200)  NULL COMMENT '医保诊疗名称',
    CHARGETYPE VARCHAR(50)   NULL COMMENT '缴费类型'
)
COMMENT 'His诊疗与医保对码关系' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HIS_CLIENT_LOG_UPLOAD
(
    CODE         VARCHAR(100)   PRIMARY KEY COMMENT '编码',
    HOSPITALCODE VARCHAR(20)    NULL COMMENT '机构编码',
    USERID       VARCHAR(20)    NULL COMMENT '用户编码',
    USERNAME     VARCHAR(50)    NULL COMMENT '用户名称',
    ERRORMSG     VARCHAR(500)   NULL COMMENT '错误描述',
    LOGFILEPATH  VARCHAR(100)   NULL COMMENT '日志文件路径',
    CREATETIME   DATE             NULL COMMENT '上传日志时间',
    STATUS       INT           NULL COMMENT '状态(0:初始化 1:已收到 99:已处理)',
    REPLAYID     INT           NULL COMMENT '回复编码',
    REMARK       VARCHAR(100)  NULL COMMENT '备注'
)
COMMENT '客户端日志上传记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE HOSPAUTHORIZATION
(
    ID            VARCHAR(36)             NOT NULL COMMENT '主键Id',
    HOSPNAME      VARCHAR(50)             NOT NULL COMMENT '医院名称',
    HOSPCODE      VARCHAR(30)             PRIMARY KEY COMMENT '医院编码',
    ISAUTHENABLE  INT DEFAULT 0         NOT NULL COMMENT '是否启用',
    ENDDATE       DATE                     NOT NULL COMMENT '试用有效期至',
    ISLOCKLOGIN   INT DEFAULT 0         NOT NULL COMMENT '到期是否锁定',
    LOGINAUTHCODE VARCHAR(30)             NOT NULL COMMENT '登录授权码',
    ISSHOWMESSAGE INT DEFAULT 0         NOT NULL COMMENT '是否提示',
    SHOWINTERVAL  INT DEFAULT 1         NOT NULL COMMENT '提示时间间隔',
    SHOWMESSAGE   VARCHAR(500)            NOT NULL COMMENT '提示内容',
    USERID        VARCHAR(30)             NOT NULL COMMENT '用户ID',
    USERNAME      VARCHAR(30)             NOT NULL COMMENT '用户姓名',
    UPDATEDATE    DATE               NOT NULL COMMENT '更新时间',
    BEFOREDAYS    INT DEFAULT 1         NOT NULL COMMENT '提前提醒天数'
)
COMMENT '医院授权表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE INFECTIOUS_DISEASE
(
    ID             VARCHAR(36)   NOT NULL COMMENT '主键ID',
    HOSP_CODE      FLOAT   NOT NULL COMMENT '医院编码',
    HIS_CODE       VARCHAR(20)   NOT NULL COMMENT 'HIS编码',
    NAME           VARCHAR(20)   NOT NULL COMMENT '姓名',
    SEX            VARCHAR(2)    NOT NULL COMMENT '性别',
    BIRTHDAY       DATE               NULL COMMENT '出生日期',
    AGE            INT             NULL COMMENT '岁',
    WORK           VARCHAR(100)      NULL COMMENT '工作单位（学校）',
    CONTACT        VARCHAR(20)       NULL COMMENT '联系电话',
    LOCATION       INT             NULL COMMENT '病人属于 1 本县区 2 本市其他县区 3 本省其他地市 4 外省 5 港澳台 6 外籍',
    PROVINCE       VARCHAR(30)       NULL COMMENT '省',
    CITY           VARCHAR(30)       NULL COMMENT '市',
    COUNTY         VARCHAR(30)       NULL COMMENT '县',
    TOWN           VARCHAR(30)       NULL COMMENT '乡镇',
    VILLAGE        VARCHAR(30)       NULL COMMENT '村',
    HOME_NO        VARCHAR(30)       NULL COMMENT '门牌号',
    CLASSIFY       VARCHAR(10)       NULL COMMENT '人群分类 1 幼托儿童 2 散居儿童 3 学生（大中小学） 4 教师 5 保育员及保姆 6 餐饮食品业 7 商业服务 8 医务人员 9 工人10 民工 11 农民 12 牧民 13 渔（船） 民 14 干部职员 15 离退人员 16 家务及待业 17 其他（ ） 18 不详',
    BEGIN_DATE     DATE           NOT NULL COMMENT '发病日期',
    DIAGNOSE_DATE  DATE           NOT NULL COMMENT '诊断日期',
    DEAD_DATE      DATE               NULL COMMENT '死亡日期',
    A              VARCHAR(20)       NULL COMMENT '甲类传染病 1 鼠疫 2 霍乱',
    B              VARCHAR(20)       NULL COMMENT '乙类传染病 1 传染性非典型肺炎、艾滋病（2 艾滋病病人 3 HIV）、病毒性肝炎（4 甲型 5 乙型 6丙型 7 丁肝 8 戊型 9未分型）、10 脊髓灰质炎、11 人感染高致病性禽流感、12 麻疹、13 流行性出血热、14 狂犬病、15 流行性乙型脑炎、16 登革热、炭疽（17 肺炭疽 18 皮肤炭疽 19 未分型）、痢疾（20 细菌性? 阿米巴性）、肺结核（21 利福平耐药 22 病原学阳性 23 病原学阴性 24无病原学结果）、伤寒（25 伤寒 26 副伤寒）、27 流行性脑脊髓膜炎、28 百日咳、29 白喉、30 新生儿破伤风、31 猩红热、32 布鲁氏菌病、33 淋病、梅毒（34 Ⅰ期 35 Ⅱ期 36 Ⅲ期 37 胎传 38 隐性）、39 钩端螺旋体病、40 血吸虫病、疟疾（41 间日疟 42 恶性疟 43未分型） 44 人感染H7N9禽流感',
    C              VARCHAR(20)       NULL COMMENT '丙类传染病 1 流行性感冒、2 流行性腮腺炎、3 风疹、4 急性出血性结膜炎、5 麻风病、6 流行性和地方性斑疹伤寒、7 黑热病、8 包虫病、9 丝虫病、10 除霍乱、细菌性和阿米巴性痢疾、伤寒和副伤寒以外的感染性腹泻病、11 手足口病',
    OTHER          VARCHAR(50)       NULL COMMENT '其他法定管理以及重点监测传染病',
    CORRECT_NAME   VARCHAR(50)       NULL COMMENT '订正病名',
    REASON         VARCHAR(200)      NULL COMMENT '退卡原因',
    HOSP_NAME      VARCHAR(50)       NULL COMMENT '报告单位',
    HOSP_CONTACT   VARCHAR(20)       NULL COMMENT '报告单位联系电话',
    DOCTOR_ID      VARCHAR(20)       NULL COMMENT '填卡医生ID',
    DOCTOR         VARCHAR(10)   NOT NULL COMMENT '填卡医生姓名',
    REC_DATE       DATE           NOT NULL COMMENT '填卡日期',
    DIAGNOSE_TYPE  VARCHAR(10)   NOT NULL COMMENT '病例分类*：(1)  1 疑似病例、 2 临床诊断病例、3  确诊病例、4 病原携带者  (2) 5 急性、 6 慢性（乙型肝炎*、血吸虫病*、丙肝）',
    REMARK         VARCHAR(200)      NULL COMMENT '备注',
    SOURCE         VARCHAR(2)        NULL COMMENT '来源 1 门诊 2 住院',
    CODE           VARCHAR(20)   NOT NULL COMMENT '卡片编号',
    TYPE           INT             NULL COMMENT '报卡类别： 1、 初次报告　　2、订正报告',
    PARENT         VARCHAR(20)       NULL COMMENT '患儿家长姓名',
    ID_NO          VARCHAR(20)       NULL COMMENT '证件号码',
    UPDATE_TIME    DATE               NULL COMMENT '更新时间',
    CLASSIFY_OTHER VARCHAR(20)       NULL COMMENT '人群分类其他',
    AGE_UNIT       VARCHAR(1)        NULL COMMENT '年龄单位 1 岁 2月 3天'
)
COMMENT '传染病患者信息表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE LISEQUIPMENT
(
    HOSPITAL_CODE VARCHAR(22)   NULL COMMENT '机构编码',
    ID            VARCHAR(22)   NULL COMMENT '设备编码',
    NAME          VARCHAR(200)  NULL COMMENT '设备名称'
)
COMMENT 'lis设备信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE LISITEMZHDATA
(
    TYPENAME      VARCHAR(50)  NOT NULL COMMENT '检验分组名称',
    EQUIPNAME     VARCHAR(50)  NOT NULL COMMENT '检验设备',
    COMBINATEID   VARCHAR(50)  NOT NULL COMMENT '类别代码',
    COMBINATENAME VARCHAR(50)  NOT NULL COMMENT '类别名称',
    EXTCOMCODE    VARCHAR(50)  NOT NULL COMMENT '项目编码',
    CHOSCODE      VARCHAR(50)  NOT NULL COMMENT '机构编码'
)
COMMENT 'Lis组合数据表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZBALANCECLASS
(
    CHOSCODE   VARCHAR(20)            NOT NULL,
    处方号        VARCHAR(20)            NOT NULL,
    ISREG      INT DEFAULT 0        COMMENT '0:收费  1:挂号',
    总费用        INT DEFAULT 0       ,
    挂号费        INT DEFAULT 0       ,
    诊查费        INT DEFAULT 0       ,
    检查费        INT DEFAULT 0       ,
    化验费        INT DEFAULT 0       ,
    治疗费        INT DEFAULT 0       ,
    手术费        INT DEFAULT 0       ,
    床位费        INT DEFAULT 0       ,
    护理费        INT DEFAULT 0       ,
    材料费        INT DEFAULT 0       ,
    西药费        INT DEFAULT 0       ,
    中药费        INT DEFAULT 0       ,
    成药费        INT DEFAULT 0       ,
    互助金        INT DEFAULT 0       ,
    其他费        INT DEFAULT 0       ,
    血费         INT DEFAULT 0       ,
    OPERATORID INT                      NULL,
    RECDATE    DATE             ,
    STATUS     INT DEFAULT 0        COMMENT '0:正常 1:作废',
    发票号        VARCHAR(300)               NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZCASEREC
(
    FLOWNO                 INT                   PRIMARY KEY COMMENT '就诊顺序号(对应MZJZRec里的FlowNo字段)',
    MZDIAGCODE             VARCHAR(20)                 NULL COMMENT '门诊诊断编码',
    MZDIAG                 VARCHAR(100)                NULL COMMENT '门诊诊断',
    IFCRB                  INT DEFAULT 0         NOT NULL COMMENT '是否传染病',
    IFGM                   INT DEFAULT 0         NOT NULL COMMENT '是否过敏',
    RECDATE                DATE               NOT NULL COMMENT '记录日期',
    OPERATORID             INT                   NOT NULL COMMENT '操作员ID(对应表his.用户表里UserID字段)',
    OPERATORNAME           VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    CASETHING              BIT                         NULL COMMENT '病历内容',
    CHOSCODE               VARCHAR(20)             NOT NULL COMMENT '医疗机构编码',
    DIAGYJ                 VARCHAR(200)                NULL COMMENT '主要症状',
    CLYJ                   VARCHAR(200)                NULL COMMENT '处理意见',
    CRBBG                  VARCHAR(200)                NULL COMMENT '传染病描述',
    MZQTDIAG               VARCHAR(100)                NULL COMMENT '门诊其他诊断',
    BLOODPRESSURE          VARCHAR(20)                 NULL COMMENT '血压',
    BLOODSUGAR             VARCHAR(10)                 NULL COMMENT '血糖',
    MAIBO                  INT                       NULL COMMENT '脉搏',
    XINLV                  INT                       NULL COMMENT '心率',
    HUXI                   INT                       NULL COMMENT '呼吸',
    TIWEN                  INT                       NULL COMMENT '体温',
    MZQTDIAGCODE           VARCHAR(50)                 NULL COMMENT '其他诊断编码',
    WEIGHT                 VARCHAR(10)                 NULL COMMENT '体重',
    HEIGHT                 VARCHAR(10)                 NULL COMMENT '身高',
    GXHJKJY                VARCHAR(100)                NULL COMMENT '个性化健康教育',
    MEMO                   VARCHAR(100)                NULL COMMENT '备注',
    DIAGDESCRIBE           VARCHAR(100)                NULL COMMENT '诊断描述',
    VISPURPOSE             VARCHAR(2)                  NULL COMMENT '来访目的(对应字典DICGRPID 574)',
    TIJIAN                 VARCHAR(200)               NULL COMMENT '体检',
    ZHUSU                  VARCHAR(200)               NULL COMMENT '主诉',
    BINGSHI                VARCHAR(200)               NULL COMMENT '现病史',
    XUEYANG                INT                       NULL COMMENT '血氧',
    PINGJUNYA              INT                       NULL COMMENT '平均压',
    XUEYADI                INT                       NULL COMMENT '血压低线',
    XUEYAGAO               INT                       NULL COMMENT '血压高线',
    GUOMINGSHI             VARCHAR(200)               NULL COMMENT '过敏史',
    POSTPRANDIALBLOODSUGAR VARCHAR(10)                 NULL COMMENT '餐后血糖',
    JIWANGSHI              VARCHAR(200)               NULL COMMENT '既往史'
)
COMMENT '门诊病历记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZCUREYZ
(
    SERIALNO    VARCHAR(20)  PRIMARY KEY COMMENT '自动编码',
    FLOWCODE    VARCHAR(20)  NULL COMMENT '流水号',
    YZCODE      VARCHAR(20)  NULL COMMENT '医嘱编号',
    PSRESULT    VARCHAR(2)   NULL COMMENT '皮试结果0阴性1阳性',
    PSMEDCINEPH VARCHAR(20)  NULL COMMENT '皮试药品批号',
    PSNURSEID   VARCHAR(20)  NULL COMMENT '皮试护士id',
    PSNURSENAME VARCHAR(40)  NULL COMMENT '皮试护士姓名',
    CHOSCODE    VARCHAR(20)  NULL COMMENT '机构码',
    STATUS      VARCHAR(2)   NULL COMMENT '状态1审核2执行中3已执行9已取消',
    EXETIMES    VARCHAR(2)   NULL COMMENT '计划治疗次数',
    DEPTID      VARCHAR(20)  NULL COMMENT '登记科室'
)
COMMENT '门诊治疗登记' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZJZREC
(
    FLOWNO             INT             PRIMARY KEY COMMENT '就诊顺序号(由序列SEQ_JZID生成)',
    REGISTERBICKERCODE VARCHAR(20)           NULL COMMENT '挂号流水号(对应his.门诊登记信息里的RegCode)',
    REGISTERCODE       VARCHAR(10)           NULL COMMENT '门诊号(保留)',
    CARDID             VARCHAR(20)           NULL COMMENT '就诊卡号',
    YBCARD             VARCHAR(50)           NULL COMMENT '医保卡号',
    PERSONCODE         VARCHAR(50)           NULL COMMENT '个人编码',
    SICKNAME           VARCHAR(50)       NOT NULL COMMENT '姓名',
    PYCODE             VARCHAR(10)           NULL COMMENT '拼音码',
    WBCODE             VARCHAR(10)           NULL COMMENT '五笔码',
    SEX                VARCHAR(4)        NOT NULL COMMENT '性别',
    AGE                INT                 NULL COMMENT '年龄',
    AGETYPE            VARCHAR(2)            NULL COMMENT '年龄类别',
    MEDICALTYPECODE    VARCHAR(10)           NULL COMMENT '医疗类别(对应his.字典表里Dicgrpid=6的记录)',
    IDENTIFYKIND       VARCHAR(10)           NULL COMMENT '证件类型(对应his.字典表里Dicgrpid=53的记录)',
    IDENTIFYCODE       VARCHAR(20)           NULL COMMENT '证件号码',
    ADDRESS            VARCHAR(100)          NULL COMMENT '住址',
    LINKMAN            VARCHAR(20)           NULL COMMENT '联系人',
    UNIT               VARCHAR(100)          NULL COMMENT '工作单位',
    TELPHONE           VARCHAR(20)           NULL COMMENT '联系电话',
    JZFLAG             INT DEFAULT 0   COMMENT '急诊标志',
    IFRVISIT           INT DEFAULT 0   NOT NULL COMMENT '复诊标志',
    DEPTID             INT             NOT NULL COMMENT '接诊科室(对应his.科室表里的ID)',
    VISCODE            VARCHAR(3)            NULL COMMENT '接诊诊室(对应DictMZVis里的Code)',
    CHOSCODE           VARCHAR(20)       NOT NULL COMMENT '医疗机构编码',
    FZNO               INT DEFAULT 1   COMMENT '分诊顺序号(每天从1开始)',
    FZOPERATORID       INT                 NULL COMMENT '分诊操作员ID(对应his.用户表里的UserID)',
    FZDATE             DATE                   NULL COMMENT '分诊时间',
    JZDOCTORID         INT                 NULL COMMENT '接诊医生ID(对应his.医生表里的ID)',
    JZDATE             DATE                   NULL COMMENT '接诊时间',
    STATUS             INT DEFAULT 0   NOT NULL COMMENT '就诊状态',
    APPLYDEPTCODE      INT                 NULL COMMENT '申请住院科室编码',
    APPLYDATE          TIMESTAMP(6)           NULL COMMENT '申请日期',
    FBDATE             DATE                   NULL COMMENT '发病日期',
    HZZY               VARCHAR(30)           NULL COMMENT '患者职业(对应his.字典表里Dicgrpid=1123的记录)',
    HZSOURCE           VARCHAR(1)            NULL COMMENT '患者来源 0 临床登记 1 his门诊',
    IFMARRY            VARCHAR(2)            NULL COMMENT '婚姻状况(对应his.字典表里Dicgrpid=55的记录)',
    JG                 VARCHAR(100)          NULL COMMENT '籍贯',
    BIRTHDAY           DATE                   NULL COMMENT '生日',
    YBDATA             VARCHAR(50)           NULL COMMENT '医保数据',
    JKKH               VARCHAR(20)           NULL COMMENT '健康卡号',
    CHRONIC_DISE_CODE  VARCHAR(50)          NULL COMMENT '慢特病编码',
    CHRONIC_DISE_NAME  VARCHAR(500)         NULL COMMENT '慢特病名称'
)
COMMENT '门诊就诊记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZMEDICALREC
(
    CHOSCODE     VARCHAR(50)                NULL COMMENT '医疗机构编码',
    FLOWNO       INT                      NULL COMMENT '就诊顺序号(对应MZJZRec里的FlowNo字段)',
    CASETHING    BIT                        NULL COMMENT '病历内容',
    OPERATORNAME VARCHAR(20)                NULL COMMENT '操作员姓名',
    OPERATORID   INT                      NULL COMMENT '操作员ID(对应表his.用户表里UserID字段)',
    FLAG         INT DEFAULT 0        NOT NULL COMMENT '类型对应字典组表ID575',
    RECDATE      DATE             ,
    DID          INT DEFAULT 1        COMMENT '文档ID',
    DOCNAME      VARCHAR(50)                NULL COMMENT '文档名称'
)
COMMENT '门诊病历记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZSELECTTYPE
(
    TYPENAME VARCHAR(50)    PRIMARY KEY,
    SELSQL   VARCHAR(400)  NULL,
    IFZX     INT          NULL COMMENT '1可录入',
    JZLR     VARCHAR(500)   NULL,
    CHOSCODE VARCHAR(50)    ,
    PRZLD    INT          NULL,
    FSSBCOL  VARCHAR(100)  NULL,
    JSZL     INT          NULL,
    DFV      VARCHAR(100)  NULL,
    KSTJ     VARCHAR(500)   NULL,
    SRZD     INT          NULL,
    CXPA     VARCHAR(100)  NULL
)
COMMENT '门诊开处方查询Sql' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZSICKGMREC
(
    FLOWNO             INT                   PRIMARY KEY COMMENT '就诊顺序号',
    REGISTERBICKERCODE VARCHAR(20)                 NULL COMMENT '挂号流水号(对应his.门诊登记信息里的RegCode)',
    CARDID             VARCHAR(20)                 NULL COMMENT '就诊卡号',
    YBCARD             VARCHAR(20)                 NULL COMMENT '医保卡号',
    SICKNAME           VARCHAR(50)             NOT NULL COMMENT '患者姓名',
    IDENTIFYKIND       VARCHAR(10)                 NULL COMMENT '证件类型(对应his.字典表里Dicgrpid=53的记录)',
    IDENTIFYCODE       VARCHAR(20)                 NULL COMMENT '证件号码',
    GMINFO             VARCHAR(200)            NOT NULL COMMENT '过敏记录',
    RECDATE            DATE               NOT NULL COMMENT '记录日期',
    OPERATORID         INT                   NOT NULL COMMENT '操作员ID(对应表his.用户表里UserID字段)',
    OPERATORNAME       VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    CHOSCODE           VARCHAR(20)             NOT NULL COMMENT '医疗机构编码'
)
COMMENT '过敏记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZYZFAREREC
(
    YZFAREID     INT             PRIMARY KEY,
    YZCODE       VARCHAR(20)       NOT NULL COMMENT '医嘱编码',
    CHOSCODE     VARCHAR(20)       NOT NULL,
    FARETYPE     INT             NOT NULL COMMENT '费用类型',
    FARECODE     VARCHAR(30)           NULL COMMENT '费用编码',
    FAREITEMNAME VARCHAR(200)      NOT NULL COMMENT '费用项目名称',
    FAREKIND     INT             NOT NULL COMMENT '费用类别ID',
    QUANTITY     INT             NOT NULL COMMENT '数量',
    PRICE        INT             NOT NULL COMMENT '单价',
    SPEC         VARCHAR(500)          NULL COMMENT '规格',
    JX           VARCHAR(50)           NULL COMMENT '剂型',
    UNIT         VARCHAR(50)           NULL COMMENT '单位',
    NHCODE       VARCHAR(50)           NULL COMMENT '农合编码',
    NHNAME       VARCHAR(100)          NULL COMMENT '农合名称',
    YBITEMCODE1  VARCHAR(50)           NULL COMMENT '医保项目编码1',
    YBITEMCODE2  VARCHAR(50)           NULL COMMENT '医保项目编码2',
    JLXS         INT                 NULL COMMENT '计量系数',
    DICT_JLXS    INT                 NULL COMMENT '门诊计量系数',
    MID          INT                 NULL COMMENT '药品库存ID',
    YPLJ         INT                 NULL COMMENT '药品零价',
    IFDB         INT DEFAULT 0   NOT NULL COMMENT '是否打包项目',
    DBNAMES      VARCHAR(100)          NULL COMMENT '打包名称',
    RECIPECODE   VARCHAR(20)           NULL COMMENT '处方号',
    RECIPEDATE   TIMESTAMP(6)           NULL,
    RECVDEPTID   INT                 NULL,
    FLOWCODE     VARCHAR(50)           NULL COMMENT '就诊顺序号(对应MZJZRec表里的FlowCode字段)',
    FARELY       VARCHAR(1)            NULL COMMENT '费用来源 0 项目 1 手动增加 2 给药途径绑定 3 诊疗项目绑定'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZYZMODELDETAIL
(
    MODELID          INT                   PRIMARY KEY COMMENT '医嘱模板ID(对应表MZYZModelMain里的ID字段)',
    YZCODE           VARCHAR(20)             COMMENT '医嘱编码(产生规则：3位诊室编码+6位年月日+2位小时+2位分钟+2位秒+3位毫秒)',
    FYZCODE          VARCHAR(20)             NOT NULL COMMENT '父医嘱编码(如无，则为该条医嘱的医嘱编码)',
    FLOWCODE         INT                   NOT NULL COMMENT '就诊顺序号(对应MZJZRec表里的FlowCode字段)',
    ITEMCODE         VARCHAR(2)              NOT NULL COMMENT '医嘱类别(对应DictYZKind字典里的ItemCode字段)',
    YZTHING          VARCHAR(200)                NULL COMMENT '医嘱内容',
    FARECODE         VARCHAR(30)                 NULL COMMENT '费用编码(如为药品医嘱，则该字段对应DictMedicineCatalog表里的Code字段，否则为空)',
    DBNAMES          VARCHAR(100)                NULL COMMENT '打包项目名称',
    MTOTALNUM        INT                       NULL COMMENT '药品总量(如为药品医嘱，该字段不为空)',
    MTOTALUNIT       VARCHAR(50)                 NULL COMMENT '总量单位(门诊单位)',
    MSINGLENUM       INT                       NULL COMMENT '药品单次用量(如为药品医嘱，该字段不为空)',
    MEASUREUNIT      VARCHAR(50)                 NULL COMMENT '计量单位',
    FS               INT                       NULL COMMENT '付数',
    GYCODE           VARCHAR(4)                  NULL COMMENT '给药途径序号(对应DictGYTJ里ItemCode字段)',
    YZNAME           VARCHAR(30)                 NULL COMMENT '医嘱频率名称(对应表DictYZFrequence医嘱频率字典里的ItemName字段)',
    SENDDEPTID       INT                       NULL COMMENT '开医嘱科室代码(对应his.科室表里的ID字段)',
    RECVDEPTID       INT                       NULL COMMENT '执行科室代码(对应his.科室表里的ID字段)',
    KDOCTORID        INT                   NOT NULL COMMENT '开医嘱医生ID(对应his.医生表里的ID字段)',
    KDOCTORNAME      VARCHAR(20)             NOT NULL COMMENT '开医嘱医生ID',
    KDATE            DATE               NOT NULL COMMENT '开医嘱时间',
    TDOCTORID        INT                       NULL COMMENT '作废医嘱医生ID(对应his.医生表里的ID字段)',
    TDOCTORNAME      VARCHAR(20)                 NULL COMMENT '作废医嘱医生名称',
    TDATE            DATE                         NULL COMMENT '作废医嘱时间',
    PRICETANG        INT DEFAULT 0         NOT NULL COMMENT '计价特性(0：正常计价；10：自带药；20：另开处方；40：不计价)',
    DOCTORZT         VARCHAR(200)                NULL COMMENT '医生嘱托',
    PERFORMDATE      DATE                         NULL COMMENT '执行时间',
    OPERATORID       INT                   NOT NULL COMMENT '操作员ID(对应表his.用户表里ID字段)',
    OPERATORNAME     VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    STATUS           INT                   NOT NULL COMMENT '状态(10：未发送；20：已发送；30：已收费；40：已退费；50：已作废)',
    PERFORMNUM       INT DEFAULT 0         NOT NULL COMMENT '需执行次数(在护士首次执行时，进行确认输入)',
    PERFORMSTATUS    INT DEFAULT 0         NOT NULL COMMENT '执行状态(0：未接单；1：正在执行；2：执行完毕；3：拒绝)',
    IFJJ             INT DEFAULT 0         NOT NULL COMMENT '是否加急医嘱(0：普通医嘱；1：加急医嘱)',
    IFDISPART        INT                       NULL COMMENT '撤分标志',
    DOSAGE           INT                       NULL COMMENT 'dosage',
    GDDOSAGE         INT                       NULL COMMENT 'gddosage',
    TSYF             VARCHAR(500)                NULL COMMENT '特殊用法',
    LC               INT DEFAULT 1         COMMENT '疗程',
    DJ               INT                       NULL COMMENT '单价',
    CHOSCODE         VARCHAR(20)             COMMENT '医疗机构编码',
    ITEMTYPE         INT                       NULL,
    GG               VARCHAR(500)                NULL,
    MID              INT                       NULL,
    IFMRKS           INT DEFAULT 0        ,
    YJAPPLYID        INT                       NULL,
    CHECKBODY        VARCHAR(500)                NULL,
    CHECKEQ          VARCHAR(50)                 NULL,
    YJTYPE           INT DEFAULT 0         COMMENT '医技类型(0：非医技类型；1：化验类型；2：检查类型；3：心电类型 4：手术)',
    IFPS             VARCHAR(2)                  NULL,
    DBID             VARCHAR(20)                 NULL COMMENT '打包项目ID',
    GROUPORDER       INT                       NULL COMMENT '组内顺序',
    PLCODE           VARCHAR(2)                  NULL COMMENT '医嘱频率编码(对应DictYZFrequence里的ItemCode字段)',
    ASSISTEXECDEPTID INT                       NULL COMMENT '辅助执行科室'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZYZMODELDETAILFARE
(
    YZFAREID     INT             PRIMARY KEY,
    YZCODE       VARCHAR(20)       NOT NULL,
    CHOSCODE     VARCHAR(20)       NOT NULL,
    FARETYPE     INT             NOT NULL,
    FARECODE     VARCHAR(30)           NULL,
    FAREITEMNAME VARCHAR(200)      NOT NULL,
    FAREKIND     INT             NOT NULL,
    QUANTITY     INT             NOT NULL,
    PRICE        INT             NOT NULL,
    SPEC         VARCHAR(500)          NULL,
    JX           VARCHAR(50)           NULL,
    UNIT         VARCHAR(50)           NULL,
    NHCODE       VARCHAR(50)           NULL,
    NHNAME       VARCHAR(100)          NULL,
    YBITEMCODE1  VARCHAR(50)           NULL,
    YBITEMCODE2  VARCHAR(50)           NULL,
    JLXS         INT                 NULL,
    DICT_JLXS    INT                 NULL,
    MID          INT                 NULL,
    YPLJ         INT                 NULL,
    IFDB         INT DEFAULT 0   NOT NULL,
    DBNAMES      VARCHAR(100)          NULL,
    RECIPECODE   VARCHAR(20)           NULL,
    RECIPEDATE   TIMESTAMP(6)           NULL,
    RECVDEPTID   INT                 NULL,
    MODELID      INT                 NULL,
    FLOWCODE     VARCHAR(50)           NULL COMMENT '就诊顺序号(对应MZJZRec表里的FlowCode字段)',
    FARELY       VARCHAR(1)            NULL COMMENT '费用来源 0 项目 1 手动增加 2 给药途径绑定'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZYZMODELMAIN
(
    ID           INT             PRIMARY KEY COMMENT '门诊医嘱模板ID(由序列SEQ_MZYZModelID生成)',
    NAME         VARCHAR(50)       NOT NULL COMMENT '模板名称',
    PYCODE       VARCHAR(10)           NULL COMMENT '拼音码',
    WBCODE       VARCHAR(10)           NULL COMMENT '五笔码',
    DEPTID       INT                 NULL COMMENT '所属科室(0表示全院使用)',
    DISEASENAME  VARCHAR(100)          NULL COMMENT '所属疾病名称',
    MEMO         VARCHAR(100)          NULL COMMENT '备注',
    USEPLACE     INT DEFAULT 1   NOT NULL COMMENT '使用范围(1：本人；2：本科；3：检验;4：检查；5：疫苗；6：全院)',
    OPERATORID   INT             NOT NULL COMMENT '操作员ID(对应【his.用户表】里ID字段)',
    OPERATORNAME VARCHAR(20)       NOT NULL COMMENT '操作员姓名',
    RECDATE      DATE               NOT NULL COMMENT '记录时间',
    CHOSCODE     VARCHAR(20)       NOT NULL COMMENT '医疗机构编码',
    ORDERNO      INT                 NULL COMMENT '排序号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZYZREC
(
    YZCODE           VARCHAR(20)             PRIMARY KEY COMMENT '医嘱编码(产生规则：3位诊室编码+6位年月日+2位小时+2位分钟+2位秒+3位毫秒)',
    FYZCODE          VARCHAR(20)             NOT NULL COMMENT '父医嘱编码(如无，则为该条医嘱的医嘱编码)',
    FLOWCODE         INT                   NOT NULL COMMENT '就诊顺序号(对应MZJZRec表里的FlowCode字段)',
    ITEMCODE         VARCHAR(2)              NOT NULL COMMENT '医嘱类别(对应DictYZKind字典里的ItemCode字段)',
    YZTHING          VARCHAR(200)                NULL COMMENT '医嘱内容',
    FARECODE         VARCHAR(30)                 NULL COMMENT '费用编码(如为药品医嘱，则该字段对应DictMedicineCatalog表里的Code字段，否则为空)',
    DBID             INT                       NULL COMMENT '打包项目ID',
    DBNAMES          VARCHAR(100)                NULL COMMENT '打包项目名称',
    MTOTALNUM        INT                       NULL COMMENT '药品总量(如为药品医嘱，该字段不为空)',
    MTOTALUNIT       VARCHAR(50)                 NULL COMMENT '总量单位(门诊单位)',
    MSINGLENUM       INT                       NULL COMMENT '药品单次用量(如为药品医嘱，该字段不为空)',
    MEASUREUNIT      VARCHAR(50)                 NULL COMMENT '计量单位',
    FS               INT                       NULL COMMENT '付数',
    GYCODE           VARCHAR(4)                  NULL COMMENT '给药途径序号(对应DictGYTJ里ItemCode字段)',
    YZNAME           VARCHAR(30)                 NULL COMMENT '医嘱频率名称(对应表DictYZFrequence医嘱频率字典里的ItemName字段)',
    SENDDEPTID       INT                       NULL COMMENT '开医嘱科室代码(对应his.科室表里的ID字段)',
    RECVDEPTID       INT                       NULL COMMENT '执行科室代码(对应his.科室表里的ID字段)',
    KDOCTORID        INT                   NOT NULL COMMENT '开医嘱医生ID(对应his.医生表里的ID字段)',
    KDOCTORNAME      VARCHAR(20)             NOT NULL COMMENT '开医嘱医生ID',
    KDATE            DATE               NOT NULL COMMENT '开医嘱时间',
    TDOCTORID        INT                       NULL COMMENT '作废医嘱医生ID(对应his.医生表里的ID字段)',
    TDOCTORNAME      VARCHAR(20)                 NULL COMMENT '作废医嘱医生名称',
    TDATE            DATE                         NULL COMMENT '作废医嘱时间',
    PRICETANG        INT DEFAULT 0         NOT NULL COMMENT '计价特性(0：正常计价；10：自带药；
20：另开处方；40：不计价)',
    DOCTORZT         VARCHAR(200)                NULL COMMENT '医生嘱托',
    PERFORMDATE      DATE                         NULL COMMENT '执行时间',
    OPERATORID       INT                   NOT NULL COMMENT '操作员ID(对应表his.用户表里ID字段)',
    OPERATORNAME     VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    STATUS           INT                   NOT NULL COMMENT '状态(10：未发送；20：已发送；30：已收费；40：已退费；50：已作废)',
    PERFORMNUM       INT DEFAULT 0         NOT NULL COMMENT '需执行次数(在护士首次执行时，进行确认输入)',
    PERFORMSTATUS    INT DEFAULT 0         NOT NULL COMMENT '执行状态(0：未接单；1：正在执行；2：执行完毕；3：拒绝)',
    IFJJ             INT DEFAULT 0         NOT NULL COMMENT '是否加急医嘱(0：普通医嘱；1：加急医嘱)',
    IFDISPART        INT                       NULL COMMENT '撤分标志',
    DOSAGE           INT                       NULL COMMENT '计量系数',
    GDDOSAGE         INT                       NULL COMMENT '门诊系数',
    TSYF             VARCHAR(500)                NULL COMMENT '特殊用法',
    LC               INT DEFAULT 1         COMMENT '疗程',
    DJ               INT                       NULL COMMENT '单价',
    CHOSCODE         VARCHAR(20)             COMMENT '医疗机构编码',
    GG               VARCHAR(500)                NULL COMMENT '规格',
    ITEMTYPE         INT DEFAULT 1         NOT NULL COMMENT '项目类型(1 西药  2 中成药  3 中草药  4 诊疗项目  5 材料 )',
    MID              INT                       NULL COMMENT '药房编码',
    IFMRKS           INT DEFAULT 0         COMMENT '是否默认科室',
    YJAPPLYID        INT                       NULL COMMENT '检验申请单',
    CHECKBODY        VARCHAR(500)                NULL COMMENT '检查部位（样本）',
    CHECKEQ          VARCHAR(50)                 NULL COMMENT '检查设备',
    YJTYPE           INT DEFAULT 0         NOT NULL COMMENT '医技类型(0：非医技类型；1：化验类型；2：检查类型；3：心电类型 4：手术)',
    IFPS             VARCHAR(2)                  NULL COMMENT '是否皮试',
    GROUPORDER       INT DEFAULT 1         COMMENT '组内顺序',
    PLCODE           VARCHAR(2)                  NULL COMMENT '医嘱频率编码(对应DictYZFrequence里的ItemCode字段)',
    ASSISTEXECDEPTID INT                       NULL COMMENT '辅助执行科室'
)
COMMENT '门诊医嘱表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZ_DIAG_RECORD
(
    FLOWNO           INT         NOT NULL COMMENT '门诊就诊序号',
    CHOSCODE         VARCHAR(20)   NOT NULL COMMENT '医疗机构编码',
    ICD              VARCHAR(20)       NULL COMMENT '诊断编码',
    ICD_NAME         VARCHAR(100)  NOT NULL COMMENT '诊断名称',
    ICD_COUNTRY      VARCHAR(20)       NULL COMMENT '国临版诊断编码',
    ICD_NAME_COUNTRY VARCHAR(100)      NULL COMMENT '国临版诊断名称',
    ORD              INT             NULL COMMENT '顺序',
    DIAG_TYPE        CHAR(3)            NULL COMMENT '诊断类别  1 西医主要诊断 2  西医其他诊断 3 中医主病诊断 4 中医主证诊断'
)
COMMENT '门诊就诊诊断记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE MZ_ELECTRONIC_INVOICE
(
    ID              VARCHAR(22)            NOT NULL COMMENT '编码主键',
    JS_ID           VARCHAR(20)             NOT NULL COMMENT '门诊处方表（处方号）',
    HOSPITAL_CODE   VARCHAR(20)             NOT NULL COMMENT '机构编码',
    BATCH_CODE      VARCHAR(50)                 NULL COMMENT '电子票据代码',
    NO              VARCHAR(20)                 NULL COMMENT '电子票据号码',
    CHECK_CODE      VARCHAR(20)                 NULL COMMENT '电子校验码',
    CREATE_TIME     VARCHAR(20)                 NULL COMMENT '电子票据生成时间',
    QRCODE_PATH     VARCHAR(200)               NULL COMMENT '电子票据二维码访问路径',
    PICTURE_URL     VARCHAR(200)              NULL COMMENT '电子票据页面URL',
    PICTURE_NET_URL VARCHAR(200)              NULL COMMENT '电子票据外网页面URL',
    RECORD_TIME     DATE               NOT NULL COMMENT '记录日期',
    CREATE_USER     VARCHAR(20)            NOT NULL COMMENT '创建人',
    STATUS          INT DEFAULT 1         NOT NULL COMMENT '1 正常  0 作废',
    QRCODE          BIT                         NULL COMMENT '电子票据二维码图片'
)
COMMENT '门诊电子发票' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE NEWSPROMPT
(
    ID            INT         PRIMARY KEY COMMENT '主键 (序列 SeqNewsPrompt)',
    CHOSCODE      VARCHAR(20)   NOT NULL COMMENT '医疗机构',
    SICKSERIALNO  VARCHAR(20)   NOT NULL COMMENT 'his.住院登记表  中的  住院号',
    SICKNAME      VARCHAR(20)       NULL COMMENT '病人姓名',
    SICKCODE      VARCHAR(20)       NULL COMMENT '住院号',
    FLAG          VARCHAR(2)        NULL COMMENT '0  新开   1  停止  2  疑问',
    RECORDDATE    DATE               NULL COMMENT '记录时间',
    PROMPTCONTENT VARCHAR(800)      NULL COMMENT '提示内容',
    SOURCEKEY     INT             NULL COMMENT '信息来源关键字  如果是来源住院医嘱(zyyzrec) 则为YZNo ',
    INFOSOURCE    VARCHAR(2)        NULL COMMENT '0  住院医嘱 1 门诊医嘱',
    DEPTNAME      VARCHAR(50)       NULL COMMENT '患者科室名称',
    DEPTID        VARCHAR(20)       NULL COMMENT '患者科室id',
    BADCODE       VARCHAR(50)       NULL COMMENT '床号'
)
COMMENT '消息提示表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE NURSEFAREMODEL
(
    SERIALNO  VARCHAR(20)   NOT NULL COMMENT '序号',
    ITEMNAME  VARCHAR(100)  NOT NULL COMMENT '项目名称',
    ITEMCODE  VARCHAR(20)   NOT NULL COMMENT '项目编号',
    ITEMTYPE  VARCHAR(20)       NULL COMMENT '项目类别',
    SPEC      VARCHAR(20)       NULL COMMENT '规格',
    UNIT      VARCHAR(10)       NULL COMMENT '单位',
    NUM       VARCHAR(10)       NULL COMMENT '数量',
    PRICE     VARCHAR(10)       NULL COMMENT '单价',
    RECDEPT   VARCHAR(20)       NULL COMMENT '接单科室',
    FLAG      VARCHAR(2)        NULL COMMENT '标志1诊疗0药品',
    CHOSCODE  VARCHAR(20)       NULL COMMENT '机构编码',
    USEPLACE  VARCHAR(2)        NULL COMMENT '使用范围',
    DEPTID    VARCHAR(20)       NULL COMMENT '所属科室',
    DEPTNAME  VARCHAR(20)       NULL COMMENT '科室名称',
    USERID    VARCHAR(20)       NULL COMMENT '创建人ID',
    USERNAME  VARCHAR(20)       NULL COMMENT '创建人姓名',
    MODELID   VARCHAR(20)       NULL COMMENT '模版ID',
    MODELNAME VARCHAR(50)       NULL COMMENT '模版名称',
    DISEASE   VARCHAR(100)      NULL COMMENT '所属疾病',
    UNITNAME  VARCHAR(20)       NULL COMMENT '单位名称',
    FARE      VARCHAR(10)       NULL COMMENT '金额',
    IFBABY    VARCHAR(2)        NULL COMMENT '是否婴儿'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE OTHER_FYLX_DZ
(
    CHOSCODE   VARCHAR(20)  PRIMARY KEY,
    HIS_FYLXBM INT        COMMENT 'HIS费用类型编码（费用类别表）',
    DSS_FYLXBM VARCHAR(20)  COMMENT '第三方费用类型编码',
    DSS_TYPE   INT        COMMENT '第三方类型（1  博思）',
    DSS_NAME   VARCHAR(50)  NULL COMMENT '第三方名称',
    BUI_TYPE   INT        NULL
)
COMMENT '博思发票费用类型对照' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE PRESCRIPTIONDWONLOAD
(
    HOSPITALCODE     VARCHAR(30)                                          PRIMARY KEY COMMENT '机构编码',
    PRESCRIPTIONCODE VARCHAR(50)                                          COMMENT '处方号',
    DOWNLOADDATE     VARCHAR(10)   COMMENT '同步时间'
)
COMMENT '中药处方下载到发药机数据同步表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE PRESCRIPTIONPRINTRECORE
(
    HOSPITALCODE     VARCHAR(30)           PRIMARY KEY COMMENT '机构编码',
    PRESCRIPTIONCODE VARCHAR(50)           COMMENT '处方号',
    PRINTCOUNT       INT DEFAULT 1        COMMENT '打印次数',
    PRINTTYPE        INT DEFAULT 1        COMMENT '打印类型 1-门诊自动打印处方',
    CREATEDATE       DATE              COMMENT '创建时间',
    UPDATEDATE       DATE              COMMENT '修改时间-最后一次打印时间'
)
COMMENT '处方打印记录表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE REMOTE_ASSISTANCE
(
    ID                VARCHAR(20)             NOT NULL COMMENT '申请单号，主键ID',
    HOSPCODE          VARCHAR(20)                 NULL COMMENT '医院编码',
    HSOPNAME          VARCHAR(50)             NOT NULL COMMENT '医院名称',
    USERID            VARCHAR(20)                 NULL COMMENT '申请者ID',
    USERNAME          VARCHAR(20)             NOT NULL COMMENT '申请者姓名',
    APPLYDATE         DATE               NOT NULL COMMENT '申请日期',
    QUESTION          VARCHAR(200)                NULL COMMENT '问题描述',
    DEALUSERID        VARCHAR(20)                 NULL COMMENT '处理人员ID',
    DEALUSERNAME      VARCHAR(20)                 NULL COMMENT '处理人员姓名',
    DEALDATE          DATE                         NULL COMMENT '处理时间',
    DEALRESULT        VARCHAR(200)                NULL COMMENT '处理结果说明',
    SCORE             INT                       NULL COMMENT '用户评分',
    COMMENT_CONTENT   VARCHAR(200)                NULL COMMENT '用户评论',
    COMMENTDATE       DATE                         NULL COMMENT '用户评论时间',
    STATUS            INT DEFAULT 0         NOT NULL COMMENT '状态(0 已申请 1 已接受 2 已拒绝 3 协助中 4 已处理 5 已取消)',
    SERVER_ID         VARCHAR(36)                 NULL COMMENT '服务资源id',
    DEALRESULT_STATUS INT DEFAULT 0         COMMENT '完成状态(0 未处理 1 已解决 2 未解决 3 部分解决)',
    REMOTE_PASSWORD   VARCHAR(20)                 NULL COMMENT '远程密码(预留)',
    LAST_CONN_DATE    DATE                         NULL COMMENT '最后连接时间',
    CONN_STATUS       INT DEFAULT 0         COMMENT '连接状态(0 未上线 1 在线 2 未知)'
)
COMMENT '远程协助表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE REMOTE_SERVER
(
    ID     VARCHAR(36)       NOT NULL COMMENT '资源ID',
    SERVER VARCHAR(100)      NOT NULL COMMENT '服务器地址',
    PORT   INT             NOT NULL COMMENT '服务端口',
    STATUS INT DEFAULT 0   NOT NULL COMMENT '状态(0 空闲 1 占用中 2 不可用)',
    CONFIG VARCHAR(500)          NULL COMMENT '配置',
    NAME   VARCHAR(20)           NULL COMMENT '资源名称'
)
COMMENT '远程服务表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SOFT_NAME_INFO
(
    HOSPITALKEY VARCHAR(10)   PRIMARY KEY COMMENT '医院机构key(机构编码-药品字典来源)',
    COMPANYNAME VARCHAR(100)  NULL COMMENT '公司名称',
    PRODUCTNAME VARCHAR(100)  NULL COMMENT '软件产品名称',
    COMPANYLOG  BIT            NULL COMMENT '公司LOG'
)
COMMENT '软件显示信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYSDICTHOSPITAL
(
    CHOSNAME         VARCHAR(100)           NOT NULL COMMENT '机构名称',
    CHOSCODE         VARCHAR(20)            COMMENT '机构编码',
    HOSADDRESS       VARCHAR(40)                NULL COMMENT '详细地址',
    HELPCODE         VARCHAR(50)                NULL COMMENT '助记码-拼音码',
    TELPHONE         VARCHAR(20)               NULL COMMENT '电话号码',
    REGISTDATE       DATE              COMMENT '注册时间',
    ISINEFFECT       INT DEFAULT 1        NOT NULL COMMENT '启用标志  1:启用   0:停用',
    PARENTHOSCODE    VARCHAR(20)            NOT NULL COMMENT '上级机构',
    ISWSJ            CHAR(1) DEFAULT '0 '    NOT NULL COMMENT '卫生局标志(1:卫生局 0:医疗机构）',
    ZLXJLB           INT DEFAULT 3        NOT NULL COMMENT '机构级别(0:省 1:市 2:区县 3:乡 4:村 默认为乡级)',
    AREACODE         VARCHAR(12)                NULL COMMENT '地区编码',
    CORPACCOUNT      VARCHAR(30)                NULL COMMENT '组织代码',
    ATTRIBUTEVALUE   VARCHAR(10)                NULL COMMENT '机构属性',
    JGKIND           CHAR(1)                     NULL COMMENT '机构类别: 非盈利性，盈利性及其他',
    NHJB             INT DEFAULT 2        NOT NULL COMMENT '设置农合编码的级别，默认为乡级(1:县级 2:乡级)',
    FLAG             INT DEFAULT 0        COMMENT '0:启用    1:缴费提醒标志    2:已欠费标志     3:禁用标志  (LICENCE用作提醒内容设置)',
    CHOSJC           VARCHAR(50)                NULL COMMENT '简称',
    SPLIT            INT DEFAULT (0)      COMMENT '1:分院标志  2:总院',
    CREATEDATE       DATE              COMMENT '创建时间',
    USEDATE          DATE                        NULL COMMENT '启用时间',
    FAREJB           INT                      NULL COMMENT '住院农合等级(0:市级 , 1:县级 , 2:乡镇级  ,  3:村级)',
    MZFAREJB         INT                      NULL COMMENT '门诊农合等级(0:市级 , 1:县级 , 2:乡镇级  ,  3:村级)',
    PTCODE           VARCHAR(20)                NULL COMMENT '云平台编码',
    IFLOAD           INT DEFAULT 0        COMMENT '是否上传基卫平台',
    USERID_          VARCHAR(40)                NULL COMMENT '病案上报平台对应机构编码',
    YJHOSPITALCODE   VARCHAR(50)                NULL COMMENT '作为和医技系统交换时的医疗机构编码',
    HZKIND           INT DEFAULT 0        COMMENT '会诊属性  0：无；1：接收下级单位远程会诊请求；2：接收所有远程会诊请求',
    YDBASECODE       VARCHAR(50)                NULL COMMENT '贵州省基础平台里机构对应的编码',
    YQZFCODE         VARCHAR(50)                NULL COMMENT '院区编码',
    SYSLOGO          BIT                        NULL COMMENT '机构LOGO',
    HEALTHTYPE       VARCHAR(50)                NULL COMMENT '健康平台类型',
    HISCORETYPE      VARCHAR(50)                NULL COMMENT '药品项目来源',
    ADDRCODE         VARCHAR(50)                NULL COMMENT '行政区划代码',
    ADDRFULLNAME     VARCHAR(200)              NULL COMMENT '地址全称',
    USEUSBSHIELD     INT                      NULL COMMENT '登录使用USB加密盾(1:使用 0:不使用)',
    COUNTRY_ORG_CODE VARCHAR(200)              NULL COMMENT '国家机构编码',
    COUNTRY_ORG_NAME VARCHAR(200)              NULL COMMENT '国家机构名称',
    POINT_ORG_CODE   VARCHAR(200)              NULL COMMENT '定点机构编码',
    POINT_ORG_NAME   VARCHAR(200)              NULL COMMENT '定点机构名称',
    YB_NAME          VARCHAR(200)              NULL COMMENT '医保机构名称',
    YB_OPERATOR      VARCHAR(200)              NULL COMMENT '医保经办人',
    MENU_TYPE        INT                      NULL COMMENT '菜单类型(1自定义菜单)',
    UUID             VARCHAR(40)               NULL COMMENT 'uuid',
    CREDIT_CODE      VARCHAR(40)               NULL COMMENT '组织信用代码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYSMODULE
(
    ID         VARCHAR(36)    PRIMARY KEY COMMENT '主键ID',
    PID        VARCHAR(36)        NULL COMMENT '父模块ID',
    NAME       VARCHAR(50)    NOT NULL COMMENT '模块名称',
    PATH       VARCHAR(100)       NULL COMMENT '模块路径',
    REMARK     VARCHAR(200)       NULL COMMENT '备注说明',
    REPORTCONF VARCHAR(100)      NULL COMMENT '报表编码配置'
)
COMMENT '系统模块表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYSMODULEPARAMS
(
    ID       VARCHAR(36)   PRIMARY KEY COMMENT '主键ID',
    MODULEID VARCHAR(36)   NOT NULL COMMENT '模块ID',
    CODE     INT         NOT NULL COMMENT '参数Code',
    NAME     VARCHAR(200)      NULL COMMENT '参数名称',
    REMARK   VARCHAR(200)      NULL COMMENT '备注'
)
COMMENT '系统模块参数绑定表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYSMODULEREPORT
(
    ID             VARCHAR(36)   NOT NULL COMMENT '主键ID',
    MODULEID       VARCHAR(36)   NOT NULL COMMENT '模块ID',
    NAME           VARCHAR(50)   NOT NULL COMMENT '编码名称',
    CODE           VARCHAR(30)   NOT NULL COMMENT '编码',
    REPORTCODE     VARCHAR(50)   NOT NULL COMMENT '报表编码',
    ISDEFAULT      INT             NULL COMMENT '是否默认 1 是',
    REMARK         VARCHAR(200)      NULL COMMENT '备注',
    SORTINDEX      INT             NULL COMMENT '排序序号，预留',
    REPORTCODE_OLD VARCHAR(50)       NULL
)
COMMENT '系统模块报表绑定表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYSREPORTTYPE
(
    CODE   VARCHAR(20)   NULL,
    NAME   VARCHAR(50)   NULL,
    REMARK VARCHAR(500)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_EXPORT_SCHEMA_01
(
    PROCESS_ORDER          INT          NULL,
    DUPLICATE              INT          NULL,
    DUMP_FILEID            INT          NULL,
    DUMP_POSITION          INT          NULL,
    DUMP_LENGTH            INT          NULL,
    DUMP_ORIG_LENGTH       INT          NULL,
    DUMP_ALLOCATION        INT          NULL,
    COMPLETED_ROWS         INT          NULL,
    ERROR_COUNT            INT          NULL,
    ELAPSED_TIME           INT          NULL,
    OBJECT_TYPE_PATH       VARCHAR(200)   NULL,
    OBJECT_PATH_SEQNO      INT          NULL,
    OBJECT_TYPE            VARCHAR(30)    NULL,
    IN_PROGRESS            CHAR(1)         NULL,
    OBJECT_NAME            VARCHAR(500)   NULL,
    OBJECT_LONG_NAME       VARCHAR(400)  NULL,
    OBJECT_SCHEMA          VARCHAR(30)    NULL,
    ORIGINAL_OBJECT_SCHEMA VARCHAR(30)    NULL,
    ORIGINAL_OBJECT_NAME   VARCHAR(400)  NULL,
    PARTITION_NAME         VARCHAR(30)    NULL,
    SUBPARTITION_NAME      VARCHAR(30)    NULL,
    DATAOBJ_NUM            INT          NULL,
    FLAGS                  INT          NULL,
    PROPERTY               INT          NULL,
    TRIGFLAG               INT          NULL,
    CREATION_LEVEL         INT          NULL,
    COMPLETION_TIME        DATE            NULL,
    OBJECT_TABLESPACE      VARCHAR(30)    NULL,
    SIZE_ESTIMATE          INT          NULL,
    OBJECT_ROW             INT          NULL,
    PROCESSING_STATE       CHAR(1)         NULL,
    PROCESSING_STATUS      CHAR(1)         NULL,
    BASE_PROCESS_ORDER     INT          NULL,
    BASE_OBJECT_TYPE       VARCHAR(30)    NULL,
    BASE_OBJECT_NAME       VARCHAR(30)    NULL,
    BASE_OBJECT_SCHEMA     VARCHAR(30)    NULL,
    ANCESTOR_PROCESS_ORDER INT          NULL,
    DOMAIN_PROCESS_ORDER   INT          NULL,
    PARALLELIZATION        INT          NULL,
    UNLOAD_METHOD          INT          NULL,
    LOAD_METHOD            INT          NULL,
    GRANULES               INT          NULL,
    SCN                    INT          NULL,
    GRANTOR                VARCHAR(30)    NULL,
    XML_CLOB               BIT            NULL,
    PARENT_PROCESS_ORDER   INT          NULL,
    NAME                   VARCHAR(30)    NULL,
    VALUE_T                VARCHAR(400)  NULL,
    VALUE_N                INT          NULL,
    IS_DEFAULT             INT          NULL,
    FILE_TYPE              INT          NULL,
    USER_DIRECTORY         VARCHAR(400)  NULL,
    USER_FILE_NAME         VARCHAR(400)  NULL,
    FILE_NAME              VARCHAR(400)  NULL,
    EXTEND_SIZE            INT          NULL,
    FILE_MAX_SIZE          INT          NULL,
    PROCESS_NAME           VARCHAR(30)    NULL,
    LAST_UPDATE            DATE            NULL,
    WORK_ITEM              VARCHAR(30)    NULL,
    OBJECT_NUMBER          INT          NULL,
    COMPLETED_BYTES        INT          NULL,
    TOTAL_BYTES            INT          NULL,
    METADATA_IO            INT          NULL,
    DATA_IO                INT          NULL,
    CUMULATIVE_TIME        INT          NULL,
    PACKET_NUMBER          INT          NULL,
    INSTANCE_ID            INT          NULL,
    OLD_VALUE              VARCHAR(400)  NULL,
    SEED                   INT          NULL,
    LAST_FILE              INT          NULL,
    USER_NAME              VARCHAR(30)    NULL,
    OPERATION              VARCHAR(30)    NULL,
    JOB_MODE               VARCHAR(30)    NULL,
    QUEUE_TABNUM           INT          NULL,
    CONTROL_QUEUE          VARCHAR(30)    NULL,
    STATUS_QUEUE           VARCHAR(30)    NULL,
    REMOTE_LINK            VARCHAR(400)  NULL,
    VERSION                INT          NULL,
    JOB_VERSION            VARCHAR(30)    NULL,
    DB_VERSION             VARCHAR(30)    NULL,
    TIMEZONE               VARCHAR(64)    NULL,
    STATE                  VARCHAR(30)    NULL,
    PHASE                  INT          NULL,
    GUID                   BIGINT             NULL,
    START_TIME             DATE            NULL,
    BLOCK_SIZE             INT          NULL,
    METADATA_BUFFER_SIZE   INT          NULL,
    DATA_BUFFER_SIZE       INT          NULL,
    DEGREE                 INT          NULL,
    PLATFORM               VARCHAR(101)   NULL,
    ABORT_STEP             INT          NULL,
    INSTANCE               VARCHAR(60)    NULL,
    CLUSTER_OK             INT          NULL,
    SERVICE_NAME           VARCHAR(100)   NULL,
    OBJECT_INT_OID         VARCHAR(32)    NULL
)
COMMENT 'Data Pump Master Table EXPORT                         SCHEMA                        ' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_HOSPITAL_DIP_INFO
(
    HOSPITAL_CODE VARCHAR(20)   PRIMARY KEY COMMENT '机构编码',
    HOSPITAL_TYPE VARCHAR(1)    NOT NULL COMMENT '机构类型',
    CLINET_IP     VARCHAR(20)   NOT NULL COMMENT '注册认证机构IP',
    CODE          VARCHAR(30)   NOT NULL COMMENT '机构代码',
    NAME          VARCHAR(200)  NOT NULL COMMENT '机构名称',
    LINKER        VARCHAR(100)  NOT NULL COMMENT '联系人',
    ADDRESS       VARCHAR(200)  NOT NULL COMMENT '机构地址',
    PHONE         VARCHAR(20)   NOT NULL COMMENT '联系电话',
    REG_CODE      VARCHAR(100)  NOT NULL COMMENT '注册码',
    REQ_ADDR      VARCHAR(100)      NULL COMMENT '请求地址',
    APP_ID        VARCHAR(100)      NULL COMMENT '校验码(注册成功返回)'
)
COMMENT '机构dip配置' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_HOSPITAL_TYPE
(
    ID         INT        PRIMARY KEY,
    NAME       VARCHAR(80)  NULL,
    VALUE      VARCHAR(20)  NULL,
    PARENTID   INT        NULL,
    DESCR      VARCHAR(80)  NULL,
    `RANK`       INT        NULL,
    LAYER      INT        NULL,
    SUPVALUE   VARCHAR(6)   NULL,
    PINYINCODE VARCHAR(80)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_INTERFACE_RUNCODE
(
    NAME    VARCHAR(400)  PRIMARY KEY,
    CODE    BIT            NULL,
    ORGCODE VARCHAR(20)
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_LOGIN_LOG
(
    UUID          VARCHAR(36)             NOT NULL COMMENT 'uuid',
    USER_ID       INT                   NOT NULL COMMENT '用户编码',
    USER_NAME     VARCHAR(60)             NOT NULL COMMENT '用户姓名',
    HOSPITAL_CODE VARCHAR(20)             NOT NULL COMMENT '机构编码',
    HOSPITAL_NAME VARCHAR(200)            NOT NULL COMMENT '机构名称',
    IP_ADDR       VARCHAR(60)                 NULL COMMENT 'ip地址',
    MAC_ADDR      VARCHAR(30)                 NULL COMMENT 'mac地址',
    CREATE_DATE   DATE               NOT NULL COMMENT '登陆时间',
    IS_LOGIN      INT                   NOT NULL COMMENT '是否登陆(1:登陆 0:注销)',
    OPT_INFO      VARCHAR(200)                NULL COMMENT '操作信息(运维机构登陆，格式：用户编码-用户名称-机构编码)'
)
COMMENT '系统登陆日志' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE SYS_REPORT
(
    ID         INT            PRIMARY KEY,
    REPNAME    VARCHAR(200)     NULL,
    REPSTR     BIT              NULL,
    ZZR        VARCHAR(200)     NULL,
    ZZTIME     DATE              NULL,
    CONSTR     BIT              NULL,
    ZXID       INT            NULL,
    ZZDEP      VARCHAR(100)     NULL,
    CODE       VARCHAR(100)     NULL,
    TYPE       VARCHAR(50)      NULL,
    REMARK     VARCHAR(500)     NULL,
    CONTROL    BIT              NULL,
    TREESQL    VARCHAR(500)     NULL,
    EVENTSTR   BIT              NULL,
    CONN       VARCHAR(200)     NULL,
    CID        VARCHAR(20)      NULL,
    CNAME      VARCHAR(20)      NULL,
    CPA        VARCHAR(100)    NULL,
    IFQY       INT DEFAULT 0 ,
    SCRIPT     BIT              NULL COMMENT '参数脚本',
    QUERY_CONF BIT              NULL COMMENT '查询设计配置',
    STATUS     INT            NULL COMMENT '状态(1 删除)'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_FY_AREA
(
    CODE        INT         NOT NULL COMMENT '编码',
    PARENT_CODE INT             NULL COMMENT '上级编码',
    NAME        VARCHAR(60)  NOT NULL COMMENT '名称',
    STATE       INT         NOT NULL COMMENT '状态',
    ADDR_LEVEL  INT         NOT NULL COMMENT '等级(0:省 1:市 2:区县 3:乡 4:村)'
)
COMMENT '妇幼_行政区划' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_GZ_HEALTH_CASE_RECORD
(
    HOSPITAL_CODE  VARCHAR(20)           NULL COMMENT '机构编码',
    USER_KEY       VARCHAR(20)           NULL COMMENT '机构就诊用户时间段内唯一编码(门诊-流水号 住院-住院号)',
    BUS_TYPE       VARCHAR(2)            NULL COMMENT '业务类型(1门诊 2住院)',
    HEALTH_CODE_ID VARCHAR(128)          NULL COMMENT '黔康码ID',
    CREATE_DATE    DATE              COMMENT '创建时间(业务中使用时间倒序获取用户唯一码)'
)
COMMENT '黔康码就诊记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_GZ_HEALTH_PATIENT
(
    EHEALTH_CARD_ID VARCHAR(128)  PRIMARY KEY COMMENT '黔康码ID',
    MINDEX_ID       VARCHAR(128)      NULL COMMENT '黔康码主索引ID',
    ID_TYPE         VARCHAR(2)    NOT NULL COMMENT '证件类型',
    ID_NO           VARCHAR(32)   NOT NULL COMMENT '证件号',
    USER_NAME       VARCHAR(50)   NOT NULL COMMENT '用户姓名',
    USER_SEX        VARCHAR(1)        NULL COMMENT '用户性别',
    MOBILE_PHONE    VARCHAR(32)       NULL COMMENT '手机号码',
    BIRTHDAY        VARCHAR(10)       NULL COMMENT '出生日期',
    TELEPHONE       VARCHAR(32)       NULL COMMENT '联系电话',
    ADDRESS         VARCHAR(200)      NULL COMMENT '居住地址',
    WORK_UNIT       VARCHAR(200)      NULL COMMENT '工作单位',
    CARD_TYPE       VARCHAR(2)        NULL COMMENT '卡类型（01社保卡 05黔康码）',
    CARD_NO         VARCHAR(32)       NULL COMMENT '卡号',
    NATION          VARCHAR(3)        NULL COMMENT '民族'
)
COMMENT '黔康码患者信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_IMPORT_DICT
(
    ID            VARCHAR(50)  NULL COMMENT '编码',
    HOSPITAL_CODE VARCHAR(20)  NULL COMMENT '机构编码',
    PRICE         INT         NULL COMMENT '价格',
    TYPE          INT         NULL COMMENT '类型(1:药品 2诊疗)'
)
COMMENT '导入麻江配置' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_WOMAN_CHILD_BABY
(
    UUID          VARCHAR(40)   NULL COMMENT 'UUID',
    BIRTH_UUID    VARCHAR(40)   NULL COMMENT '分娩UUID',
    BIRTH_NO      INT         NULL COMMENT '分娩序号',
    SEX           INT         NULL COMMENT '性别',
    BIRTH_DATE    DATE           NULL COMMENT '出生时间',
    WEIGHT        INT         NULL COMMENT '体重',
    LENGTH        INT         NULL COMMENT '身长',
    BIRTH_RESULT  INT         NULL COMMENT '妊娠结局',
    APGAR         INT         NULL COMMENT 'APGAR1分钟',
    REMARK        VARCHAR(400)  NULL COMMENT '备注',
    REQUEST_ERROR VARCHAR(400)  NULL COMMENT '请求异常信息',
    HEALTH_STATUS INT         NULL COMMENT '健康状况'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_WOMAN_CHILD_BABY_DEFECT
(
    UUID         VARCHAR(40)   NULL COMMENT 'UUID',
    BIRTHUUID    VARCHAR(40)   PRIMARY KEY COMMENT '分娩uuid',
    BABYUUID     VARCHAR(40)   COMMENT '新生儿id',
    WNJX         INT          NULL COMMENT '无脑畸形',
    JZL          INT          NULL COMMENT '脊柱裂',
    NPC          INT          NULL COMMENT '脑膨出',
    NJS          INT          NULL COMMENT '先天性脑积水',
    ELZ          INT          NULL COMMENT '腭裂左',
    ELZH         INT          NULL COMMENT '腭裂中',
    ELY          INT          NULL COMMENT '腭裂右',
    CLZ          INT          NULL COMMENT '唇裂左',
    CLZH         INT          NULL COMMENT '唇裂中',
    CLY          INT          NULL COMMENT '唇裂右',
    CELZ         INT          NULL COMMENT '唇裂合并腭裂左',
    CELZH        INT          NULL COMMENT '唇裂合并腭裂中',
    CELY         INT          NULL COMMENT '唇裂合并腭裂右',
    XEZ          INT          NULL COMMENT '小耳左',
    XEY          INT          NULL COMMENT '小耳右',
    ZEQTJX       INT          NULL COMMENT '外耳其他畸形左',
    YEQTJX       INT          NULL COMMENT '外耳其他畸形右',
    SDFBXZ       INT          NULL COMMENT '食道闭锁或狭窄',
    WG           INT          NULL COMMENT '无肛',
    NDXL         INT          NULL COMMENT '尿道下裂',
    PGWF         INT          NULL COMMENT '膀胱外翻',
    MTNFZZ       INT          NULL COMMENT '马蹄内翻足左',
    MTNFZY       INT          NULL COMMENT '马蹄内翻足右',
    DSZZ         INT          NULL COMMENT '多指左',
    DSZY         INT          NULL COMMENT '多指右',
    DJZZ         INT          NULL COMMENT '多趾左',
    DJZY         INT          NULL COMMENT '多趾右',
    BSZZ         INT          NULL COMMENT '并指左',
    BSZY         INT          NULL COMMENT '并指右',
    BJZZ         INT          NULL COMMENT '并趾左',
    BJZY         INT          NULL COMMENT '并趾右',
    SZZ          INT          NULL COMMENT '上肢左',
    SZY          INT          NULL COMMENT '上肢右',
    XZZ          INT          NULL COMMENT '下肢左',
    XZY          INT          NULL COMMENT '下肢右',
    XTXGS        INT          NULL COMMENT '先天性膈疝',
    QPC          INT          NULL COMMENT '先天性膈疝',
    FL           INT          NULL COMMENT '腹裂',
    LTST         INT          NULL COMMENT '联体双胎',
    TSZHZ        INT          NULL COMMENT '唐氏综合征',
    XTXXZB       INT          NULL COMMENT '先天性心脏病',
    XTXXZBLX     VARCHAR(400)  NULL COMMENT '先天性心脏病类型',
    QTQX         INT          NULL COMMENT '其他缺陷',
    QTQXMS       VARCHAR(400)  NULL COMMENT '其他病名和描述',
    FS           INT          NULL COMMENT '发烧',
    BDGR         INT          NULL COMMENT '病毒感染',
    BDGRLX       VARCHAR(400)  NULL COMMENT '病毒感染类型',
    TNB          INT          NULL COMMENT '糖尿病',
    REQUESTERROR VARCHAR(400)  NULL COMMENT '请求妇幼平台错误信息'
)
COMMENT '新生儿缺陷' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_WOMAN_CHILD_DELIVERY
(
    UUID                 VARCHAR(40)   NOT NULL COMMENT 'UUID',
    HOSPITAL_CODE        VARCHAR(20)   PRIMARY KEY COMMENT '机构编码',
    PATIENT_CODE         VARCHAR(20)   COMMENT '住院号',
    CREATE_USER          VARCHAR(20)   NOT NULL COMMENT '登记人',
    CREATE_DATE          DATE            NOT NULL COMMENT '登记时间',
    EDIT_DATE            DATE            NOT NULL COMMENT '编辑时间',
    NAME                 VARCHAR(20)   NOT NULL COMMENT '姓名',
    BIRTHDAY             DATE            NOT NULL COMMENT '出生日期',
    NATION               VARCHAR(3)    NOT NULL COMMENT '民族',
    NATIONALITY          VARCHAR(3)    NOT NULL COMMENT '国籍',
    ID_TYPE              VARCHAR(2)        NULL COMMENT '证件类型',
    ID_NO                VARCHAR(20)   NOT NULL COMMENT '证件号码',
    TELPHONE             VARCHAR(20)   NOT NULL COMMENT '联系电话',
    HOUSEHOLD_REGISTER   VARCHAR(200)  NOT NULL COMMENT '户籍（到县）',
    HOME_ADDRESS         VARCHAR(200)  NOT NULL COMMENT '现地址（到村）',
    HUSBAND_NAME         VARCHAR(20)   NOT NULL COMMENT '丈夫姓名',
    HUSBAND_ID_TYPE      VARCHAR(3)        NULL COMMENT '丈夫证件类型',
    HUSBAND_ID_NO        VARCHAR(20)   NOT NULL COMMENT '丈夫证件号码',
    HUSBAND_TELPHONE     VARCHAR(20)   NOT NULL COMMENT '丈夫联系电话',
    HUSBAND_BIRTHDAY     DATE            NOT NULL COMMENT '丈夫出生日期',
    HUSBAND_NATION       VARCHAR(3)    NOT NULL COMMENT '丈夫民族',
    HUSBAND_NATIONALITY  VARCHAR(3)    NOT NULL COMMENT '丈夫国籍',
    RISK_FLAG            VARCHAR(1)    NOT NULL COMMENT '高危标识',
    RISK_LEVEL           VARCHAR(1)    NOT NULL COMMENT '高危级别',
    RISK_VIOLET_FLAG     VARCHAR(1)    NOT NULL COMMENT '高危紫色标识',
    PREGNANCY_COUNT      VARCHAR(2)    NOT NULL COMMENT '孕次',
    BIRTH_COUNT          VARCHAR(2)    NOT NULL COMMENT '产次',
    GESTATIONAL_WEEK     VARCHAR(2)    NOT NULL COMMENT '孕周',
    GESTATIONAL_DAY      VARCHAR(1)    NOT NULL COMMENT '孕天',
    LAST_MENSTRUATION    DATE            NOT NULL COMMENT '末次月经',
    DELIVERY_PLACE_TYPE  VARCHAR(1)    NOT NULL COMMENT '分娩地点分类',
    DELIVERY_MODE        VARCHAR(2)    NOT NULL COMMENT '分娩方式',
    DELIVERY_DATE        DATE            NOT NULL COMMENT '分娩日期',
    ANALGESIC_FLAG       VARCHAR(1)    NOT NULL COMMENT '分娩镇痛标识',
    CRITICAL_FLAG        VARCHAR(1)    NOT NULL COMMENT '危重标识',
    DELIVERY_BABY_COUNT  VARCHAR(2)    NOT NULL COMMENT '分娩胎数',
    INPATIENT_MEDICAL_NO VARCHAR(40)   NOT NULL COMMENT '住院病案号',
    MIDWIFE              VARCHAR(40)   NOT NULL COMMENT '接生人',
    REQUEST_ERROR        VARCHAR(400)      NULL COMMENT '请求省妇幼平台错误信息'
)
COMMENT '妇幼分娩记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE THIRD_YISHITONG_DIAGNOSE
(
    UUID VARCHAR(40)   NULL,
    CODE VARCHAR(40)   NULL COMMENT '编码',
    NAME VARCHAR(400)  NULL COMMENT '名称'
)
COMMENT '医事通诊断' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE T_HIS_RELUSERRIGHT
(
    USERID INT  PRIMARY KEY COMMENT '用户编码',
    ROLEID INT  COMMENT '角色编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE T_HIS_RIGHT
(
    RIGHTID    VARCHAR(20)             PRIMARY KEY COMMENT '权限编码',
    RNAME      VARCHAR(30)                 NULL COMMENT '权限名称',
    CREATEDATE DATE               NOT NULL COMMENT '创建日期',
    DESCRIPT   VARCHAR(100)                NULL COMMENT '说明',
    RIGHTKIND  VARCHAR(20)                 NULL COMMENT '权限类型',
    IFUSE      INT DEFAULT 1         COMMENT '使用标志',
    IFSHOW     INT DEFAULT 1         COMMENT '是否可以进行显示设置，对用户是否开放权限',
    PYCODE     VARCHAR(25)                 NULL COMMENT '拼音码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE T_HIS_ROLEDICT
(
    ROLEID   INT                   PRIMARY KEY,
    ROLENAME VARCHAR(50)             NULL,
    ROLEKIND INT                   NULL COMMENT '角色类型(0:通用    1:卫生局使用  2:医院使用)',
    PYCODE   VARCHAR(25)             NULL,
    IFUSE    VARCHAR(1) DEFAULT '1' ,
    USERANGE VARCHAR(20)             NULL,
    SUBRANGE VARCHAR(20)             NULL,
    MEMO     VARCHAR(200)            NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE T_HIS_ROLE_RIGHT
(
    ROLEID     INT                   PRIMARY KEY,
    RIGHTID    VARCHAR(20)             ,
    CREATEDATE DATE               NOT NULL,
    DESCRIPT   VARCHAR(100)                NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WBM
(
    NAME VARCHAR(2)   NULL,
    CODE VARCHAR(10)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CACHE_SQL
(
    SQLNAME   VARCHAR(50)      PRIMARY KEY COMMENT 'Sql名称',
    URL       VARCHAR(50)          NULL COMMENT '请求Url(如果不为空说明需要请求服务端数据填充表)',
    ISUSE     INT DEFAULT 1   NOT NULL COMMENT '是否使用(1:使用  0:停用)',
    REMAK     VARCHAR(500)         NULL COMMENT '备注',
    ISTABLE   INT             NOT NULL COMMENT '是否是表(1:是 0:否)',
    SQL0      VARCHAR(400)         NULL COMMENT '执行sql',
    SQL1      VARCHAR(400)         NULL COMMENT '执行sql',
    SQL2      VARCHAR(400)         NULL COMMENT '执行sql',
    SQL3      VARCHAR(400)         NULL COMMENT '执行sql',
    SQL4      VARCHAR(400)         NULL COMMENT '执行sql',
    SQL5      VARCHAR(400)         NULL COMMENT '执行sql',
    LOADLEVEL INT DEFAULT 1   COMMENT '加载顺序(0:常用数据加载 1:医嘱每次初始化加载 2:仅第一次初始化加载)'
)
COMMENT '客户端缓存涉及sql' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_DEPT_INFO
(
    COREDEPTCODE  VARCHAR(50)  NULL COMMENT '健康中心科室编码',
    COREDEPTNAMEE VARCHAR(50)  NULL COMMENT '健康中心科室名称',
    CORECODE      VARCHAR(50)  NULL COMMENT '健康中心编码',
    CORENAME      VARCHAR(50)  NULL COMMENT '健康中心名称',
    PYCODE        VARCHAR(50)  NULL COMMENT '拼音码',
    WBCODE        VARCHAR(50)  NULL COMMENT '五笔码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_DEPT_RELATION
(
    COREDEPTCODE VARCHAR(50)  NULL COMMENT '健康中心科室编码',
    HISDEPTCODE  VARCHAR(50)  NULL COMMENT '医院机构科室编码',
    CHOSCODE     VARCHAR(50)  NULL COMMENT '机构编码',
    ISENABLE     VARCHAR(50)  NULL COMMENT '是否启用'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_DICTIONARY
(
    TABLECODE VARCHAR(50)   NOT NULL COMMENT '目录编码',
    TABLENAME VARCHAR(255)  NOT NULL COMMENT '目录名称',
    CODE      VARCHAR(255)  NOT NULL COMMENT '编码',
    NAME      VARCHAR(255)  NOT NULL COMMENT '名称',
    NOTES     VARCHAR(255)      NULL COMMENT '备注',
    RESERVED1 VARCHAR(255)      NULL COMMENT '预留字段1',
    RESERVED2 VARCHAR(255)      NULL COMMENT '预留字段2',
    IFLAG     VARCHAR(2)        NULL COMMENT '启用标识（01：启用；02：停用）'
)
COMMENT '晶奇数据字典表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_DIC_RELATION
(
    HIS_CODE VARCHAR(20)   NOT NULL COMMENT 'HIS目录Code',
    JQ_CODE  VARCHAR(20)   NOT NULL COMMENT '晶奇目录Code',
    REMARK   VARCHAR(255)      NULL
)
COMMENT 'HIS_晶奇字典关系表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_ORG_RELATION
(
    HISORGCODE  VARCHAR(50)  NULL COMMENT '医院HIS机构编码',
    COREORGCODE VARCHAR(50)  NULL COMMENT '健康平台机构编码',
    CORECODE    VARCHAR(50)  NULL COMMENT '平台编码',
    CORENAME    VARCHAR(50)  NULL COMMENT '平台名称',
    ISENABLE    VARCHAR(50)  NULL COMMENT '是否启用',
    REMARK      VARCHAR(50)  NULL COMMENT '备注'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_USER_INFO
(
    SKEY                VARCHAR(50)  NULL COMMENT '标识唯一',
    SLOGINNAME          VARCHAR(50)  NULL COMMENT '用户账号',
    SPASSWORD           VARCHAR(50)  NULL COMMENT '用户密码',
    SNAME               VARCHAR(50)  NULL COMMENT '姓名',
    SSEXCODE            VARCHAR(50)  NULL COMMENT '性别',
    DBIRTHDAY           VARCHAR(50)  NULL COMMENT '出生日期',
    SIDCARD             VARCHAR(50)  NULL COMMENT '身份证号',
    SNATIONCODE         VARCHAR(50)  NULL COMMENT '民族',
    SMARITALCODE        VARCHAR(50)  NULL COMMENT '婚姻状况',
    SMOBILEPHONE        VARCHAR(50)  NULL COMMENT '移动电话',
    STELEPHONE          VARCHAR(50)  NULL COMMENT '固定电话',
    SADDRESS            VARCHAR(50)  NULL COMMENT '常住地址',
    SMEMO1              VARCHAR(50)  NULL COMMENT '备注1',
    SMEMO2              VARCHAR(50)  NULL COMMENT '备注2',
    SMEMO3              VARCHAR(50)  NULL COMMENT '备注3',
    SMEMO4              VARCHAR(50)  NULL COMMENT '备注4',
    SMEMO5              VARCHAR(50)  NULL COMMENT '备注5',
    ISTATE              VARCHAR(50)  NULL COMMENT '人员状态',
    DOPERATOR           VARCHAR(50)  NULL COMMENT '修改日期',
    GORGANIZATIONKEY    VARCHAR(50)  NULL COMMENT '所在机构主键',
    SORGANIZATIONCODE   VARCHAR(50)  NULL COMMENT '组织机构代码',
    SORGANIZATIONNAME   VARCHAR(50)  NULL COMMENT '组织机构名称',
    SHIGHERHOSPITALCODE VARCHAR(50)  NULL COMMENT '上级机构编码',
    SHIGHERHOSPITALNAME VARCHAR(50)  NULL COMMENT '上级机构名称',
    ISPRIMARYORG        VARCHAR(50)  NULL COMMENT '是否人力资源所属机构',
    ISAPPUSER           VARCHAR(50)  NULL COMMENT '是否注册app帐号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_YAOPIN_INFO
(
    SYPBM             VARCHAR(50)                 NULL COMMENT '药品编码',
    SYCLSH            VARCHAR(50)                 NULL COMMENT '药采流水号',
    SYPMC             VARCHAR(50)                 NULL COMMENT '药品名称',
    SYPLBDM           VARCHAR(50)                 NULL COMMENT '药品类别代码',
    SYPLBMC           VARCHAR(50)                 NULL COMMENT '药品类别名称',
    SYPLBSUBDM        VARCHAR(50)                 NULL COMMENT '药品类别子类代码',
    SYPLBSUBMC        VARCHAR(50)                 NULL COMMENT '药品类别子类名称',
    SGXFLBM           VARCHAR(50)                 NULL COMMENT '药理功效分类代码',
    SGXFLMC           VARCHAR(300)                NULL COMMENT '药理功效分类名称',
    STYMZW            VARCHAR(50)                 NULL COMMENT '通用名中文',
    STYMYW            VARCHAR(100)                NULL COMMENT '通用名英文',
    STXMDM            VARCHAR(50)                 NULL COMMENT '通用名代码',
    SSGYJFLBM         VARCHAR(50)                 NULL COMMENT '酸根盐基分类码',
    SSGYJFLMC         VARCHAR(50)                 NULL COMMENT '酸根盐基分类名称',
    SJXFLBM           VARCHAR(50)                 NULL COMMENT '剂型分类码',
    SJXFLMC           VARCHAR(50)                 NULL COMMENT '剂型分类名称',
    SGG               VARCHAR(500)                NULL COMMENT '规格',
    SZJGGFLM          VARCHAR(50)                 NULL COMMENT '制剂规格分类码',
    SQYMC             VARCHAR(100)                NULL COMMENT '企业名称',
    SQYBM             VARCHAR(50)                 NULL COMMENT '企业编码',
    SPZWH             VARCHAR(50)                 NULL COMMENT '批准文号',
    SZHXS             VARCHAR(50)                 NULL COMMENT '转换系数',
    SZHXSBM           VARCHAR(50)                 NULL COMMENT '转换系数编码',
    SSXM              VARCHAR(50)                 NULL COMMENT '顺序码',
    SSXMBZ            VARCHAR(50)                 NULL COMMENT '顺序码备注',
    SCZ               VARCHAR(50)                 NULL COMMENT '材质',
    SZXBZDW           VARCHAR(50)                 NULL COMMENT '最小包装单位',
    SZXZJDW           VARCHAR(50)                 NULL COMMENT '最小制剂单位',
    SHELPS            VARCHAR(500)                NULL COMMENT '助记码',
    DUPDATEDATE       VARCHAR(50)                 NULL COMMENT '修改时间',
    SBZ               VARCHAR(50)                 NULL COMMENT '包装',
    SJYFLBM           VARCHAR(50)                 NULL COMMENT '基药分类编码',
    SJYTFLMC          VARCHAR(50)                 NULL COMMENT '基药分类名称',
    SZLCC             VARCHAR(50)                 NULL COMMENT '质量层次',
    SLX               VARCHAR(50)                 NULL COMMENT '类型',
    SKJYWDJBM         VARCHAR(50)                 NULL COMMENT '抗菌药物等级',
    SKJYWDJMC         VARCHAR(50)                 NULL COMMENT '抗菌药物名称',
    ISYBZ             VARCHAR(50)                 NULL COMMENT '输液标识',
    SKCDWBM           VARCHAR(50)                 NULL COMMENT '药库单位编码',
    SKCDWMC           VARCHAR(50)                 NULL COMMENT '药库单位名称',
    SZHS              VARCHAR(50)                 NULL COMMENT '转换数',
    SYFDWBM           VARCHAR(50)                 NULL COMMENT '药房单位编码',
    SYFDWMC           VARCHAR(50)                 NULL COMMENT '药房单位名称',
    SXBJL             VARCHAR(50)                 NULL COMMENT '小包剂量',
    SJLDWBM           VARCHAR(50)                 NULL COMMENT '计量单位编码',
    SJLDW             VARCHAR(50)                 NULL COMMENT '计量单位名称',
    DJG               VARCHAR(50)                 NULL COMMENT '价格',
    DJGXX             VARCHAR(50)                 NULL COMMENT '价格下限',
    DJGSX             VARCHAR(50)                 NULL COMMENT '价格上限',
    DYBZFCKJG         VARCHAR(50)                 NULL COMMENT '医保支付参考价',
    SFPXMBM           VARCHAR(50)                 NULL COMMENT '发票项目编码',
    SFPXM             VARCHAR(50)                 NULL COMMENT '发票项目',
    SHSYJXMBM         VARCHAR(50)                 NULL COMMENT '核算一级项目编码',
    SHSYJXMMC         VARCHAR(50)                 NULL COMMENT '核算一级项目名称',
    SHSEJXMBM         VARCHAR(50)                 NULL COMMENT '核算二级项目编码',
    SHSEJXMMC         VARCHAR(50)                 NULL COMMENT '核算二级项目名称',
    SBM1              VARCHAR(50)                 NULL COMMENT '别名1',
    SBM2              VARCHAR(50)                 NULL COMMENT '别名2',
    SBM3              VARCHAR(50)                 NULL COMMENT '别名3',
    SBM4              VARCHAR(50)                 NULL COMMENT '别名4',
    SYPBZBM           VARCHAR(50)                 NULL COMMENT '药品标志编码',
    SYPBZMC           VARCHAR(50)                 NULL COMMENT '药品标志名称',
    IWSSBZ            VARCHAR(50)                 NULL COMMENT '维生素标志',
    IJSBZ             VARCHAR(50)                 NULL COMMENT '激素标志',
    IZDJKYWBZ         VARCHAR(50)                 NULL COMMENT '重点药物监控标志',
    IFLAG             VARCHAR(50)                 NULL COMMENT '启用标识',
    SZXXMBM           VARCHAR(50)                 NULL COMMENT '中心项目编码',
    SZXXMMC           VARCHAR(500)                NULL COMMENT '中心项目名称',
    HOSPITALLEVELCODE VARCHAR(50)                 NULL COMMENT '医院级别编码',
    HOSPITALLEVELNAME VARCHAR(50)                 NULL COMMENT '医院级别名称',
    CORETYPE          VARCHAR(50) DEFAULT 'JQ'  COMMENT '健康平台编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_YAOPIN_ITEM_TYPE_INFO
(
    SYPBM    VARCHAR(50)   NULL COMMENT '药品编码',
    TYPECODE VARCHAR(50)   NULL COMMENT '基层目录统一对照数据来源编码',
    TYPENAME VARCHAR(50)   NULL COMMENT '基层目录统一对照数据来源名称',
    CODE     VARCHAR(50)   NULL COMMENT '接口值域编码',
    NAME     VARCHAR(300)  NULL COMMENT '接口值域名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_ZHENLIAO_INFO
(
    SCODE             VARCHAR(50)   NULL COMMENT '项目编码',
    SNAME             VARCHAR(100)  NULL COMMENT '项目名称',
    SHELP             VARCHAR(200)  NULL COMMENT '助记码',
    SUNIT             VARCHAR(50)   NULL COMMENT '单位',
    FPRICE_WSY        VARCHAR(50)   NULL COMMENT '卫生院定价，单位元',
    FPRICE_WSS        VARCHAR(50)   NULL COMMENT '卫生室定价，单位元',
    FPRICE_WD         VARCHAR(50)   NULL COMMENT '未定级单位定价（一般村级卫生室等机构），单位元',
    FPRICE_YJ         VARCHAR(50)   NULL COMMENT '一级单位定价（一般乡镇卫生院等机构），单位元',
    FPRICE_EJ         VARCHAR(50)   NULL COMMENT '二级医院定价，单位元',
    FPRICE_SJ         VARCHAR(50)   NULL COMMENT '三级医院定价，单位元',
    SMEMO1            VARCHAR(50)   NULL COMMENT '备注1',
    SMEMO2            VARCHAR(50)   NULL COMMENT '备注2',
    SMEMO3            VARCHAR(50)   NULL COMMENT '备注3',
    SMEMO4            VARCHAR(50)   NULL COMMENT '备注4',
    SMEMO5            VARCHAR(50)   NULL COMMENT '备注5',
    IFLAG             VARCHAR(50)   NULL COMMENT '启用标识',
    DUPDATEDATE       VARCHAR(50)   NULL COMMENT '修改日期',
    STYPECODE         VARCHAR(50)   NULL COMMENT '项目类别编码',
    STYPENAME         VARCHAR(50)   NULL COMMENT '项目类别名称',
    SRECEIPTCODE      VARCHAR(50)   NULL COMMENT '发票项目编码',
    SRECEIPTNAME      VARCHAR(50)   NULL COMMENT '发票项目名称',
    IUSER_DEFINED     VARCHAR(50)   NULL COMMENT '是否自定义诊疗项目',
    SZXXMBM           VARCHAR(50)   NULL COMMENT '中心项目编码',
    SZXXMMC           VARCHAR(100)  NULL COMMENT '中心项目名称',
    HOSPITALLEVELCODE VARCHAR(50)   NULL COMMENT '医院级别编码',
    HOSPITALLEVELNAME VARCHAR(50)   NULL COMMENT '医院级别名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE WD_CORE_ZHENLIAO_IT_INFO
(
    SCODE    VARCHAR(50)   NULL COMMENT '项目编码',
    TYPECODE VARCHAR(50)   NULL COMMENT '基层目录统一对照数据来源编码',
    TYPENAME VARCHAR(50)   NULL COMMENT '基层目录统一对照数据来源名称',
    CODE     VARCHAR(50)   NULL COMMENT '接口值域编码',
    NAME     VARCHAR(100)  NULL COMMENT '接口值域名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YBHOSPITALUSEREC
(
    CHOSCODE      VARCHAR(20)      PRIMARY KEY COMMENT '医疗机构编码',
    YLLB          VARCHAR(20)      COMMENT '医疗类别(医疗统一编码)',
    YBPARAMS1     VARCHAR(100)     NULL COMMENT '医保参数1',
    YBPARAMS2     VARCHAR(100)     NULL COMMENT '医保参数2',
    YBPARAMS3     VARCHAR(100)     NULL COMMENT '医保参数3',
    IFOLDROUT     INT DEFAULT 0  COMMENT '是否旧通道',
    ORDERID       INT DEFAULT 0  COMMENT '顺序号',
    SFJB          INT            NULL COMMENT '收费级别',
    YBPARAMS4     VARCHAR(100)     NULL COMMENT '医保参数4',
    YBPARAMS5     VARCHAR(100)     NULL COMMENT '医保参数5',
    YBPARAMS6     VARCHAR(100)     NULL COMMENT '医保参数6',
    YBPARAMS7     VARCHAR(100)     NULL COMMENT '医保参数7',
    YBPARAMS8     VARCHAR(100)     NULL COMMENT '医保参数8',
    YBPARAMS9     VARCHAR(100)     NULL COMMENT '医保参数9',
    IS_REQUEST_YB INT DEFAULT 1  COMMENT '是否请求医保(1:启用 0:不启用-默认)'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YBSUBDICT
(
    YBCENTERCODE  VARCHAR(20)      NOT NULL COMMENT '医保中心编码',
    SUBCENTERCODE VARCHAR(20)      NOT NULL COMMENT '医保分中心编码',
    MEMO          VARCHAR(100)         NULL COMMENT '说明',
    SUBNAME       VARCHAR(40)          NULL COMMENT '医保名称',
    WSJCODE       VARCHAR(20)          NULL COMMENT '卫生局编码',
    YLLB          VARCHAR(8)           NULL COMMENT '医疗类型',
    PYCODE        VARCHAR(40)          NULL COMMENT '拼音码',
    WBCODE        VARCHAR(40)          NULL COMMENT '五笔码',
    ISUSE         INT DEFAULT 0  COMMENT '是否使用  （1 使用 0  停用）'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YBTOHISITEM
(
    CHOSCODE      VARCHAR(20)                 NOT NULL COMMENT '机构编码',
    YLLB          VARCHAR(10)                 NOT NULL COMMENT '医疗类别(医疗统一编码)',
    HOSPLEVEL     INT DEFAULT 3             COMMENT '医院等级',
    HISCODE       VARCHAR(30)                     NULL COMMENT '项目编码',
    FAREITEMID    VARCHAR(30)                 NOT NULL COMMENT '项目编码',
    IFMEDICAL     INT DEFAULT 0             COMMENT '类型(1:项目 0：药品)',
    BEGINDATE     DATE                             NULL COMMENT '开始时间',
    FARENAME      VARCHAR(200)                    NULL COMMENT '项目名称',
    PRICE         INT DEFAULT 0             COMMENT '单价',
    PYCODE        VARCHAR(50)                     NULL COMMENT '拼音码',
    WBCODE        VARCHAR(50)                     NULL COMMENT '五笔码',
    SPEC          VARCHAR(200)                    NULL COMMENT '规格',
    HISCLASS      VARCHAR(30)                     NULL COMMENT 'HIS 类型',
    UNIT          VARCHAR(20)                     NULL COMMENT '单位',
    PZWH          VARCHAR(60)                     NULL COMMENT '标准字号',
    PRODUCER      VARCHAR(100)                    NULL COMMENT '厂家',
    YBCODE        VARCHAR(200)                    NULL COMMENT '医保编码',
    YBFARENAME    VARCHAR(200)                    NULL COMMENT '医保项目名称',
    YBPRICE       INT DEFAULT 0             COMMENT '医保费用',
    YBSPEC        VARCHAR(200)                    NULL COMMENT '医保规格',
    YBCLASS       VARCHAR(40)                     NULL COMMENT '类型（药品、诊疗）',
    YBPZWH        VARCHAR(500)                    NULL COMMENT '医保标准字号',
    REMARK        VARCHAR(100)                    NULL COMMENT '备注',
    OP            VARCHAR(20)                     NULL COMMENT '操作员',
    IFCHECK       INT DEFAULT 0            ,
    CHARGETYPE    VARCHAR(26)                     NULL COMMENT '缴费类型(甲乙类)',
    BILLNO        VARCHAR(36)                     NULL COMMENT '上传流水号',
    CHECKSTATUS   VARCHAR(6) DEFAULT '0'      COMMENT '是否审核(0:未上传 1:审核中 2：审核通过 3：审核未通过)',
    CHECKTYPE     VARCHAR(6)                      NULL COMMENT '审核类型',
    OPACT         VARCHAR(6) DEFAULT 'Add' ,
    RECDATE       DATE                  ,
    YBTJCLASS     VARCHAR(4)                      NULL COMMENT '医保特价类型',
    ZFBL          INT                           NULL COMMENT '自付比例',
    CORETYPE      INT                           NULL COMMENT '药品中心编码(1:贵州 99:其他)',
    YBTYPE        VARCHAR(20)                     NULL COMMENT '医保项目类型编码',
    YBFARETYPE    VARCHAR(50)                     NULL COMMENT '医保项目类型名称',
    COUNTRYYBCODE VARCHAR(200)                    NULL COMMENT '国家医保目录编码',
    COUNTRYYBNAME VARCHAR(400)                    NULL,
    JXNAME        VARCHAR(100)                    NULL,
    ENDDATE       DATE                             NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_CHRONIC_DISEASE_RECORD
(
    PSN_NO             VARCHAR(50)            PRIMARY KEY COMMENT '人员编号',
    INSUTYPE           VARCHAR(6)             COMMENT '险种类型',
    OPSP_DISE_CODE     VARCHAR(50)            COMMENT '门慢门特病种目录代码',
    OPSP_DISE_NAME     VARCHAR(300)           NOT NULL COMMENT '门慢门特病种名称',
    TEL                VARCHAR(50)                NULL COMMENT '联系电话',
    ADDR               VARCHAR(200)               NULL COMMENT '联系地址',
    INSU_OPTINS        VARCHAR(20)            NOT NULL COMMENT '参保机构医保区划',
    IDE_FIXMEDINS_NO   VARCHAR(50)            NOT NULL COMMENT '鉴定定点医药机构编号',
    IDE_FIXMEDINS_NAME VARCHAR(200)           NOT NULL COMMENT '鉴定定点医药机构名称',
    HOSP_IDE_DATE      DATE               NOT NULL COMMENT '医院鉴定日期',
    DIAG_DR_CODG       VARCHAR(20)            NOT NULL COMMENT '诊断医师编码',
    DIAG_DR_NAME       VARCHAR(50)            NOT NULL COMMENT '诊断医师姓名',
    BEGNDATE           DATE                     NOT NULL COMMENT '开始日期',
    ENDDATE            DATE                         NULL COMMENT '结束日期',
    RECDATE            DATE               NOT NULL COMMENT '记录日期',
    HOSPITAL_CODE      VARCHAR(20)            COMMENT '医疗机构编码',
    RESULT_CODE        VARCHAR(50)                NULL COMMENT '申报成功，返回流水号',
    YLLB               VARCHAR(8)              COMMENT '医保类型',
    NAME               VARCHAR(50)                NULL COMMENT '病人姓名'
)
COMMENT '医保人员慢特病备案' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_CHRONIC_DISE_DICT
(
    AREA_CODE    VARCHAR(20)   NULL COMMENT '地区编码',
    CODE         VARCHAR(20)   NULL COMMENT '慢病编码',
    NAME         VARCHAR(100)  NULL COMMENT '慢病名称',
    COUNTRY_CODE VARCHAR(20)   NULL COMMENT '国家编码',
    COUNTRY_NAME VARCHAR(100)  NULL COMMENT '国家名称',
    MARK         VARCHAR(100)  NULL COMMENT '备注'
)
COMMENT '医保曼特病字典表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_COST_DETAIL_UPLOAD_AUDIT
(
    ID           VARCHAR(36)   NOT NULL COMMENT '住院ID',
    HOSP_CODE    VARCHAR(20)   NOT NULL COMMENT '机构编码',
    PATIENT_CODE VARCHAR(20)   NOT NULL COMMENT '住院号',
    MDTRT_ID     VARCHAR(50)   NOT NULL COMMENT '就诊编码',
    AUDIT_TYPE   INT         NOT NULL COMMENT '审核类型',
    USER_NAME    VARCHAR(20)   NOT NULL COMMENT '审核者',
    USER_ID      VARCHAR(20)   NOT NULL COMMENT '审核者ID',
    AUDIT_DATE   DATE           NOT NULL COMMENT '审核时间',
    REMARK       VARCHAR(200)      NULL COMMENT '备注'
)
COMMENT '医保结算清单上传审核' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_COUNTRY_DOCTOR
(
    ID                     VARCHAR(22)            PRIMARY KEY COMMENT '主键编码',
    DESIGNATED_AGENCY_CODE VARCHAR(255)               NULL COMMENT '定点医疗机构代码',
    DESIGNATED_AGENCY_NAME VARCHAR(255)               NULL COMMENT '定点医疗机构名称',
    DOCTOR_CODE            VARCHAR(255)           NOT NULL COMMENT '医保医师代码',
    NAME                   VARCHAR(255)           NOT NULL COMMENT '姓名',
    SEX                    VARCHAR(2)                 NULL COMMENT '性别',
    IDENTITY_TYPE          VARCHAR(3)             NOT NULL COMMENT '身份证件类型',
    IDENTITY_NO            VARCHAR(255)           NOT NULL COMMENT '身份证件号码',
    STATE                  VARCHAR(2)                 NULL COMMENT '人员状态',
    START_DATE             VARCHAR(50)                NULL COMMENT '合同起始时间',
    END_DATE               VARCHAR(50)                NULL COMMENT '合同截止时间',
    CERTIFICATE_NUMBER     VARCHAR(255)               NULL COMMENT '执业证书编码',
    WORK_HOSPITAL_NAME     VARCHAR(255)               NULL COMMENT '执业医疗机构名称',
    PROFESSIONAL_TYPE      VARCHAR(255)               NULL COMMENT '执业类别',
    PROFESSIONAL_RANG      VARCHAR(255)               NULL COMMENT '执业范围',
    PROFESSIONAL_LEVEL     VARCHAR(10)                NULL COMMENT '执业级别',
    TECHNICAL_POSITION     VARCHAR(255)               NULL COMMENT '专业技术职务',
    HOSPITAL_CODE          VARCHAR(20)            NOT NULL COMMENT '机构编码',
    IS_NURSE               INT DEFAULT 0        NOT NULL COMMENT '是否护士 0  医生1  护士',
    PY_CODE                VARCHAR(20)                NULL COMMENT '拼音码',
    WB_CODE                VARCHAR(20)                NULL COMMENT '五笔码',
    YLLB                   VARCHAR(20)                NULL COMMENT '医疗类别(医疗统一编码)',
    REC_DATE               DATE
)
COMMENT '国家医保医生、护士信息表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_COUNTRY_HOSPITAL
(
    ID                       VARCHAR(22)   NOT NULL COMMENT '主键编码',
    DESIGNATED_AGENCY_CODE   VARCHAR(255)      NULL COMMENT '定点医疗机构代码',
    LEGAL_PERSON_COMPANY     VARCHAR(200)      NULL COMMENT '法人单位名称',
    DESIGNATED_AGENCY_NAME   VARCHAR(255)      NULL COMMENT '定点医疗机构名称',
    CREDIT_CODE              VARCHAR(255)      NULL COMMENT '统一社会信用代码',
    LEGAL_PERSON             VARCHAR(50)       NULL COMMENT '法人',
    REGISTER_NUMBER          VARCHAR(50)       NULL COMMENT '登记号',
    BUSINESS_NATURE          VARCHAR(50)       NULL COMMENT '经营性质',
    BUSINESS_TYPE            VARCHAR(50)       NULL COMMENT '经济类型',
    HOSPITAL_CATEGORY        VARCHAR(50)       NULL COMMENT '医疗机构类别',
    SUBORDINATION            VARCHAR(50)       NULL COMMENT '隶属关系',
    HOSPITAL_LEVEL           VARCHAR(50)       NULL COMMENT '医院等级',
    HOSPITAL_GRADE           VARCHAR(50)       NULL COMMENT '医院等次',
    PRINCIPAL                VARCHAR(50)       NULL COMMENT '主要负责人',
    ZHEN_LIAO_KE_MU          VARCHAR(50)       NULL COMMENT '诊疗科目',
    BED_NUMBER               VARCHAR(50)       NULL COMMENT '床位数',
    VALID_PERIOD             VARCHAR(50)       NULL COMMENT '有效期限',
    ADDRESS                  VARCHAR(500)      NULL COMMENT '地址',
    BANK_ACCOUNT_NAME        VARCHAR(500)      NULL COMMENT '银行开户名称',
    BANK_ACCOUNT             VARCHAR(50)       NULL COMMENT '银行账号',
    BANK_NAME                VARCHAR(500)      NULL COMMENT '开户银行',
    MAG_INSURANCE_LEADER     VARCHAR(50)       NULL COMMENT '分管医保院领导',
    MAG_INSURANCE_LEADER_TEL VARCHAR(50)       NULL COMMENT '分管医保院领导电话',
    INSURANCE_PRINCIPAL      VARCHAR(50)       NULL COMMENT '医保办负责人',
    INSURANCE_PRINCIPAL_TEL  VARCHAR(50)       NULL COMMENT '医保办负责人电话',
    INSURANCE_TEL            VARCHAR(50)       NULL COMMENT '医保办电话',
    INSURANCE_EMAIL          VARCHAR(50)       NULL COMMENT '医保办邮箱',
    INSURANCE_COST_LEVEL     VARCHAR(50)       NULL COMMENT '定点医疗机构收费等级',
    EFFECTIVE_TIME           VARCHAR(50)       NULL COMMENT '定点协议生效时间',
    EXPIRATION_TIME          VARCHAR(50)       NULL COMMENT '定点协议截止时间',
    STATUS                   VARCHAR(10)       NULL COMMENT '有效状态',
    SERVICE_OBJECT           VARCHAR(50)       NULL COMMENT '定点协议服务对象',
    SERVICE_AREA             VARCHAR(50)       NULL COMMENT '定点协议服务范围',
    HOSPITAL_CODE            VARCHAR(20)       NULL COMMENT '机构编码',
    YLLB                     VARCHAR(20)       NULL COMMENT '医疗类别(医疗统一编码)'
)
COMMENT '医保国家机构信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MATCH_DCIT
(
    ID         VARCHAR(22)            PRIMARY KEY COMMENT '主键',
    TYPE_CODE  VARCHAR(30)                NULL COMMENT '类别代码',
    TYPE_NAME  VARCHAR(50)                NULL COMMENT '类别名称',
    CODE_VALUE VARCHAR(200)               NULL COMMENT '代码值',
    CODE_NAME  VARCHAR(200)           NOT NULL COMMENT '代码名称',
    WB_CODE    VARCHAR(20)                NULL COMMENT '代码名称五笔码',
    PY_CODE    VARCHAR(20)                NULL COMMENT '代码拼音五笔码',
    REC_DATE   DATE              COMMENT '记录日期',
    YLLB       VARCHAR(8)                 NULL COMMENT '医疗类别（医保类别）'
)
COMMENT '医保对码字典表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MULU_SYNC
(
    ID             VARCHAR(36)   NOT NULL COMMENT 'ID，采用UUID生成',
    YBLB           INT             NULL COMMENT '医保类别',
    DOWNLOAD_DATE  DATE               NULL COMMENT '下载同步时间',
    SAVE_PATH      VARCHAR(100)      NULL COMMENT '存储路径',
    STATUS         INT             NULL COMMENT '1 已下载 2 同步中 2 已同步',
    BACKUP_PATH    VARCHAR(100)      NULL COMMENT '备份路径',
    DOWNLOAD_COUNT INT             NULL COMMENT '下载条目',
    BACKUP_COUNT   INT             NULL COMMENT '备份条目',
    SYNC_DETAIL    VARCHAR(500)      NULL COMMENT '同步情况，差异对比等'
)
COMMENT '医保目录同步表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MZ_COST_DETAIL_RETURN
(
    HISJSLSH           VARCHAR(20)        NULL,
    YBJSLSH            VARCHAR(50)       NULL,
    ITEM_SERIAL_NUMBER VARCHAR(50)    NOT NULL,
    TOTAL_AMOUNT       INT              NULL,
    QUANTITY           INT              NULL,
    PRIC               INT              NULL,
    PRIC_UPLMT_AMT     INT              NULL,
    SELFPAY_PROP       INT              NULL,
    FULAMT_OWNPAY_AMT  INT              NULL,
    OVERLMT_AMT        INT              NULL,
    PRESELFPAY_AMT     INT              NULL,
    INSCP_SCP_AMT      INT              NULL,
    CHRGITM_LV         VARCHAR(10)       NULL,
    MED_CHRGITM_TYPE   VARCHAR(10)       NULL,
    BAS_MEDN_FLAG      VARCHAR(10)       NULL,
    HI_NEGO_DRUG_FLAG  VARCHAR(10)       NULL,
    CHLD_MEDC_FLAG     VARCHAR(10)       NULL,
    LIST_SP_ITEM_FLAG  VARCHAR(10)       NULL,
    LMT_USED_FLAG      VARCHAR(10)       NULL,
    DRT_REIM_FLAG      VARCHAR(10)       NULL,
    MEMO               VARCHAR(500)      NULL,
    HOSPITAL_CODE      VARCHAR(20)    NOT NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MZ_DJSRXX
(
    MZLSH     VARCHAR(20)                PRIMARY KEY COMMENT '门诊流水号',
    CHOSCODE  VARCHAR(20)                COMMENT '机构编码',
    GRBM      VARCHAR(50)               COMMENT '医保个人编码',
    YLLB      VARCHAR(8)                 COMMENT '医保类别',
    CODE      VARCHAR(50)               COMMENT '属性编码',
    NAME      VARCHAR(100)                  NULL COMMENT '属性名称',
    VALUE     VARCHAR(100)                  NULL COMMENT '属性值（转换后的）',
    YBDJLSH   VARCHAR(50)                   NULL COMMENT '医保登记流水号',
    GID       VARCHAR(50) DEFAULT '0 '  NOT NULL COMMENT '组编码（比如1.  生育住院- 2.  职工工伤住院等等）',
    GNAME     VARCHAR(100) DEFAULT '0'  COMMENT '组名称',
    VALUECODE VARCHAR(50)                   NULL COMMENT '属性值编码'
)
COMMENT '医保住院登记输入信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MZ_JSXX01
(
    MZLSH      VARCHAR(20)       NULL COMMENT '门诊流水号',
    CHOSCODE   VARCHAR(20)   NOT NULL COMMENT '机构编码',
    GRBM       VARCHAR(50)  NOT NULL COMMENT '医保个人编码',
    YLLB       VARCHAR(8)    NOT NULL COMMENT '医保类别',
    HISJSLSH   VARCHAR(20)   NOT NULL COMMENT '处方结算流水号（门诊处方表的处方号）',
    YBJSLSH    VARCHAR(50)  NOT NULL COMMENT '医保结算流水号',
    NAME       VARCHAR(50)      NULL COMMENT '病人姓名',
    ZJHM       VARCHAR(50)      NULL COMMENT '病人证件号码',
    YBPAYTYPE  VARCHAR(20)   NOT NULL COMMENT '支付类别',
    INSURETYPE VARCHAR(20)       NULL COMMENT '保险办法',
    XIANZHONG  VARCHAR(20)       NULL COMMENT '保险种类',
    ZJE        INT             NULL COMMENT '总金额',
    GRZHZF     INT             NULL COMMENT '个人账户支付',
    TCZF       INT             NULL COMMENT '统筹支付',
    QTZF       INT             NULL COMMENT '医保其他支付',
    GRXJZF     INT             NULL COMMENT '个人现金支付',
    BIGPAY     INT             NULL COMMENT '大额支付',
    TCECZF     INT             NULL COMMENT '统筹二次支付',
    ZHYE       INT             NULL COMMENT '账户余额',
    RN1        INT             NULL,
    RN2        INT             NULL,
    RN3        INT             NULL,
    RN4        INT             NULL,
    RN5        INT             NULL,
    RN6        INT             NULL,
    RN7        INT             NULL,
    RN8        INT             NULL,
    RN9        INT             NULL,
    RN10       INT             NULL,
    RC1        VARCHAR(50)      NULL,
    RC2        VARCHAR(50)      NULL,
    RC3        VARCHAR(50)      NULL,
    RC4        VARCHAR(50)      NULL,
    RC5        VARCHAR(50)      NULL,
    RC6        VARCHAR(50)      NULL,
    RC7        VARCHAR(50)      NULL,
    RC8        VARCHAR(50)      NULL,
    RC9        VARCHAR(50)      NULL,
    RC10       VARCHAR(50)      NULL,
    YBDJLSH    VARCHAR(50)      NULL COMMENT '医保登记流水号',
    SETL_TIME  DATE               NULL COMMENT '结算时间',
    CLR_NUMBER VARCHAR(20)       NULL COMMENT '医保清算期号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_MZ_JSXX02
(
    MZLSH     VARCHAR(20)         NULL COMMENT '门诊登记流水号',
    CHOSCODE  VARCHAR(20)     PRIMARY KEY COMMENT '医疗机构编码',
    GRBM      VARCHAR(50)    NOT NULL COMMENT '医保个人编码',
    YLLB      VARCHAR(8)      COMMENT '医保类型',
    YBJSLSH   VARCHAR(50)    COMMENT '医保结算流水号',
    YBDJLSH   VARCHAR(50)    NOT NULL COMMENT '医保登记流水号',
    CODE      VARCHAR(50)    COMMENT '属性编码',
    NAME      VARCHAR(100)       NULL COMMENT '属性名称',
    VALUE     VARCHAR(200)      NULL COMMENT '值(有些特殊需要处理过后的值)',
    VALUECODE VARCHAR(200)      NULL COMMENT '值编码（最原始的返回值）',
    GID       VARCHAR(50)        NULL COMMENT '组编码',
    GNAME     VARCHAR(100)       NULL COMMENT '组名称',
    SHOWNAME  VARCHAR(100)       NULL COMMENT '界面显示名称',
    ISSHOW    INT               NULL COMMENT '是否显示（0 否 1 是）',
    HISJSLSH  INT           COMMENT '处方结算流水号（门诊处方表的处方号）'
)
COMMENT '医保住院结算信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_PATIENT_SPECIAL_FLAG
(
    ID                      VARCHAR(30)   NOT NULL COMMENT '主键ID',
    HOSP_CODE               VARCHAR(20)   NOT NULL COMMENT '机构编码',
    PATIENT_CODE            VARCHAR(20)   NOT NULL COMMENT '住院号',
    MDTRT_ID                VARCHAR(100)  NOT NULL COMMENT '就诊ID',
    IPT_PSN_SP_FLAG_TYPE    VARCHAR(50)       NULL COMMENT '住院人员特殊标识类型',
    IPT_PSN_SP_FLAG         VARCHAR(20)       NULL COMMENT '住院人员特殊标识',
    REMARK                  VARCHAR(500)      NULL COMMENT '备注',
    IPT_PSN_SP_FLAG_DETL_ID VARCHAR(50)       NULL COMMENT '住院人员特殊标识明细id',
    USER_NAME               VARCHAR(20)       NULL COMMENT '上传用户名',
    USER_ID                 VARCHAR(20)       NULL COMMENT '上传用户ID',
    UPLOAD_DATE             DATE               NULL COMMENT '上传时间'
)
COMMENT '患者医保特殊属性表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_QING_SUAN_REC
(
    HOSPITAL_CODE        VARCHAR(20)            NOT NULL COMMENT '机构编码',
    CLR_NUMBER           VARCHAR(20)            NOT NULL COMMENT '清算期号',
    CLR_INSURE_TYPE      VARCHAR(20)            NOT NULL COMMENT '险种',
    CLR_TYPE             VARCHAR(10)            NOT NULL COMMENT '清算类别',
    CLR_YB_HOSPITAL_CODE VARCHAR(20)            NOT NULL COMMENT '清算分中心',
    TOTAL_COST           INT DEFAULT 0        COMMENT '费用总额',
    FUND_PAYMENT_COST    INT DEFAULT 0        COMMENT '基本医疗统筹支付金额',
    LARGE_PAYMENT_COST   INT DEFAULT 0        COMMENT '大额医疗支付金额',
    CIVIL_SERVANTS_COST  INT DEFAULT 0        COMMENT '公务员支付金额',
    ACCOUNT_PAYMENT_COST INT DEFAULT 0        COMMENT '个人帐户支付
金额',
    CLR_APPLY_USER_ID    VARCHAR(20)                NULL COMMENT '清算申请人编码',
    CLR_APPLY_USER_NAME  VARCHAR(50)                NULL COMMENT '清算申请人',
    CLR_APPLY_DATE       DATE                    NOT NULL COMMENT '清算申请时间',
    REC_DATE             DATE              COMMENT '记录时间',
    CLR_YB_SERIAL_NUMBER VARCHAR(50)                NULL COMMENT '清算申请流水
号(医保返回)',
    STATUS               INT DEFAULT 0        COMMENT '状态',
    YLLB                 VARCHAR(8)             NOT NULL COMMENT '医保类别'
)
COMMENT '医保清算记录表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_TY_DJXX_CONFIG
(
    YLLB        VARCHAR(8)                 PRIMARY KEY COMMENT '医保类别',
    CODE        VARCHAR(50)               NOT NULL COMMENT '属性编码',
    NAME        VARCHAR(100)              NOT NULL COMMENT '属性名称',
    VALUE       VARCHAR(100)                  NULL COMMENT '属性值',
    ISHOW       INT DEFAULT 1            COMMENT '是否显示 0  否 1 是',
    DEFALTVALUE VARCHAR(500)                  NULL COMMENT '默认值',
    SHOWNAME    VARCHAR(100)                  NULL COMMENT '显示界面得名称',
    DATATYPE    INT                      NOT NULL COMMENT '0  int 1 string 2 datetime  3 查询控件',
    ORDID       INT                          NULL COMMENT '序号',
    ISREQUIRED  INT DEFAULT 0            COMMENT '是否必填  0 否 1 是',
    MZORZY      INT                          NULL COMMENT '就诊类型  0  通用  1 门诊  2 住院 ',
    `MINVALUE`    INT                          NULL COMMENT '最小值',
    `MAXVALUE`    INT                          NULL COMMENT '最大值',
    CONFIGVALUE VARCHAR(200)                 NULL COMMENT '其他配置',
    GID         VARCHAR(50) DEFAULT '0 '  NOT NULL COMMENT '组编码（比如1.  生育住院- 2.  职工工伤住院等等）',
    GNAME       VARCHAR(100) DEFAULT '0'  COMMENT '组名称'
)
COMMENT '医保等级信息配置表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_TY_GRXX
(
    CARDID    VARCHAR(30)               PRIMARY KEY COMMENT '医保卡号',
    GID       VARCHAR(50) DEFAULT '0 '  COMMENT '组号',
    GNAME     VARCHAR(100) DEFAULT '0'  COMMENT '组名称',
    CODE      VARCHAR(50)               COMMENT '属性编码',
    NAME      VARCHAR(100)              NOT NULL COMMENT '属性名称',
    VALUE     VARCHAR(100)                  NULL COMMENT '属性值（转换后的）',
    ORDID     VARCHAR(50) DEFAULT '0'   COMMENT '序号',
    GRBM      VARCHAR(50)               COMMENT '个人编码',
    JZTYPE    INT                          NULL COMMENT '就诊类型  0  通用  1 门诊  2 住院 ',
    YLLB      VARCHAR(8)                 COMMENT '医保类别',
    VALUECODE VARCHAR(50)                   NULL COMMENT '属性值编码'
)
COMMENT '医保卡号信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_TY_SCXX
(
    HISLSH    VARCHAR(20)                NOT NULL COMMENT '门诊或者住院流水号',
    CHOSCODE  VARCHAR(20)                NOT NULL,
    GRBM      VARCHAR(50)               NOT NULL COMMENT '医保个人编码',
    YLLB      VARCHAR(8)                 NOT NULL COMMENT '医保类别',
    CODE      VARCHAR(50)               NOT NULL COMMENT '属性编码',
    NAME      VARCHAR(100)                  NULL COMMENT '属性名称',
    VALUE     VARCHAR(500)                  NULL COMMENT '属性值（转换后的）',
    YBDJLSH   VARCHAR(50)                   NULL COMMENT '医保登记流水号',
    GID       VARCHAR(50) DEFAULT '0 '  NOT NULL COMMENT '组号（返回值又多组的情况）',
    GNAME     VARCHAR(100) DEFAULT '0'  COMMENT '组名称',
    YBJKTYPE  INT                      NOT NULL COMMENT '医保接口类型  1 登记返回 ',
    MZORZY    INT DEFAULT 1            COMMENT '1  门诊  2 住院',
    VALUECODE VARCHAR(500)                  NULL COMMENT '属性值编码',
    SHOWNAME  VARCHAR(100)                  NULL COMMENT '界面显示名称',
    ISSHOW    INT                          NULL COMMENT '是否显示（0 否 1 是）'
)
COMMENT '医保通用输出信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_ZY_DJSRXX
(
    ZYLSH     VARCHAR(20)                PRIMARY KEY COMMENT '住院流水号',
    CHOSCODE  VARCHAR(20)                COMMENT '机构编码',
    GRBM      VARCHAR(50)               COMMENT '医保个人编码',
    YLLB      VARCHAR(8)                 COMMENT '医保类别',
    CODE      VARCHAR(50)               COMMENT '属性编码',
    NAME      VARCHAR(100)                  NULL COMMENT '属性名称',
    VALUE     VARCHAR(100)              NOT NULL COMMENT '属性值(转换后的)',
    YBDJLSH   VARCHAR(50)                    NULL COMMENT '医保登记流水号',
    GID       VARCHAR(50) DEFAULT '0 '  NOT NULL COMMENT '组编码（比如1.  生育住院- 2.  职工工伤住院等等）',
    GNAME     VARCHAR(100) DEFAULT '0'  COMMENT '组名称',
    VALUECODE VARCHAR(50)                   NULL COMMENT '属性值编码'
)
COMMENT '医保住院登记输入信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_ZY_JSXX01
(
    ZYLSH      VARCHAR(20)   NOT NULL COMMENT '住院流水号',
    CHOSCODE   VARCHAR(20)   NOT NULL COMMENT '机构编码',
    GRBM       VARCHAR(50)  NOT NULL COMMENT '医保个人编码',
    YLLB       VARCHAR(8)    NOT NULL COMMENT '医保类别',
    HISJSLSH   VARCHAR(20)   NOT NULL COMMENT '住院结算流水号（住院结算表的结算流水号）',
    YBJSLSH    VARCHAR(50)  NOT NULL COMMENT '医保结算流水号',
    NAME       VARCHAR(50)      NULL COMMENT '病人姓名',
    ZJHM       VARCHAR(50)      NULL COMMENT '病人证件号码',
    YBPAYTYPE  VARCHAR(20)   NOT NULL COMMENT '支付类别',
    INSURETYPE VARCHAR(20)       NULL COMMENT '保险办法',
    XIANZHONG  VARCHAR(20)       NULL COMMENT '保险种类',
    ZJE        INT             NULL COMMENT '总金额',
    GRZHZF     INT             NULL COMMENT '个人账户支付',
    TCZF       INT             NULL COMMENT '统筹支付',
    QTZF       INT             NULL COMMENT '其他支付',
    GRXJZF     INT             NULL COMMENT '个人现金支付',
    BIGPAY     INT             NULL COMMENT '大额支付',
    TCECZF     INT             NULL COMMENT '统筹二次支付',
    ZHYE       INT             NULL COMMENT '账户余额',
    RN1        INT             NULL,
    RN2        INT             NULL,
    RN3        INT             NULL,
    RN4        INT             NULL,
    RN5        INT             NULL,
    RN6        INT             NULL,
    RN7        INT             NULL,
    RN8        INT             NULL,
    RN9        INT             NULL,
    RN10       INT             NULL,
    RC1        VARCHAR(50)      NULL,
    RC2        VARCHAR(50)      NULL,
    RC3        VARCHAR(50)      NULL,
    RC4        VARCHAR(50)      NULL,
    RC5        VARCHAR(50)      NULL,
    RC6        VARCHAR(50)      NULL,
    RC7        VARCHAR(50)      NULL,
    RC8        VARCHAR(50)      NULL,
    RC9        VARCHAR(50)      NULL,
    RC10       VARCHAR(50)      NULL,
    YBDJLSH    VARCHAR(50)      NULL COMMENT '医保登记流水号',
    SETL_TIME  DATE               NULL COMMENT '结算时间',
    CLR_NUMBER VARCHAR(20)       NULL COMMENT '医保清算期号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YB_ZY_JSXX02
(
    ZYLSH     VARCHAR(20)     PRIMARY KEY COMMENT '住院流水号',
    CHOSCODE  VARCHAR(20)     COMMENT '医疗机构编码',
    GRBM      VARCHAR(50)    NOT NULL COMMENT '医保个人编码',
    YLLB      VARCHAR(8)      COMMENT '医保类型',
    YBJSLSH   VARCHAR(50)    COMMENT '医保结算流水号',
    YBDJLSH   VARCHAR(50)    NOT NULL COMMENT '医保登记流水号',
    CODE      VARCHAR(50)    COMMENT '属性编码',
    NAME      VARCHAR(100)       NULL COMMENT '属性名称',
    VALUE     VARCHAR(200)      NULL COMMENT '值(有些特殊需要处理过后的值)',
    VALUECODE VARCHAR(200)      NULL COMMENT '值编码（最原始的返回值）',
    GID       VARCHAR(50)        NULL COMMENT '组编码',
    GNAME     VARCHAR(100)       NULL COMMENT '组名称',
    SHOWNAME  VARCHAR(100)       NULL COMMENT '界面显示名称',
    ISSHOW    INT               NULL COMMENT '是否显示（0 否 1 是）',
    HISJSLSH  INT           COMMENT '住院结算流水号'
)
COMMENT '医保住院结算信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YF_KC_ACCEPT_REC
(
    ID               VARCHAR(40)           NOT NULL COMMENT '编码',
    HOSPITAL_CODE    VARCHAR(20)           NOT NULL COMMENT '机构编码',
    CODE             VARCHAR(40)           NOT NULL COMMENT '编码(药品材料编码)',
    IN_BILL_NO       VARCHAR(40)           NOT NULL COMMENT '入库单号',
    ORDER_INDEX      INT                  NOT NULL COMMENT '序号',
    GH_DATE          DATE                    NOT NULL COMMENT '供货日期',
    ACCEPT_USER_ID   INT                  NOT NULL COMMENT '验收人编码',
    ACCEPT_USER_NAME VARCHAR(50)           NOT NULL COMMENT '验收人姓名',
    ACCEPT_RESULT    VARCHAR(40)           NOT NULL COMMENT '验收结论',
    CREATE_DATE      DATE              COMMENT '创建时间'
)
COMMENT '药品库存验收记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YF_KC_MAINTAIN_REC
(
    ID                 VARCHAR(40)            NOT NULL COMMENT '编码',
    HOSPITAL_CODE      VARCHAR(20)            NOT NULL COMMENT '机构编码',
    CODE               VARCHAR(40)            NOT NULL COMMENT '编码(药品材料编码)',
    IN_BILL_NO         VARCHAR(40)            NOT NULL COMMENT '入库单号',
    KC_FLOW            INT                   NOT NULL COMMENT '库存流水号',
    MAINTAIN_DATE      DATE               NOT NULL COMMENT '养护日期',
    MAINTAIN_USER_ID   INT                   NOT NULL COMMENT '养护人编码',
    MAINTAIN_USER_NAME VARCHAR(50)            NOT NULL COMMENT '养护人姓名',
    COMPLETENESS       VARCHAR(50)            NOT NULL COMMENT '完整性',
    DEFINITION         VARCHAR(50)            NOT NULL COMMENT '清晰度',
    DAMAGE_DEGREE      VARCHAR(50)            NOT NULL COMMENT '损坏程度',
    PACKAGE_COLOR      VARCHAR(50)            NOT NULL COMMENT '包装及颜色',
    TREATMENT_MEASURES VARCHAR(500)               NULL COMMENT '处理措施',
    CREATE_DATE        DATE               NOT NULL COMMENT '创建时间'
)
COMMENT '药品库存验收记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYDETAIL
(
    CHOSCODE       VARCHAR(20)       PRIMARY KEY COMMENT '医疗机构编码',
    APPLYID        INT             COMMENT '申请ID(对应表YJApplyMain里的ApplyID)',
    YJCODE         VARCHAR(200)      COMMENT '检验或检查项目编码(如果是打包项目，则编码前加D)',
    YJNAME         VARCHAR(500)          NULL COMMENT '检验或检查项目名称',
    APPLYKIND      INT             NOT NULL COMMENT '申请单分类(1：检查申请单；2：化验申请单；3：手术申请单)',
    APPLYSOURCE    INT             NOT NULL COMMENT '来源类型(1：门诊；2：住院；3：急诊；5：体检)',
    EXPL_NUM       VARCHAR(50)           NULL COMMENT '标本号/检查号',
    BARCODENUM     VARCHAR(50)           NULL COMMENT '试管条码号',
    BARDATE        DATE                   NULL COMMENT '标本采集时间',
    BAROPERATOR    VARCHAR(50)           NULL COMMENT '标本采集人',
    YJFARE         INT                 NULL COMMENT '费用',
    IFPRINT        INT DEFAULT 0   NOT NULL COMMENT '是否已打印',
    PRINTOPERATOR  VARCHAR(20)           NULL COMMENT '打印人',
    PRINTDATE      DATE                   NULL COMMENT '打印时间',
    STATUS         INT             NOT NULL COMMENT '状态(0：被打回；1：未发送；2：已发送；3：已签收；4：已登记；7：已审核；8：已出结果；9：无效)',
    PAYOFFDATE     DATE                   NULL COMMENT '打回时间',
    PAYOFFDOCTOR   VARCHAR(50)           NULL COMMENT '打回医生',
    RECVDATE       DATE                   NULL COMMENT '签收时间',
    RECVDOCTOR     VARCHAR(50)           NULL COMMENT '签收医生',
    REGDATE        DATE                   NULL COMMENT '登记时间',
    REGDOCTOR      VARCHAR(50)           NULL COMMENT '登记医生',
    SHDATE         DATE                   NULL COMMENT '审核时间',
    SHDOCTOR       VARCHAR(50)           NULL COMMENT '审核医生',
    YJFLOWCODE     VARCHAR(50)           NULL COMMENT '医技系统内部流水号',
    YJDATE         DATE                   NULL COMMENT '检验时间',
    YJDOCTOR       VARCHAR(50)           NULL COMMENT '检验医生',
    REPORTDATE     DATE                   NULL COMMENT '报告时间',
    REPORTDOCTOR   VARCHAR(50)           NULL COMMENT '报告医生',
    SHREPORTDATE   DATE                   NULL COMMENT '报告审核时间',
    SHREPORTDOCTOR VARCHAR(50)           NULL COMMENT '报告审核医生',
    DEVCHKNUM      VARCHAR(50)           NULL COMMENT '设备上机号',
    EXEMPLAR       VARCHAR(50)           NULL COMMENT '检验标本',
    EXPL_STA       VARCHAR(50)           NULL COMMENT '1表示高危 2表示低危',
    EXPL_TIME      VARCHAR(50)           NULL COMMENT '标本收样时间',
    DEVICENAME     VARCHAR(50)           NULL COMMENT '设备名称',
    YJRESULT       VARCHAR(100)         NULL COMMENT '报告结果',
    YJMEMO         VARCHAR(200)          NULL COMMENT '备注/注意事项',
    CHECKAREA      VARCHAR(100)          NULL COMMENT '检查部位(PACS返回)',
    CHECKNAME      VARCHAR(100)          NULL COMMENT '检查名称(PACS返回)',
    CHECKMETHOD    VARCHAR(100)          NULL COMMENT '检查方法(PACS返回)',
    CHECKDESCRIPT  VARCHAR(100)         NULL COMMENT '现象描述文字',
    RESULTTYPE     INT                 NULL COMMENT '检查类型阳性率(1--阳性  0-阴性)',
    IFCKRESULT     INT DEFAULT 0   COMMENT '是否已查看结果 0 否 1 是',
    ORGOUTFLAG     VARCHAR(1)            NULL COMMENT '院内院外报告标志 0 院内 1 院外',
    ORGNAME        VARCHAR(50)           NULL COMMENT '报告机构名称',
    DATAFORMTSAVE  BIT                   NULL COMMENT '保存格式数据',
    ORGID          VARCHAR(50)           NULL COMMENT '报告机构名称ID',
    IMAGEADDRESS   VARCHAR(300)          NULL COMMENT '影像图像存放路径'
)
COMMENT '医技申请单细表(包括检查申请单、化验申请单、手术申请单等)
与申请主表的关系：检查、手术申请记录是1对1，检验是1对多' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYDETAILRESULT
(
    CHOSCODE   VARCHAR(20)   PRIMARY KEY COMMENT '医疗机构编码',
    APPLYID    INT         COMMENT '申请ID(对应表YJApplyMain里的ApplyID)',
    YJCODE     VARCHAR(200)  COMMENT '检验或检查项目编码',
    RESULTNO   INT         COMMENT '结果序号值',
    APPLYKIND  INT         NOT NULL COMMENT '申请单分类(1：检查申请单；2：化验申请单；3：手术申请单)',
    ITEMNAME   VARCHAR(50)       NULL COMMENT '细项名称',
    DATATYPE   INT             NULL COMMENT '检查结果来源(0：定量结果；1：定性结果)',
    REFVALUE   VARCHAR(100)      NULL COMMENT '参考值',
    RESULT     VARCHAR(100)      NULL COMMENT '结果值',
    UNIT       VARCHAR(50)       NULL COMMENT '单位',
    RESULTHINT VARCHAR(100)      NULL COMMENT '结果值提示',
    LABNUM     VARCHAR(20)       NULL COMMENT '检验标本号',
    CHECKNUM   VARCHAR(50)       NULL COMMENT '检验报告号'
)
COMMENT '医技申请单结果记录(包括检查申请单、化验申请单、手术申请单等)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYFAREREC
(
    APPLYID    INT             PRIMARY KEY COMMENT '申请流水号(对应his.YJApplyRec表里的ApplyID)',
    RECIPECODE VARCHAR(20)       COMMENT '对应单据ID（门诊病人，对应电子处方表里的MCode；住院病人对应医嘱表里的序号或住院处方表里的处方号；体检病人，对应门诊处方表里的处方号）',
    RECIPEKIND INT             COMMENT '对应类型(1：对应his.电子处方表；2：对应his.医嘱记录表；3：对应his.门诊处方表；4：对应his.住院处方表)',
    FARETHING  INT DEFAULT 0   NOT NULL COMMENT '收费情况(1：已收费；0：未收费；)',
    CHOSCODE   VARCHAR(20)       COMMENT '医疗机构编码'
)
COMMENT '医技费用关联表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYMAIN
(
    CHOSCODE      VARCHAR(20)             PRIMARY KEY COMMENT '医疗机构编码',
    APPLYID       INT                   COMMENT '申请ID(由序列SEQ_YZApply生成)',
    APPLYKIND     INT                   NOT NULL COMMENT '申请单分类(1：检查申请单；2：化验申请单；3：手术申请单；4：心电申请单)',
    APPLYSOURCE   INT                   NOT NULL COMMENT '来源类型(1：门诊；2：住院；3：急诊；5：体检)',
    SICKCODE      VARCHAR(50)             NOT NULL COMMENT '门诊号/住院号/体检号',
    SICKNAME      VARCHAR(50)                 NULL COMMENT '患者姓名',
    SICKSEX       VARCHAR(10)                 NULL COMMENT '患者性别',
    SICKAGE       INT                       NULL COMMENT '患者年龄',
    AGEUNIT       VARCHAR(10)                 NULL COMMENT '年龄单位(年、月、日、时、分)',
    IDENCARD      VARCHAR(20)                 NULL COMMENT '身份证号码',
    YZNO          INT                       NULL COMMENT '医嘱序号(对应ZYYZRec里的YZNo)',
    TARGET        VARCHAR(200)                NULL COMMENT '检验或检查目的',
    YJCODE        VARCHAR(200)                NULL COMMENT '检验或检查项目编码(多个项目的格式为：申请ID+CHAR(2)+检查或检验项目代码+CHAR(3)))
(如果是打包项目，则编码前加D)',
    YJNAME        VARCHAR(500)                NULL COMMENT '检验或检查项目名称(多个项目以,分割)',
    CHECKEQ       VARCHAR(50)                 NULL COMMENT '设备标识类型(如CT/MR等)',
    CHECKBODY     VARCHAR(500)                NULL COMMENT '检查部位',
    YJFARE        INT                       NULL COMMENT '费用',
    DIAG          VARCHAR(100)                NULL COMMENT '诊断',
    APPLYDEPTID   INT                       NULL COMMENT '申请科室ID(对应his.科室表里的ID字段)',
    APPLYDEPT     VARCHAR(50)                 NULL COMMENT '申请科室',
    APPLYDOCTOR   VARCHAR(20)                 NULL COMMENT '申请医生',
    APPLYDOCTORID INT                   NOT NULL COMMENT '申请医生ID(对应his.医生表里的ID字段)',
    APPLYDATE     DATE               COMMENT '申请日期',
    BARCODENUM    VARCHAR(50)                 NULL COMMENT '试管条码号',
    PRETIME       DATE               COMMENT '预约时间',
    MEMO          VARCHAR(100)                NULL COMMENT '备注',
    OPERATORID    INT                   NOT NULL COMMENT '操作员ID(对应【his.用户表】里ID字段)',
    OPERATORNAME  VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    RECDATE       DATE               NOT NULL COMMENT '记录时间',
    IFPRINT       INT DEFAULT 0         NOT NULL COMMENT '是否已打印',
    PRINTOPERATOR VARCHAR(20)                 NULL COMMENT '打印人',
    PRINTDATE     DATE                         NULL COMMENT '打印时间',
    STATUS        INT                   NOT NULL COMMENT '状态(0：被打回；1：未发送；2：已发送；3：已签收；4：已登记；7：已审核；8：已出结果；9：无效)',
    REQSTATUS     INT DEFAULT 0         COMMENT '标本申请状态(0：普通；2：急诊)',
    BEDNO         VARCHAR(20)                 NULL COMMENT '床号',
    UPFLAG        INT                       NULL COMMENT '上传标志',
    ISPUSHED      INT                       NULL COMMENT '是否已推送标志(1:推送 其他:未推送)'
)
COMMENT '医技申请单主表(包括检查申请单、化验申请单、手术申请单等)
' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYPACSRESULT
(
    CHOSCODE         VARCHAR(20)      NOT NULL COMMENT '医疗机构编码',
    APPLYID          INT            NOT NULL COMMENT '申请ID(对应表YJApplyMain里的ApplyID)',
    CHECKAREA        VARCHAR(100)     NOT NULL COMMENT '检查部位',
    CHECKNAME        VARCHAR(100)     NOT NULL COMMENT '检查名称',
    CHECKMETHOD      VARCHAR(100)         NULL COMMENT '检查方法',
    CHECKDESCRIPT    VARCHAR(100)        NULL COMMENT '现象描述文字',
    RESULTTYPE       INT                NULL COMMENT '检查类型阳性率  0--待定  1--阴性  2--阳性  4--待定危机值 5--阴性危机值 6--阳性危机值',
    CHECKDATE        DATE                  NULL COMMENT '检查时间',
    CHECKDOCTORID    VARCHAR(20)          NULL COMMENT '检查医生id',
    CHECKDOCTORNAME  VARCHAR(50)          NULL COMMENT '检查医生姓名',
    REPORTDATE       DATE                  NULL COMMENT '报告时间',
    REPORTDOCTORID   VARCHAR(20)          NULL COMMENT '报考医生id',
    REPORTDOCTORNAME VARCHAR(50)          NULL COMMENT '报考医生姓名',
    VERIFYDATE       DATE                  NULL COMMENT '审核日期',
    VERIFYDOCTORID   VARCHAR(20)          NULL COMMENT '审核医生id',
    VERIFYDOCTORNAME VARCHAR(50)          NULL COMMENT '审核医生姓名',
    STATUS           INT DEFAULT 0  COMMENT '状态',
    CHECKCODE        VARCHAR(20)      NOT NULL COMMENT '检查项目编码',
    CHECKSERIALNO    VARCHAR(20)          NULL COMMENT '检查流水号',
    CHECKRESULT      VARCHAR(100)        NULL COMMENT '检查结果',
    CHECKMEMO        VARCHAR(100)        NULL COMMENT '注意事项'
)
COMMENT '医技检查申请单结果记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE YJAPPLYXDRESULT
(
    CHOSCODE  VARCHAR(20)             PRIMARY KEY COMMENT '医疗机构编码',
    APPLYID   INT                   COMMENT '申请ID(对应表YJApplyMain里的ApplyID)',
    YJCODE    VARCHAR(200)            COMMENT '检验或检查项目编码',
    RESULTNO  INT                   COMMENT '结果序号值',
    FILENAME  VARCHAR(200)                NULL COMMENT '文件名称',
    FILETYPE  VARCHAR(50)                 NULL COMMENT '文件格式',
    FILETHING BIT                         NULL COMMENT '文件内容',
    RECDATE   DATE               NOT NULL COMMENT '记录时间',
    FILEURL   VARCHAR(200)                NULL COMMENT '文件地址'
)
COMMENT '医技申请单结果记录(包括心电申请单)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYNURSEFAREREC
(
    SERIALNO VARCHAR(20)    NOT NULL COMMENT '序号',
    SICKCODE VARCHAR(20)    NOT NULL COMMENT '住院号',
    CHOSCODE VARCHAR(20)    NOT NULL COMMENT '机构编码',
    ITEMCODE VARCHAR(20)        NULL COMMENT '项目编码',
    ITEMNAME VARCHAR(100)      NULL COMMENT '项目名称',
    ITEMTYPE VARCHAR(20)        NULL COMMENT '项目分类',
    SPEC     VARCHAR(20)       NULL COMMENT '规格',
    UNIT     VARCHAR(20)        NULL COMMENT '单位',
    NUM      VARCHAR(10)       NULL COMMENT '数量',
    PRICE    VARCHAR(10)       NULL COMMENT '价格',
    EXEPRICE VARCHAR(10)       NULL COMMENT '执行单价',
    FARE     VARCHAR(10)       NULL COMMENT '金额 数量*执行单价',
    RECVDEPT VARCHAR(20)        NULL COMMENT '接单科室',
    MID      VARCHAR(20)        NULL COMMENT '药房',
    DBNAME   VARCHAR(100)      NULL COMMENT '打包名',
    DBID     VARCHAR(20)        NULL COMMENT '打包ID',
    NHNAME   VARCHAR(100)      NULL COMMENT '农合名称',
    NHCODE   VARCHAR(20)        NULL COMMENT '农合编码',
    KCFLOW   VARCHAR(20)        NULL COMMENT '库存流水',
    FLAG     VARCHAR(2)        NULL COMMENT '标志1诊疗 0药品',
    IFUSE    VARCHAR(2)        NULL COMMENT '是否使用',
    DBFCODE  VARCHAR(20)        NULL COMMENT '打包项目父项序号',
    USERDEPT VARCHAR(20)        NULL COMMENT '操作科室',
    USERID   VARCHAR(20)        NULL COMMENT '操作员ID',
    UNITNAME VARCHAR(20)       NULL COMMENT '单位名称',
    EXEDATE  VARCHAR(20)        NULL COMMENT '执行日期格式yyyymmdd',
    IFBABY   VARCHAR(2)         NULL COMMENT '婴儿标志'
)
COMMENT '住院护士计费项目表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZFAREREC
(
    CHOSCODE     VARCHAR(20)            PRIMARY KEY,
    SICKCODE     VARCHAR(20)            ,
    VIRTUE       INT DEFAULT 0       ,
    YZNO         INT                  ,
    YZFAREID     INT                  ,
    FARETYPE     INT                  NOT NULL,
    FARECODE     VARCHAR(30)                NULL,
    FLAG         INT                      NULL,
    FAREITEMNAME VARCHAR(200)           NOT NULL,
    FAREKIND     INT                  NOT NULL,
    QUANTITY     INT                  NOT NULL,
    PRICE        INT                  NOT NULL,
    SPEC         VARCHAR(500)               NULL,
    JX           VARCHAR(50)                NULL,
    UNITID       INT                      NULL,
    UNITNAME     VARCHAR(50)                NULL,
    JLXS         INT                      NULL,
    DICT_JLXS    INT                      NULL,
    MID          INT                      NULL,
    YPPRICE      INT                      NULL,
    DBID         VARCHAR(20)                NULL,
    DBNAMES      VARCHAR(100)               NULL,
    RECVDEPTID   INT                      NULL,
    PRICETANG    INT DEFAULT 0        NOT NULL,
    RECVDEPTFLAG INT                      NULL,
    IFSERIES     INT                      NULL,
    SURPLUSNUM   INT                      NULL,
    MEASUREUNIT  VARCHAR(50)                NULL,
    MSINGLENUM   INT                      NULL,
    SPECIALUSES  VARCHAR(500)               NULL,
    FARELY       VARCHAR(1)                 NULL,
    EXEPRICE     INT                      NULL,
    CREATE_DATE  DATE
)
COMMENT '住院医嘱费用细表(记录病人每条医嘱的费用记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZFARERECNEW
(
    CHOSCODE     VARCHAR(20)            PRIMARY KEY,
    SICKCODE     VARCHAR(20)            ,
    VIRTUE       INT DEFAULT 0       ,
    YZNO         INT                  ,
    YZFAREID     INT                  ,
    FARETYPE     INT                  NOT NULL,
    FARECODE     VARCHAR(30)                NULL,
    FLAG         INT                      NULL,
    FAREITEMNAME VARCHAR(200)           NOT NULL,
    FAREKIND     INT                  NOT NULL,
    QUANTITY     INT                  NOT NULL,
    PRICE        INT                  NOT NULL,
    SPEC         VARCHAR(500)               NULL,
    JX           VARCHAR(50)                NULL,
    UNITID       INT                      NULL,
    UNITNAME     VARCHAR(50)                NULL,
    JLXS         INT                      NULL,
    DICT_JLXS    INT                      NULL,
    MID          INT                      NULL,
    YPPRICE      INT                      NULL,
    DBID         VARCHAR(20)                NULL,
    DBNAMES      VARCHAR(100)               NULL,
    RECVDEPTID   INT                      NULL,
    PRICETANG    INT DEFAULT 0        NOT NULL,
    RECVDEPTFLAG INT                      NULL,
    IFSERIES     INT                      NULL,
    SURPLUSNUM   INT                      NULL,
    MEASUREUNIT  VARCHAR(50)                NULL,
    MSINGLENUM   INT                      NULL,
    SPECIALUSES  VARCHAR(500)               NULL,
    FARELY       VARCHAR(1)                 NULL,
    EXEPRICE     INT                      NULL,
    CREATE_DATE  DATE
)
COMMENT '住院医嘱费用细表(记录病人每条医嘱的费用记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZMODELDETAIL
(
    CHOSCODE    VARCHAR(20)            PRIMARY KEY COMMENT '医疗机构编码',
    MODELID     INT                  COMMENT '模板ID(对应ZYYZModelMain里的ID)',
    YZNO        INT                  COMMENT '医嘱序号((产生规则：由序列SEQ_ZYYZNo生成)',
    FYZNO       INT                  NOT NULL COMMENT '父医嘱序号(如无，则为该条医嘱的医嘱序号)',
    ITEMTYPE    INT                  NOT NULL COMMENT '项目类型(区分药品、诊疗项目、打包、医嘱字典  1:西药；2：中成药；3：草药；4：诊疗项目；5：打包项目；6：医嘱字典)',
    YJTYPE      INT DEFAULT 0        NOT NULL COMMENT '医技类型(0：非医技类型；1：化验类型；2：检查类型；3：心电类型)',
    ITEMCODE    VARCHAR(2)             NOT NULL COMMENT '医嘱类别(对应DictYZKind字典里的ItemCode字段)',
    YZTHING     VARCHAR(800)               NULL COMMENT '医嘱内容',
    FARECODE    VARCHAR(30)                NULL COMMENT '费用编码(如为药品医嘱，则该字段对应药品字典表里的药品编码字段，如为诊疗项目，则该字典对应项目表里的项目编码；如为打包项目，则该字典对应大诊疗项目表里RKey字段；如为医嘱字典，则该字段对应医嘱字典的医嘱字典ID)',
    ITEMNAMES   VARCHAR(500)               NULL COMMENT '对应项目名称',
    MTOTALNUM   INT                      NULL COMMENT '药品总量(如为药品医嘱，该字段不为空)',
    MTOTALUNIT  VARCHAR(50)                NULL COMMENT '总量单位(门诊单位)',
    MSINGLENUM  INT                      NULL COMMENT '药品单次用量(如为药品医嘱，该字段不为空)',
    MEASUREUNIT VARCHAR(50)                NULL COMMENT '计量单位',
    GYCODE      VARCHAR(4)                 NULL COMMENT '给药途径序号(对应DictGYTJ里ItemCode字段)',
    PLCODE      VARCHAR(4)                 NULL COMMENT '医嘱频率编码(对应DictYZFrequence里的ItemCode字段)',
    PLNAME      VARCHAR(30)                NULL COMMENT '医嘱频率名称(对应表DictYZFrequence医嘱频率字典里的ItemName字段)',
    PLSPACE     INT                      NULL COMMENT '间隔数量',
    SPACEUNIT   VARCHAR(20)                NULL COMMENT '间隔单位',
    PLTIMES     INT                      NULL COMMENT '间隔单位执行次数',
    RECVDEPTID  INT                      NULL COMMENT '执行科室代码(对应his.科室表里的ID字段)',
    RECDATE     DATE              COMMENT '录入时间',
    PRICETANG   INT DEFAULT 0        NOT NULL COMMENT '计价特性(0：正常计价；10：自带药；20：另开处方；40：不计价)',
    DOCTORZT    VARCHAR(200)               NULL COMMENT '医生嘱托',
    TSYF        VARCHAR(500)               NULL COMMENT '特殊用法',
    IFPS        INT DEFAULT 0        NOT NULL COMMENT '是否需要皮试',
    IFZT        INT DEFAULT 0        NOT NULL COMMENT '是否嘱托',
    CHECKBODY   VARCHAR(50)                NULL COMMENT '检查部位'
)
COMMENT '住院医嘱模板细表(医嘱模板的明细记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZMODELFARE
(
    CHOSCODE     VARCHAR(20)   PRIMARY KEY COMMENT '医疗机构编码',
    MODELID      INT         COMMENT '模板ID(对应ZYYZModelMain里的ID)',
    YZNO         INT         COMMENT '医嘱序号(对应表ZYZYRec里的YZNo字段)',
    YZFAREID     INT         COMMENT '医嘱费用流水号(由序列SEQ_ZYYZFareID生成)',
    FARETYPE     INT         NOT NULL COMMENT '费用类型(1：西药；2：中成药；3：草药；4：诊疗项目)',
    FARECODE     VARCHAR(30)       NULL COMMENT '费用编码(如果FareType为1、2、3，则该字段对应【his.药品字典表】里的【药品编码】字段；否则该字段对应【his.项目表】里的【项目编码】字段)',
    FLAG         INT             NULL COMMENT '项目标志(0：药品；1：费用)',
    FAREITEMNAME VARCHAR(200)  NOT NULL COMMENT '费用项目名称',
    FAREKIND     INT         NOT NULL COMMENT '费用类别ID(对应【his.费用类别表】里的ID字段)',
    QUANTITY     INT         NOT NULL COMMENT '数量',
    PRICE        INT         NOT NULL COMMENT '单价',
    SPEC         VARCHAR(500)      NULL COMMENT '规格',
    JX           VARCHAR(50)       NULL COMMENT '剂型',
    UNITID       INT             NULL COMMENT '单位编码(对应项目单位表里的编号)',
    DICT_JLXS    INT             NULL COMMENT '住院计量系数',
    YPLJ         INT             NULL COMMENT '药品零价',
    DBID         VARCHAR(30)      NULL COMMENT '打包项目ID',
    DBNAMES      VARCHAR(100)      NULL COMMENT '打包名称',
    RECVDEPTID   INT             NULL COMMENT '接单科室ID',
    MSINGLENUM   INT             NULL COMMENT '单次量',
    SPECIALUSES  VARCHAR(500)      NULL COMMENT '特殊用法（中药）'
)
COMMENT '住院医嘱模板费用细表(记录医嘱模板里每条医嘱的费用记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZMODELMAIN
(
    CHOSCODE     VARCHAR(20)             PRIMARY KEY COMMENT '医疗机构编码',
    MODELID      INT                   COMMENT '住院医嘱模板ID(由序列SEQ_MZYZModelID生成)',
    VIRTUE       INT                   NOT NULL COMMENT '医嘱分类(1：长期医嘱；2：临时医嘱；3：出院医嘱；4：麻醉医嘱)',
    NAME         VARCHAR(50)             NOT NULL COMMENT '模板名称',
    PYCODE       VARCHAR(10)                 NULL COMMENT '拼音码',
    WBCODE       VARCHAR(10)                 NULL COMMENT '五笔码',
    DEPTID       INT                       NULL COMMENT '所属科室(0表示全院使用)',
    DISEASENAME  VARCHAR(100)                NULL COMMENT '所属疾病名称',
    MEMO         VARCHAR(100)                NULL COMMENT '备注',
    USEPLACE     INT DEFAULT 1         NOT NULL COMMENT '使用范围(1：本人；2：本科；3：全院)',
    OPERATORID   INT                   NOT NULL COMMENT '操作员ID(对应【his.用户表】里ID字段)',
    OPERATORNAME VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    RECDATE      DATE               NOT NULL COMMENT '记录时间',
    IFUSE        INT DEFAULT 1         COMMENT '是否使用'
)
COMMENT '住院医嘱模板主表(医嘱模板的主项记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZOPERATEREC
(
    CHOSCODE    VARCHAR(20)             PRIMARY KEY COMMENT '医疗机构编码',
    SICKCODE    VARCHAR(20)             COMMENT '住院号',
    VIRTUE      INT DEFAULT 0         COMMENT '医嘱分类(1：长期医嘱；2：临时医嘱；3：出院医嘱；4：麻醉医嘱)',
    YZNO        INT                   COMMENT '医嘱序号',
    YZOPFLOWNO  INT                   COMMENT '操作流水号(同一条医嘱从1开始)',
    OPERATETIME DATE                     NOT NULL COMMENT '操作时间',
    OPERATOR    VARCHAR(20)                 NULL COMMENT '操作人',
    OPERATORID  INT                       NULL COMMENT '操作人ID',
    OPTYPE      INT                   NOT NULL COMMENT '操作类型(1：发送；2：暂停；3：停止；4：作废；5：暂停恢复；6：停止恢复；7：作废恢复；8：执行)',
    RECDATE     DATE               NOT NULL COMMENT '记录时间',
    PERFORMNO   INT                   NOT NULL COMMENT '如果操作类型是执行(8)，对应ZYYZPerformMain表里医嘱的执行流水号'
)
COMMENT '住院医嘱操作记录(记录每次医嘱的发送、暂停、暂停恢复、停止、恢复停止、作废、恢复作废等的操作记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZPERFORMFARE
(
    CHOSCODE       VARCHAR(20)       PRIMARY KEY COMMENT '医疗机构编码',
    SICKCODE       VARCHAR(20)       COMMENT '住院号',
    YZNO           INT             COMMENT '医嘱序号',
    PERFORMNO      INT             COMMENT '执行流水号(由序列SEQ_YZPerformNo生成)',
    PERFORMINDEX   INT DEFAULT 1   COMMENT '执行序号(同一个执行流水号、同一条医嘱记录从1开始计数)',
    VIRTUE         INT DEFAULT 0   COMMENT '医嘱分类(0：长期医嘱；1：临时医嘱；2：出院医嘱；3：麻醉医嘱)',
    FARETIME       DATE                   NULL COMMENT '计费时间',
    FAREOPERAATOR  VARCHAR(20)           NULL COMMENT '操作员姓名',
    FAREOPERATORID INT                 NULL COMMENT '操作员ID',
    FAREFLOWNO     VARCHAR(50)       COMMENT '对应费用表编码(对应住院处方明细表里的处方号)',
    FAREMONEY      INT                 NULL COMMENT '计费金额',
    YZFAREID       INT             NOT NULL COMMENT '对应表ZYYZFareRec里的医嘱费用流水号'
)
COMMENT '住院医嘱执行费用记录表(记录每次医嘱执行记录对应的计费记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZPERFORMMAIN
(
    CHOSCODE    VARCHAR(20)       PRIMARY KEY COMMENT '医疗机构编码',
    PERFORMNO   INT             COMMENT '执行流水号(由序列SEQ_YZPerformNo生成)',
    BEGINDATE   DATE                   NULL COMMENT '开始时间',
    ENDDATE     DATE                   NULL COMMENT '结束时间',
    VIRTUE      INT DEFAULT 0   COMMENT '医嘱范围(0：全部；1：长期医嘱；2：临时医嘱)',
    TOTALMONEY  INT                 NULL COMMENT '总金额',
    OPERATETIME DATE                   NULL COMMENT '操作时间',
    OPERATOR    VARCHAR(20)           NULL COMMENT '操作人',
    OPERATORID  INT                 NULL COMMENT '操作人ID',
    REMARK      VARCHAR(100)          NULL COMMENT '操作说明',
    PERFORMFLAG INT DEFAULT 0   NOT NULL COMMENT '执行标志(0：未执行；1：已发药；2：已执行)',
    MEMO        VARCHAR(500)          NULL COMMENT '备注',
    SENDID      INT                 NULL COMMENT '对应摆药ID(如果是针对药房的摆药记录，则对应摆药主表的摆药ID)'
)
COMMENT '住院医嘱执行记录主表' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZPERFORMREC
(
    CHOSCODE          VARCHAR(20)       PRIMARY KEY COMMENT '医疗机构编码',
    SICKCODE          VARCHAR(20)       COMMENT '住院号',
    YZNO              INT             COMMENT '医嘱序号',
    PERFORMNO         INT             COMMENT '执行流水号(由序列SEQ_YZPerformNo生成)',
    PERFORMINDEX      INT DEFAULT 1   COMMENT '执行序号(同一条医嘱记录从1开始计数)',
    VIRTUE            INT DEFAULT 0   COMMENT '医嘱分类(1：长期医嘱；2：临时医嘱；3：出院医嘱；4：麻醉医嘱)',
    PLANPERFORMTIME   DATE                   NULL COMMENT '计划执行时间',
    FACTPERFORMDATE   DATE                   NULL COMMENT '实际执行时间',
    PERFORMOPERATOR   VARCHAR(20)           NULL COMMENT '实际执行人',
    PERFORMOPERATORID INT                 NULL COMMENT '实际执行人ID',
    REMARK            VARCHAR(100)          NULL COMMENT '执行说明',
    PERFORMFLAG       INT DEFAULT 0   NOT NULL COMMENT '执行标志(0：未执行；1：已发药；2：已执行)',
    MEMO              VARCHAR(500)          NULL COMMENT '备注',
    SENDID            INT                 NULL COMMENT '对应摆药ID(如果是针对药房的摆药记录，则对应摆药主表的摆药ID)',
    ZYRECIPECODE      VARCHAR(50)           NULL
)
COMMENT '住院医嘱执行记录表(记录每条医嘱每次的执行记录)' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZYYZREC
(
    CHOSCODE               VARCHAR(20)             PRIMARY KEY COMMENT '医疗机构编码',
    SICKCODE               VARCHAR(20)             COMMENT '住院号',
    VIRTUE                 INT DEFAULT 0         COMMENT '医嘱分类(1：长期医嘱；2：临时医嘱；3：出院医嘱；4：麻醉医嘱)',
    YZNO                   INT                   COMMENT '医嘱序号(产生规则：由序列SEQ_ZYYZNo生成)',
    FYZNO                  INT                   NOT NULL COMMENT '父医嘱序号(如无，则为该条医嘱的医嘱序号)',
    BABYNUM                INT DEFAULT 0         COMMENT '婴儿医嘱(0：非婴儿医嘱；1：1婴儿医嘱；2：2婴儿医嘱；3：3婴儿医嘱；4：4婴儿医嘱；5：5婴儿医嘱)',
    YZORDERNO              INT DEFAULT 1         NOT NULL COMMENT '医嘱顺序号(每个患者从1开始)',
    IFYLROUTE              INT DEFAULT 0         COMMENT '是否临床路径医嘱',
    YLROUTEID              INT DEFAULT 0         COMMENT '临床路径医嘱ID',
    YLROUTEORDER           INT                       NULL COMMENT '临床路径医嘱序号',
    ITEMTYPE               INT                   NOT NULL COMMENT '项目类型(区分药品、诊疗项目、打包、医嘱字典； 1:西药；2：中成药；3：草药；4：诊疗项目；5：打包项目；6：医嘱字典)',
    YJTYPE                 INT DEFAULT 0         NOT NULL COMMENT '医技类型(0：非医技类型；1：化验类型；2：检查类型；3：心电类型)',
    YJAPPLYID              INT                       NULL COMMENT '对应医技申请单ID',
    CHECKBODY              VARCHAR(500)                NULL COMMENT '检查部位',
    CHECKEQ                VARCHAR(50)                 NULL COMMENT '设备标识类型(如CT/MR等)',
    ITEMCODE               VARCHAR(2)              NOT NULL COMMENT '医嘱类别(对应DictYZKind字典里的ItemCode字段)',
    YZTHING                VARCHAR(800)                NULL COMMENT '医嘱内容',
    FARECODE               VARCHAR(30)                 NULL COMMENT '费用编码(如为药品医嘱，则该字段对应药品字典表里的药品编码字段，如为诊疗项目，则该字段对应项目表里的项目编码；如为打包项目，则该字典对应大诊疗项目表里RKey字段；如为医嘱字典，则该字段对应医嘱字典的医嘱字典ID)',
    ITEMNAMES              VARCHAR(800)                NULL COMMENT '对应项目名称',
    PSRESULT               VARCHAR(50)                 NULL COMMENT '皮试结果',
    PSVALUE                INT                       NULL COMMENT '皮试结果值(0：阴性；1：阳性)',
    PSOPERATOR             VARCHAR(40)                 NULL COMMENT '皮试结果录入人',
    PSRECDATE              DATE                         NULL COMMENT '皮试录入时间',
    MTOTALNUM              INT                       NULL COMMENT '药品总量(出院医嘱、临嘱及中草药(付数)用)',
    MTOTALUNIT             VARCHAR(50)                 NULL COMMENT '总量单位(住院单位)(出院医嘱用)',
    MSINGLENUM             INT                       NULL COMMENT '药品单次用量(如为药品医嘱，该字段不为空)',
    MEASUREUNIT            VARCHAR(50)                 NULL COMMENT '计量单位',
    GYCODE                 VARCHAR(4)                  NULL COMMENT '给药途径编码(对应DictGYTJ里ItemCode字段)',
    STATUS                 INT DEFAULT 0         NOT NULL COMMENT '状态
-1             疑问医嘱(护士审核时有疑问的医嘱)
0	新开医嘱
1	医生发送医嘱
2	护士已审核
3              护士已发送
4	医生停止
5	护士停止
6	已执行
7	医生作废
8	护士作废
9	暂停状态',
    PLCODE                 VARCHAR(2)                  NULL COMMENT '医嘱频率编码(对应DictYZFrequence里的ItemCode字段)',
    PLNAME                 VARCHAR(30)                 NULL COMMENT '医嘱频率名称(对应表DictYZFrequence医嘱频率字典里的ItemName字段)',
    PLSPACE                INT                       NULL COMMENT '间隔数量',
    SPACEUNIT              VARCHAR(10)                 NULL COMMENT '间隔单位',
    PLTIMES                INT                       NULL COMMENT '间隔单位执行次数',
    SENDDEPTID             INT                       NULL COMMENT '开医嘱科室代码(对应his.科室表里的ID字段)',
    RECVDEPTID             INT                       NULL COMMENT '执行科室代码(对应his.科室表里的ID字段)',
    KDOCTORID              INT                   NOT NULL COMMENT '开医嘱医生ID(对应his.医生表里的ID字段)',
    KDOCTORNAME            VARCHAR(20)             NOT NULL COMMENT '开医嘱医生ID',
    KDATE                  DATE                     NOT NULL COMMENT '开医嘱时间(表示医嘱开始生效的时间)',
    SHDOCTORID             INT                       NULL COMMENT '审核医嘱医生ID(对应his.医生表里的ID字段)',
    SHDOCTORNAME           VARCHAR(20)                 NULL COMMENT '审核医嘱医生ID',
    SHDATE                 DATE                         NULL COMMENT '审核医嘱时间(表示医嘱开始生效的时间)',
    CHECKNURSE             VARCHAR(20)                 NULL COMMENT '审核护士',
    CHECKNURSEID           INT                       NULL COMMENT '审核护士ID',
    CHECKTIME              DATE                         NULL COMMENT '审核时间',
    PAUSEOPERATOR          VARCHAR(20)                 NULL COMMENT '暂停操作员',
    PAUSEOPERATORID        INT                       NULL COMMENT '暂停操作员ID',
    PAUSETIME              DATE                         NULL COMMENT '暂停时间',
    PAUSEOPDATE            DATE                         NULL COMMENT '暂停操作时间',
    TDOCTORID              INT                       NULL COMMENT '作废停止医嘱医生ID(对应his.医生表里的ID字段)',
    TDOCTORNAME            VARCHAR(20)                 NULL COMMENT '作废停止医嘱医生名称',
    TDATE                  DATE                         NULL COMMENT '作废停止医嘱时间',
    TOPDATE                DATE                         NULL COMMENT '作废停止医嘱操作时间',
    YTTIME                 DATE                         NULL COMMENT '预停时间(指预停时间)',
    PRICETANG              INT DEFAULT 0         NOT NULL COMMENT '计价特性(0：正常计价；10：自带药；20：另开处方；40：不计价)',
    DOCTORZT               VARCHAR(200)                NULL COMMENT '医生嘱托',
    PERFORMDATE            VARCHAR(60)                 NULL COMMENT '执行时间',
    PRIORPRICETIME         DATE                         NULL COMMENT '选择执行时间',
    PRIORPERFORMTIME       DATE                         NULL COMMENT '执行时间',
    PRIORPERFORMOPERATOR   VARCHAR(20)                 NULL COMMENT '上次执行人',
    PRIORPERFORMOPERATORID INT                       NULL COMMENT '上次执行人ID',
    NEXTPERFORMTIME        DATE                         NULL COMMENT '下次执行时间',
    OPERATORID             INT                   NOT NULL COMMENT '操作员ID(对应表his.用户表里ID字段)',
    OPERATORNAME           VARCHAR(20)             NOT NULL COMMENT '操作员姓名',
    RECDATE                DATE               COMMENT '录入时间(医生录入医嘱的时间)',
    PERFORMNUM             INT DEFAULT 0         NOT NULL COMMENT '需执行次数(出院医嘱用)(在护士首次执行时，进行确认输入)',
    IFJJ                   INT DEFAULT 0         NOT NULL COMMENT '是否加急医嘱(临时医嘱用)(0：普通医嘱；1：加急医嘱)',
    IFDISPART              INT                       NULL COMMENT '撤分标志(针对药品医嘱的撤分标志)',
    TSYF                   VARCHAR(500)                NULL COMMENT '特殊用法',
    CZYZKIND               VARCHAR(10)                 NULL COMMENT '重整医嘱类别(如果该条医嘱是重整医嘱，则该值为重整类别代码)',
    IFFIRSTALL             INT DEFAULT 0         NOT NULL COMMENT '首次计算全天',
    IFHZ                   INT DEFAULT 0         NOT NULL COMMENT '是否会诊医嘱(0：否；1：是；2：会诊中；3：会诊结束)',
    IFPS                   INT DEFAULT 0         NOT NULL COMMENT '是否需要皮试',
    CZYZNO                 INT                       NULL COMMENT '对应重整医嘱序号(如果医嘱是被重整时停止，则填入重整医嘱的医嘱序号)',
    IFZT                   INT DEFAULT 0         NOT NULL COMMENT '是否嘱托(0：否；1：是)，为嘱托时，随意录入医嘱内容，且不产生费用记录',
    PERFORMSTATUS          INT                       NULL COMMENT '执行状态(0：未完成；1：已完成)',
    TNURSEID               INT                       NULL,
    TNURSENAME             VARCHAR(20)                 NULL,
    TNURSEOPDATE           DATE                         NULL,
    RECVDEPTFLAG           INT                       NULL COMMENT '0,不定;1,患者科室;2,开单科室;3,检验科室;4,检查科室;5,放射科室;6,药品科室;7,指定科室(RECVDEPTID)',
    PSDATE                 DATE                         NULL COMMENT '皮试执行时间',
    BBCJSTA                VARCHAR(2) DEFAULT '0'  COMMENT '标本采集状态0未采集1已采集',
    BBCJNURSENAME          VARCHAR(20)                 NULL COMMENT '标本采集护士姓名',
    BBCJNURSEID            VARCHAR(20)                 NULL COMMENT '标本采集护士ID',
    BBCJDATE               DATE                         NULL COMMENT '标本采集时间',
    CZYZDATE               DATE                         NULL COMMENT '重整医嘱时间',
    IFPRINT                VARCHAR(2) DEFAULT '0'  COMMENT '是否已打印(0否1是)'
)
COMMENT '住院医嘱记录表(患者的医嘱记录)
' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZY_ELECTRONIC_INVOICE
(
    ID              VARCHAR(22)            NOT NULL COMMENT '编码主键',
    JS_ID           INT                   NOT NULL COMMENT '住院结算表（结算流水号）',
    HOSPITAL_CODE   VARCHAR(20)             NOT NULL COMMENT '机构编码',
    BATCH_CODE      VARCHAR(50)                 NULL COMMENT '电子票据代码',
    NO              VARCHAR(20)                 NULL COMMENT '电子票据号码',
    CHECK_CODE      VARCHAR(20)                 NULL COMMENT '电子校验码',
    CREATE_TIME     VARCHAR(20)                 NULL COMMENT '电子票据生成时间',
    QRCODE_PATH     VARCHAR(200)               NULL COMMENT '电子票据二维码访问路径',
    PICTURE_URL     VARCHAR(200)              NULL COMMENT '电子票据页面URL',
    PICTURE_NET_URL VARCHAR(200)              NULL COMMENT '电子票据外网页面URL',
    RECORD_TIME     DATE               NOT NULL COMMENT '记录日期',
    CREATE_USER     VARCHAR(20)            NOT NULL COMMENT '创建人',
    STATUS          INT DEFAULT 1         NOT NULL COMMENT '1 正常  0 作废',
    QRCODE          BIT                         NULL COMMENT '电子票据二维图片'
)
COMMENT '门诊电子发票' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZY_FARE_OTHER
(
    ID            VARCHAR(22)  PRIMARY KEY COMMENT '编码(UUID)',
    HOSPITAL_CODE VARCHAR(20)  NULL COMMENT '机构编码',
    PATIENT_CODE  VARCHAR(20)  NULL COMMENT '患者编码(住院号)',
    PAY_TYPE      VARCHAR(3)   NULL COMMENT '收款方式(gy_paytype)',
    CHARGE_TYPE   VARCHAR(3)   NULL COMMENT '收款类型(1:生活费 9:其他费)',
    DAY_TOTAL     INT         NULL COMMENT '当日总金额',
    CHARGE_DAY    VARCHAR(10)  NULL COMMENT '时间(yyyy-MM-dd)',
    CREATE_DATE   DATE           NULL COMMENT '创建时间',
    CREATE_USER   VARCHAR(10)  NULL COMMENT '创建操作员',
    MODIFIED_USER VARCHAR(20)  NULL COMMENT '修改操作员',
    MODIFIED_DATE DATE           NULL COMMENT '修改时间'
)
COMMENT '住院其他费用' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZY_PATIENT_DIP
(
    ID              VARCHAR(36)              NOT NULL COMMENT '主键ID',
    HOSP_CODE       VARCHAR(20)              NOT NULL COMMENT '机构编码',
    PATIENT_CODE    VARCHAR(20)              NOT NULL COMMENT '住院号',
    UPDATE_ID       VARCHAR(36)              NOT NULL COMMENT '上传流水号',
    OP_DATE         DATE                      NOT NULL COMMENT '操作时间',
    OP_USER_ID      VARCHAR(36)              NOT NULL COMMENT '操作用户ID',
    STATUS          VARCHAR(1)                   NULL COMMENT '状态（1 已上传 2 已撤销）',
    UPDATE_FEEDBACK VARCHAR(200)                NULL COMMENT '上传反馈',
    UPDATE_DATE     DATE                          NULL COMMENT '上传/撤销日期',
    UPDATE_STATUS   VARCHAR(10) DEFAULT '0'  COMMENT '上传质控结果（0 未查询 1 已通过 2 未通过）'
)
COMMENT '患者DIP上传信息' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE ZY_PATIENT_ZYBA
(
    ID                  VARCHAR(36)             NOT NULL COMMENT '主键ID',
    HOSP_CODE           VARCHAR(20)             NOT NULL COMMENT '机构编码',
    PATIENT_CODE        VARCHAR(20)             NOT NULL COMMENT '住院号',
    UPLOAD_ID           VARCHAR(36)                 NULL COMMENT '上传流水号',
    OP_DATE             DATE                         NULL COMMENT '操作时间',
    STATUS              VARCHAR(1) DEFAULT '0'  COMMENT '状态(0 信息维护 1 已备案 2 已撤销)',
    REFLIN_MEDINS_NO    VARCHAR(20)                 NULL COMMENT '转往定点医药机构编号',
    REFLIN_MEDINS_NAME  VARCHAR(200)                NULL COMMENT '转往医院名称',
    MDTRTAREA_ADMDVS    VARCHAR(20)                 NULL COMMENT '就医地行政区划',
    HOSP_AGRE_REFL_FLAG VARCHAR(1)                  NULL COMMENT '医院同意转院标志(0 否 1 是)',
    REFL_TYPE           VARCHAR(30)                 NULL COMMENT '转院类型',
    REFL_DATE           DATE                         NULL COMMENT '转院日期',
    REFL_REA            VARCHAR(100)                NULL COMMENT '转院原因',
    REFL_OPNN           VARCHAR(200)                NULL COMMENT '转院意见',
    BEGNDATE            DATE                         NULL COMMENT '开始日期',
    ENDDATE             DATE                         NULL COMMENT '结束日期',
    REFL_USED_FLAG      VARCHAR(10)                 NULL COMMENT '转诊使用标志',
    OP_USER_ID          VARCHAR(36)                 NULL COMMENT '操作用户ID',
    CANCEL_REASON       VARCHAR(500)                NULL COMMENT '撤销备注'
)
COMMENT '住院患者转院备案记录' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 病房表
(
    ID       INT            NOT NULL,
    病房名称     VARCHAR(30)      NOT NULL,
    所属科室     INT DEFAULT 0 ,
    CHOSCODE VARCHAR(20)          NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 财务分类表
(
    ITEMCODE CHAR(1)           NULL,
    ITEMNAME VARCHAR(20)      NULL,
    CHOSCODE VARCHAR(20)      NULL,
    FLAG     INT DEFAULT 1  COMMENT '0:药品  1:诊疗   2:通用',
    PTCODE   VARCHAR(3)       NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 采购明细
(
    CODE        VARCHAR(8)    NOT NULL,
    药品编号        VARCHAR(20)       NULL,
    数量          INT             NULL,
    金额          INT             NULL,
    生产批号        VARCHAR(15)       NULL,
    有效期至        DATE               NULL,
    单项备注        VARCHAR(50)      NULL,
    单价          INT             NULL,
    行序          INT             NULL,
    零售单价        INT             NULL,
    生产单位        VARCHAR(60)       NULL,
    药品单位        VARCHAR(5)       NULL,
    零售金额        INT             NULL,
    批准文号        VARCHAR(50)      NULL,
    CHOSCODE    VARCHAR(20)       NULL,
    单位编码        VARCHAR(5)        NULL,
    STOCKFLOWNO INT             NULL,
    产地          VARCHAR(50)       NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 采购申领
(
    CODE      VARCHAR(8)             NOT NULL,
    KIND      INT DEFAULT 0       ,
    STATUS    INT DEFAULT 0       ,
    OPERATOR  VARCHAR(20)                NULL,
    CHECKMAN  VARCHAR(20)                NULL,
    CHECKDATE DATE                        NULL,
    KFID      INT                      NULL,
    TOTALFARE INT                      NULL,
    OPDATE    DATE             ,
    NOTE      VARCHAR(100)               NULL,
    STARTDT   DATE                        NULL,
    ENDDT     DATE                        NULL,
    CHOSCODE  VARCHAR(20)                NULL,
    YFID      INT                      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 出库单
(
    单据编号     VARCHAR(12)            NOT NULL,
    过单日期     DATE             ,
    出库方式     VARCHAR(10)                NULL,
    备注       VARCHAR(100)              NULL,
    状态       CHAR(1)                     NULL,
    制单人      VARCHAR(20)                NULL,
    审核人      VARCHAR(20)                NULL,
    存放位置     VARCHAR(10)                NULL,
    客商单位     VARCHAR(60)                NULL,
    成本合计     INT                      NULL,
    零售合计     INT                      NULL,
    出库合计     INT                      NULL,
    CHOSCODE VARCHAR(20)                NULL,
    出库科室     INT                      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 出库数据
(
    单据编号     VARCHAR(12)        NOT NULL,
    编号       VARCHAR(20)            NULL,
    数量       INT                  NULL,
    金额       INT                  NULL,
    生产批号     VARCHAR(20)            NULL,
    单项备注     VARCHAR(100)          NULL,
    单价       INT                  NULL,
    行序       INT                  NULL,
    药品成本价    INT                  NULL,
    药品零售价    INT                  NULL,
    库存流水     INT                  NULL,
    药品单位     VARCHAR(50)            NULL,
    库存余量     INT                  NULL,
    生产单位     VARCHAR(60)            NULL,
    单位编码     VARCHAR(20)            NULL,
    有效期至     DATE                    NULL,
    CHOSCODE VARCHAR(20)            NULL,
    零售金额     INT DEFAULT (0) ,
    产地       VARCHAR(50)            NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 床位表
(
    ID       INT             NOT NULL,
    床位名称     VARCHAR(50)       NOT NULL,
    所在病房     INT                 NULL,
    状态       INT DEFAULT 0   NOT NULL,
    住院号      VARCHAR(20)           NULL,
    CHOSCODE VARCHAR(20)           NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 大诊疗项目表
(
    RKEY         INT              PRIMARY KEY,
    大诊疗项目名       VARCHAR(100)       NOT NULL,
    CHOSCODE     VARCHAR(20)            NULL,
    PYCODE       VARCHAR(50)            NULL,
    RECVDEPT     INT                  NULL,
    费用归类         INT DEFAULT (0) ,
    显示包名         INT DEFAULT (0) ,
    NOTE         VARCHAR(200)           NULL,
    编码           VARCHAR(10)            NULL,
    ORDID        INT                  NULL,
    财务编码         CHAR(1)                 NULL,
    住院显示包名       INT DEFAULT 0   ,
    检查类型         VARCHAR(8)             NULL,
    检查检验部位       VARCHAR(20)            NULL,
    WBCODE       VARCHAR(50)            NULL COMMENT '五笔码',
    LISEQUIPMENT VARCHAR(50)            NULL COMMENT 'lis设备'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 大诊疗项目明细表
(
    大诊疗项目ID INT            NOT NULL,
    项目编码    VARCHAR(20)          NULL,
    数量      INT DEFAULT 1  COMMENT '各个诊疗项目打包数量'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 待发药表
(
    业务类别     VARCHAR(20)      NULL COMMENT '区分门诊发药和住院发药',
    领药编号     VARCHAR(20)      NULL COMMENT '门诊用处方号,住院用住院号',
    病人姓名     VARCHAR(50)      NULL,
    药品编码     VARCHAR(20)      NULL,
    领药数量     INT DEFAULT 0 ,
    登记号      VARCHAR(20)      NULL,
    CHOSCODE VARCHAR(20)      NULL,
    执行序号     INT            NULL COMMENT '医嘱执行的序号',
    药房ID     INT            NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 电子处方表
(
    MCODE    VARCHAR(20)              PRIMARY KEY,
    姓名       VARCHAR(50)              NOT NULL,
    拼音码      VARCHAR(15)                  NULL,
    性别       VARCHAR(4)                   NULL,
    出生日期     DATE                          NULL,
    住址       VARCHAR(100)                 NULL,
    医疗证号     VARCHAR(50)                  NULL,
    个人编码     VARCHAR(50)                  NULL,
    就诊卡号     VARCHAR(20)                  NULL,
    病人类型     INT                    NOT NULL,
    开单医生ID   VARCHAR(20)                  NULL,
    开单医生     VARCHAR(20)                  NULL,
    开单科室     VARCHAR(20)                  NULL,
    接单医生ID   VARCHAR(20)                  NULL,
    接单医生     VARCHAR(20)                  NULL,
    接单科室     VARCHAR(20)                  NULL,
    疾病编码     VARCHAR(20)                  NULL,
    疾病名称     VARCHAR(80)                  NULL,
    药房ID     INT DEFAULT (0)       ,
    总费用      INT DEFAULT (0)       ,
    门诊类型     VARCHAR(2)                   NULL,
    就诊状态     INT                        NULL,
    是否提高     INT DEFAULT (0)       ,
    输液次数     INT DEFAULT (0)       ,
    状态       INT DEFAULT (0)        COMMENT '0:未收费  1:已收费',
    RECDATE  DATE  ,
    收费时间     DATE                          NULL,
    操作员      VARCHAR(20)                  NULL,
    CHOSCODE VARCHAR(20)             ,
    家长姓名     VARCHAR(20)                  NULL,
    职业       VARCHAR(30)                  NULL,
    初诊       INT                        NULL,
    发病日期     VARCHAR(10)                  NULL,
    处理       VARCHAR(80)                  NULL,
    备注       VARCHAR(80)                  NULL,
    联系电话     VARCHAR(20)                  NULL,
    症状       VARCHAR(50)                  NULL,
    收费处方号    VARCHAR(20)                  NULL,
    门诊号      VARCHAR(20)                  NULL,
    付        INT DEFAULT 1         ,
    KIND     INT DEFAULT 0          COMMENT '处方类型 0:一般  1:中药处方',
    处方类型     INT DEFAULT 0          COMMENT '0:普通处方  1:急诊处方   2:儿科处方   3:麻、精一处方     4:精二处方',
    其他诊断     VARCHAR(80)                  NULL,
    中医诊断     VARCHAR(80)                  NULL,
    证件号码     VARCHAR(20)                  NULL,
    血压       VARCHAR(30)                  NULL,
    血糖       VARCHAR(30)                  NULL,
    身高体重     VARCHAR(20)                  NULL,
    个性化健康教育  VARCHAR(50)                  NULL,
    登记号      VARCHAR(50)                  NULL COMMENT '与就诊登记信息表对应',
    体温       VARCHAR(10)                  NULL,
    开单科室ID   VARCHAR(20)                  NULL COMMENT '开单科室编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 电子处方费用表
(
    MCODE              VARCHAR(20)   NOT NULL,
    标志                 INT             NULL,
    编码                 VARCHAR(30)       NULL,
    名称                 VARCHAR(100)      NULL,
    规格                 VARCHAR(500)      NULL,
    单位                 VARCHAR(20)       NULL,
    数量                 FLOAT              NULL,
    价格                 INT             NULL,
    金额                 INT             NULL,
    费用类别               VARCHAR(20)       NULL,
    农合名称               VARCHAR(100)      NULL,
    农合编码               VARCHAR(20)       NULL,
    剂型                 VARCHAR(20)       NULL,
    核算科室               INT             NULL,
    执行单价               INT             NULL,
    处方科室               INT             NULL,
    处方医生               VARCHAR(20)       NULL,
    CHOSCODE           VARCHAR(20)       NULL,
    频次                 VARCHAR(20)       NULL,
    用法                 VARCHAR(20)       NULL,
    用量                 VARCHAR(30)       NULL,
    打包名                VARCHAR(80)       NULL,
    DBID               INT             NULL,
    组号                 VARCHAR(20)       NULL,
    医嘱编号               VARCHAR(50)       NULL,
    付                  VARCHAR(2)        NULL,
    药品辅助编码             VARCHAR(20)       NULL,
    ITEM_SERIAL_NUMBER VARCHAR(50)       NULL COMMENT '项目流水号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 调拨单
(
    单据编号     VARCHAR(20)      PRIMARY KEY,
    过单日期     DATE              NULL,
    调拨方式     VARCHAR(50)      NULL,
    备注       VARCHAR(100)     NULL,
    状态       CHAR(1)           NULL,
    制单人      VARCHAR(20)      NULL,
    审核人      VARCHAR(20)      NULL,
    调往药房     VARCHAR(20)      NULL,
    调出药库     VARCHAR(20)      NULL,
    客商单位     VARCHAR(20)      NULL,
    成本合计     INT            NULL,
    零售合计     INT            NULL,
    出库合计     INT            NULL,
    CHOSCODE VARCHAR(20)      ,
    TYPE     INT DEFAULT 0  COMMENT '调拨类型（0  药库调拨   1  药房申领  ）',
    RECDATE  DATE              NULL COMMENT '记录日期'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 调拨数据
(
    单据编号     VARCHAR(20)    NOT NULL,
    编号       VARCHAR(20)        NULL,
    数量       INT              NULL,
    金额       INT              NULL,
    生产批号     VARCHAR(20)        NULL,
    单项备注     VARCHAR(100)      NULL,
    单价       INT              NULL,
    行序       INT              NULL,
    药品成本价    INT              NULL,
    药品零售价    INT              NULL,
    库存流水     INT              NULL,
    药品单位     VARCHAR(20)        NULL,
    库存余量     INT              NULL,
    生产单位     VARCHAR(60)        NULL,
    单位编码     VARCHAR(20)        NULL,
    有效期至     DATE                NULL,
    CHOSCODE VARCHAR(20)        NULL,
    药房库存流水   INT              NULL,
    条码号      VARCHAR(20)        NULL,
    产地       VARCHAR(50)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 调价单
(
    单据编号     VARCHAR(20)    NOT NULL,
    过单日期     DATE                NULL,
    调价原因     VARCHAR(50)        NULL,
    备注       VARCHAR(100)      NULL,
    状态       CHAR(1)             NULL,
    合计数量     INT              NULL,
    合计金额     INT              NULL,
    制单人      VARCHAR(20)        NULL,
    审核人      VARCHAR(20)        NULL,
    存放位置     VARCHAR(50)        NULL,
    客商单位     VARCHAR(50)        NULL,
    CHOSCODE VARCHAR(20)        NULL,
    RECDATE  DATE                NULL COMMENT '记录日期'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 调价数据
(
    单据编号     VARCHAR(20)    NOT NULL,
    编号       VARCHAR(20)        NULL,
    数量       INT              NULL,
    生产批号     VARCHAR(20)        NULL,
    单项备注     VARCHAR(100)      NULL,
    原单价      INT              NULL,
    现单价      INT              NULL,
    行序       INT              NULL,
    库存流水     INT              NULL,
    有效期至     DATE                NULL,
    单位编码     VARCHAR(20)        NULL,
    CHOSCODE VARCHAR(20)        NULL,
    产地       VARCHAR(50)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 费用类别表
(
    ID           INT              NOT NULL,
    类别名称         VARCHAR(50)        NOT NULL,
    农合编码         VARCHAR(20)            NULL,
    农合名称         VARCHAR(100)           NULL,
    CHOSCODE     VARCHAR(20)            NULL,
    FLAG         INT DEFAULT (1)  COMMENT '0:药品  1:诊疗   2:通用',
    PYCODE       VARCHAR(20)            NULL COMMENT '拼音码',
    KIND         INT DEFAULT 0    COMMENT '分类 0:未定义  1:检查类  2:检验类',
    对应财务码        CHAR(1)                 NULL,
    WBCODE       VARCHAR(20)            NULL COMMENT '五笔码',
    YB_COST_CODE VARCHAR(20)            NULL COMMENT '医保费用编码',
    YB_COST_NAME VARCHAR(100)           NULL COMMENT '医保费用名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 供货单位
(
    编号       VARCHAR(10)    NOT NULL,
    客商类型     VARCHAR(8)        NULL,
    名称       VARCHAR(60)       NULL,
    信誉额度     INT              NULL,
    法人代表     VARCHAR(30)       NULL,
    联系人      VARCHAR(30)       NULL,
    移动电话     VARCHAR(20)       NULL,
    五笔简码     VARCHAR(15)        NULL,
    拼音简码     VARCHAR(25)       NULL,
    联系地址     VARCHAR(60)       NULL,
    邮政编码     VARCHAR(8)        NULL,
    电话       VARCHAR(20)       NULL,
    传真       VARCHAR(20)       NULL,
    营业执照     VARCHAR(50)       NULL,
    税号       VARCHAR(20)       NULL,
    开户银行     VARCHAR(50)       NULL,
    银行帐号     VARCHAR(50)       NULL,
    机构代码     VARCHAR(50)       NULL,
    证书编号     VARCHAR(50)       NULL,
    执行许可证    VARCHAR(50)       NULL,
    生产许可证    VARCHAR(50)       NULL,
    经营许可证    VARCHAR(50)       NULL,
    经营范围     VARCHAR(200)      NULL,
    备注       VARCHAR(200)      NULL,
    编码       VARCHAR(20)        NULL,
    应付金额     INT              NULL,
    许可证有效期   DATE                NULL,
    有效状态     VARCHAR(2)        NULL,
    期初应付     INT              NULL,
    分类码      VARCHAR(15)        NULL,
    同步序号     INT              NULL,
    CHOSCODE VARCHAR(20)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 汇总处方表
(
    CID      INT                  NULL,
    汇总人      VARCHAR(20)            NULL,
    汇总时间     DATE             ,
    汇总数      INT                  NULL,
    处方号      VARCHAR(200)          NULL,
    发药人      VARCHAR(20)            NULL,
    发药时间     DATE                    NULL,
    CHOSCODE VARCHAR(20)            NULL,
    药房       VARCHAR(10)            NULL,
    入院科室     INT                  NULL,
    KIND     INT DEFAULT (0)
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 结算冲销记录表
(
    CHOSCODE   VARCHAR(20)            NULL,
    住院号        VARCHAR(20)            NULL,
    结算流水号      INT                  NULL,
    OPDATE     DATE              COMMENT '操作时间',
    OPERATORID INT                  NULL COMMENT '操作员',
    金额         INT                  NULL,
    医保结算编号     VARCHAR(50)            NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 科室表
(
    ID       INT                  NOT NULL,
    名称       VARCHAR(50)            NOT NULL,
    类别       VARCHAR(50)                NULL,
    上级科室     INT                      NULL,
    级别       INT DEFAULT -1       COMMENT '0为最高,依次往下,可无限分级',
    代码       VARCHAR(20)                NULL COMMENT '拼音码',
    农合编码     VARCHAR(20)                NULL,
    农合名称     VARCHAR(50)                NULL,
    CHOSCODE VARCHAR(20)                NULL,
    USEPLACE INT DEFAULT 0        COMMENT '使用场合(0:共用  1:门诊使用   2:住院使用 3:药房使用 4:库房使用 )',
    FLAG     INT DEFAULT (0)      COMMENT '标志(0:医嘱执行只允许本科 9:全院患者科室)',
    开单       INT DEFAULT 0       ,
    接单       INT DEFAULT 0       ,
    医技       INT DEFAULT 0       ,
    PTCODE   VARCHAR(20)                NULL COMMENT '万达平台编码',
    RECDATE  DATE             ,
    检索码      VARCHAR(8)                 NULL,
    IFUSE    INT DEFAULT 1       ,
    备注       VARCHAR(200)               NULL,
    排序号      INT                      NULL,
    BACODE   VARCHAR(10)                NULL,
    YBCODE   VARCHAR(20)                NULL,
    负责人      VARCHAR(30)                NULL,
    电话       VARCHAR(20)                NULL,
    市医保编码    VARCHAR(200)               NULL,
    市医保名称    VARCHAR(200)               NULL,
    WBCOD    VARCHAR(20)                NULL COMMENT '五笔码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 可操作库房
(
    USERID   INT        PRIMARY KEY,
    KFID     INT        ,
    CHOSCODE VARCHAR(20)
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 库存药品
(
    药品编号     VARCHAR(20)           NULL,
    仓库编号     VARCHAR(8)            NULL,
    生产批号     VARCHAR(15)           NULL,
    有效期至     DATE                   NULL,
    库存数量     INT DEFAULT 0   NOT NULL,
    库存总额     INT DEFAULT 0  ,
    零售单价     INT DEFAULT 0  ,
    库存成本     INT DEFAULT 0  ,
    会员单价     INT                 NULL,
    生产单位     VARCHAR(60)           NULL,
    库存流水     INT             NOT NULL,
    入库单号     VARCHAR(12)           NULL,
    单项备注     VARCHAR(50)          NULL,
    供货单位     VARCHAR(60)           NULL,
    冻结数量     INT DEFAULT 0   NOT NULL,
    CHOSCODE VARCHAR(20)           NULL,
    批准文号     VARCHAR(128)          NULL,
    条码号      VARCHAR(20)           NULL,
    RKCODE   VARCHAR(20)           NULL,
    修改日志     VARCHAR(200)          NULL,
    生产日期     DATE                   NULL,
    产地       VARCHAR(50)           NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 零售调价单
(
    单据编号     VARCHAR(12)   NOT NULL,
    过单日期     DATE               NULL,
    调价原因     VARCHAR(50)       NULL,
    备注       VARCHAR(100)      NULL,
    状态       CHAR(1)            NULL,
    合计数量     INT             NULL,
    合计金额     INT             NULL,
    制单人      VARCHAR(20)       NULL,
    审核人      VARCHAR(20)       NULL,
    存放位置     INT             NULL,
    客商单位     VARCHAR(50)       NULL,
    CHOSCODE VARCHAR(20)       NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 零售调价数据
(
    单据编号     VARCHAR(12)    NOT NULL,
    编号       VARCHAR(20)        NULL,
    数量       INT              NULL,
    生产批号     VARCHAR(15)        NULL,
    单项备注     VARCHAR(100)      NULL,
    原单价      INT              NULL,
    现单价      INT              NULL,
    行序       INT              NULL,
    库存流水     INT              NULL,
    有效期至     DATE                NULL,
    单位编码     VARCHAR(20)        NULL,
    CHOSCODE VARCHAR(20)        NULL,
    产地       VARCHAR(50)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 门诊处方表
(
    处方号               VARCHAR(20)                   NULL,
    病人姓名              VARCHAR(50)               NOT NULL,
    病人性别              VARCHAR(4)                    NULL,
    病人年龄              VARCHAR(16)                   NULL,
    处方科室              VARCHAR(20)                   NULL,
    处方医生              INT                     NOT NULL,
    处方日期              DATE  NOT NULL,
    总金额               INT DEFAULT 0          ,
    是否发药              INT DEFAULT 0          ,
    是否结算              INT DEFAULT 0          ,
    处方状态              INT                         NULL COMMENT '1:正常  2:作废  3:未发药退费',
    操作员               VARCHAR(20)                   NULL,
    冲红处方号             VARCHAR(20)                   NULL,
    退药标志              INT DEFAULT 0          ,
    农合医疗证号            VARCHAR(50)                   NULL,
    病人类型              INT                         NULL,
    上传标志              CHAR(1)                        NULL,
    个人编码              VARCHAR(50)                   NULL,
    疾病编码              VARCHAR(20)                   NULL,
    疾病名称              VARCHAR(100)                  NULL,
    农合门诊编号            VARCHAR(32)                   NULL,
    药房                INT                         NULL,
    药品处方号             VARCHAR(35)                   NULL,
    实收金额              INT                         NULL,
    挂账金额              INT                         NULL,
    执行金额              INT                         NULL,
    CHOSCODE          VARCHAR(20)                   NULL,
    农合报销              INT DEFAULT 0           COMMENT '医保报销总费用（基本统筹+账户支付+大额统筹+其他报销+公务员补助）',
    接单医生              VARCHAR(20)                   NULL,
    接单科室              VARCHAR(20)                   NULL,
    账户支付              INT DEFAULT 0          ,
    基本统筹              INT DEFAULT 0          ,
    大额统筹              INT DEFAULT 0          ,
    其他报销              INT DEFAULT 0          ,
    公务员补助             INT DEFAULT 0          ,
    保内                INT DEFAULT 0          ,
    保外                INT DEFAULT 0          ,
    门诊号               VARCHAR(30)                   NULL,
    优惠减免              INT DEFAULT 0          ,
    发票号               VARCHAR(200)                  NULL,
    就诊卡号              VARCHAR(50)                   NULL,
    是否提高              INT DEFAULT 0          ,
    是否输液              INT DEFAULT 0          ,
    下家庭账户             INT DEFAULT 1          ,
    RECDATE           DATE  NOT NULL,
    发药人               VARCHAR(20)                   NULL,
    发药时间              DATE                           NULL,
    付                 INT DEFAULT 1          ,
    KIND              INT DEFAULT 0           COMMENT '处方类型 0:一般  1:中药处方',
    中心编号              VARCHAR(20)                   NULL COMMENT '医保使用',
    支付类别              VARCHAR(20)                   NULL COMMENT '医保使用(gy_djlx和门诊登记信息的REGKIND一样)',
    保险办法              VARCHAR(20)                   NULL COMMENT '医保使用',
    地址                VARCHAR(200)                  NULL,
    PYCODE            VARCHAR(20)                   NULL,
    备注                VARCHAR(100)                  NULL,
    CODE              VARCHAR(30)                   NULL,
    支票                INT DEFAULT 0          ,
    收费方式              INT                         NULL COMMENT 'gy_paytype的PAYCODE',
    证件号码              VARCHAR(20)                   NULL,
    联系电话              VARCHAR(20)                   NULL,
    日结序号              INT                         NULL,
    YBNHDATA          VARCHAR(200)                  NULL COMMENT '农合医保必须保存的数据 多项用‘|’分割',
    数字指纹              VARCHAR(100)                  NULL,
    处方来源              INT                         NULL COMMENT '0 手工收费  1 处方收费  2  药房划价 3  挂号',
    就诊状态              INT                         NULL,
    其他疾病编码            VARCHAR(20)                   NULL,
    其他疾病名称            VARCHAR(50)                   NULL,
    家庭医生优惠            INT                         NULL COMMENT '武汉家庭医生签约优惠',
    出生日期              DATE                           NULL COMMENT '生日',
    门诊类型              VARCHAR(20)                   NULL,
    CHRONIC_DISE_CODE VARCHAR(50)                  NULL COMMENT '慢特病编码',
    CHRONIC_DISE_NAME VARCHAR(500)                 NULL COMMENT '慢特病名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 门诊处方明细表
(
    自动编码               INT                    NOT NULL,
    处方号                VARCHAR(30)              NOT NULL,
    标志                 INT                        NULL,
    编码                 VARCHAR(20)                  NULL,
    名称                 VARCHAR(100)                 NULL,
    规格                 VARCHAR(500)                 NULL,
    单位                 VARCHAR(20)                  NULL,
    数量                 FLOAT                         NULL,
    价格                 INT DEFAULT 0         ,
    金额                 INT DEFAULT 0         ,
    费用类别               VARCHAR(20)                  NULL,
    发药状态               INT                        NULL,
    退药数量               INT DEFAULT 0         ,
    操作员                VARCHAR(20)                  NULL,
    农合名称               VARCHAR(100)                 NULL,
    农合编码               VARCHAR(20)                  NULL,
    剂型                 VARCHAR(20)                  NULL,
    核算科室               INT                        NULL,
    执行单价               INT                        NULL,
    处方科室               INT                        NULL,
    处方医生               VARCHAR(20)                  NULL,
    处方时间               DATE ,
    CHOSCODE           VARCHAR(20)                  NULL,
    频次                 VARCHAR(20)                  NULL,
    用法                 VARCHAR(20)                  NULL,
    用量                 VARCHAR(30)                  NULL,
    打包名                VARCHAR(80)                  NULL,
    发票号                VARCHAR(12)                  NULL,
    DBID               INT                        NULL,
    优惠金额               INT                        NULL,
    付                  VARCHAR(2)                   NULL,
    状态                 VARCHAR(1)                   NULL COMMENT '费用状态空或1为正常9为已退费',
    发药人                VARCHAR(20)                  NULL,
    发药时间               DATE                          NULL,
    药房ID               INT                        NULL,
    药品辅助编码             VARCHAR(20)                  NULL,
    ITEM_SERIAL_NUMBER VARCHAR(50)                  NULL COMMENT '项目流水号'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 门诊登记信息
(
    REGCODE      VARCHAR(20)            NULL COMMENT '门诊登记号（唯一流水号）',
    NAME         VARCHAR(50)            NULL COMMENT '姓名',
    SEX          VARCHAR(4)             NULL COMMENT '性别',
    BIRTHDATE    DATE                    NULL COMMENT '出生日期',
    PYCODE       VARCHAR(10)            NULL COMMENT '拼音码',
    WBCODE       VARCHAR(10)            NULL COMMENT '五笔码',
    ADDRESS      VARCHAR(100)           NULL COMMENT '地址',
    IDENTITYID   VARCHAR(50)            NULL COMMENT '身份证号（弃用）',
    PHONE        VARCHAR(20)            NULL COMMENT '电话',
    LINKMAN      VARCHAR(20)            NULL COMMENT '联系人',
    CARDID       VARCHAR(20)            NULL COMMENT '就诊卡号',
    YBCARD       VARCHAR(50)            NULL COMMENT '医保卡号',
    PERSONCODE   VARCHAR(50)            NULL COMMENT '个人编码',
    MEDICALTYPE  INT                  NULL COMMENT '病人类型（0 自费  其他医保类型）',
    REGKIND      VARCHAR(20)            NULL COMMENT '登记类别(gy_djlx)',
    REGSTATUS    INT                  NULL COMMENT '就诊状态（字典ID=22）',
    REGFARE      INT                  NULL COMMENT '金额',
    IFRVISIT     INT DEFAULT (0)      COMMENT '复诊标志',
    RECDATE      DATE             ,
    DOCTORID     INT                  NULL COMMENT '医生ID',
    DOCTORNAME   VARCHAR(20)            NULL COMMENT '医生名称',
    DEPTID       INT                  NULL COMMENT '科室ID',
    DEPTNAME     VARCHAR(20)            NULL COMMENT '科室名称',
    OPERATORID   INT                  NULL COMMENT '操作员ID',
    OPERATORNAME VARCHAR(20)            NULL COMMENT '操作员名称',
    ICDCODE      VARCHAR(20)            NULL COMMENT '疾病编码',
    ICDNAME      VARCHAR(80)            NULL COMMENT '疾病名称',
    CFCODE       VARCHAR(20)            NULL COMMENT '对应挂号所产生的收费信息处方流水号',
    STATUS       INT DEFAULT (0)      COMMENT '挂号信息状态(0:有效 1:无效  2:作废)',
    CHOSCODE     VARCHAR(20)            NULL COMMENT '机构编码',
    YBINFO       VARCHAR(20)            NULL COMMENT '医保信息',
    PHOTO        BIT                    NULL COMMENT '照片',
    日结序号         INT                  NULL,
    CARDTYPE     INT                  NULL COMMENT '证件类型（字典表53）',
    CARDNO       VARCHAR(20)            NULL COMMENT '证件号码',
    BALANCE      INT                  NULL COMMENT '余额',
    ISMAC        INT                  NULL COMMENT '是否设备',
    AGE          VARCHAR(10)            NULL COMMENT '年龄',
    CASHFARE     INT                  NULL,
    YBNHDATA     VARCHAR(200)           NULL COMMENT '农合医保必须保存的数据 多项用‘|’分割',
    GWINFO       VARCHAR(100)           NULL COMMENT '公卫信息 接口类型 1 万达 2 晶奇 | 档案号 | 人群分类   | 随访日期 | 下次随访日期 | 管理卡id',
    YDEMPI       VARCHAR(100)           NULL COMMENT '亚德已注册的个人全局 EMPI编号',
    REGTYPE      INT                  NULL COMMENT '挂号类型（对应字典表组ID=48）',
    AGEUNIT      VARCHAR(2)             NULL COMMENT '年龄单位（字典表508）',
    ISREFERRAL   INT DEFAULT 0        COMMENT '是否转诊  1 是  0 否',
    MZHM         VARCHAR(20)            NULL COMMENT '门诊号码',
    MZQTDIAG     VARCHAR(100)           NULL COMMENT '门诊其他诊断',
    MZQTDIAGCODE VARCHAR(50)            NULL COMMENT '其他诊断编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 密码
(
    ID     INT         PRIMARY KEY,
    PASSWD VARCHAR(50)   NOT NULL,
    `RANK`   VARCHAR(100)      NULL,
    PWD    VARCHAR(50)       NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 农合疾病表
(
    RKEY       INT                   NOT NULL,
    农合编码       VARCHAR(50)                 NULL,
    农合名称       VARCHAR(200)                NULL,
    农合简写       VARCHAR(100)                NULL,
    ORDERID    INT DEFAULT 0        ,
    TYPE       INT DEFAULT 0         COMMENT '0 普通  1 慢病',
    WBCODE     VARCHAR(100)                NULL COMMENT '五笔码',
    YLLB       VARCHAR(8) DEFAULT '0'  COMMENT '医保类别  0 自费   ',
    ICD10_CODE VARCHAR(50)                 NULL COMMENT '国标编码',
    ICD10_NAME VARCHAR(200)                NULL COMMENT '国标名称'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 盘点表列表
(
    盘点序号     INT         NOT NULL,
    盘点表名称    VARCHAR(60)       NULL,
    建表时间     DATE               NULL,
    状态       VARCHAR(3)       NULL,
    建表人      VARCHAR(50)      NULL,
    合并批号     INT             NULL,
    CHOSCODE VARCHAR(20)       NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 盘点库存药品明细
(
    药品编号     VARCHAR(20)                 NULL,
    仓库编号     VARCHAR(8)                  NULL,
    生产批号     VARCHAR(15)                 NULL,
    有效期至     DATE                         NULL,
    库存数量     INT DEFAULT 0         NOT NULL,
    库存总额     INT DEFAULT 0        ,
    零售单价     INT DEFAULT 0        ,
    库存成本     INT DEFAULT 0        ,
    生产单位     VARCHAR(60)                 NULL,
    库存流水     INT                   PRIMARY KEY,
    供货单位     VARCHAR(200)                NULL,
    CHOSCODE VARCHAR(20)                 NULL,
    生成时间     DATE               ,
    盘点序号     INT                       NULL,
    产地       VARCHAR(200)                NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 盘点历史库存药品
(
    盘点序号     INT        NULL,
    药品编号     VARCHAR(8)   NULL,
    仓库编号     VARCHAR(8)   NULL,
    生产批号     VARCHAR(15)  NULL,
    库存数量     INT        NULL,
    零售单价     INT        NULL,
    库存成本     INT        NULL,
    库存流水     INT        NULL,
    生产单位     VARCHAR(60)  NULL,
    CHOSCODE VARCHAR(20)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 盘点明细表
(
    盘点序号     INT        NULL,
    仓库编号     VARCHAR(8)   NULL,
    药品编号     VARCHAR(20)  NULL,
    生产批号     VARCHAR(20)  NULL,
    备注       VARCHAR(50)  NULL,
    盈亏数量     INT        NULL,
    库存流水     INT        NULL,
    CHOSCODE VARCHAR(20)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 票据领用表
(
    领用序号     INT                  PRIMARY KEY,
    票据类型     INT                  NOT NULL COMMENT '对应字典表的dicgrpid=31',
    领用人员     INT                      NULL COMMENT '对应用户表的userid',
    领用时间     DATE             ,
    操作员      INT                      NULL COMMENT '对应用户表的userid',
    开始票号     VARCHAR(12)                NULL,
    结束票号     VARCHAR(12)                NULL,
    领用张数     INT                      NULL,
    使用模式     INT DEFAULT 0        COMMENT '0:私用   1:共用',
    剩余张数     INT                      NULL,
    CHOSCODE VARCHAR(20)
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 票据使用表
(
    领用序号     INT                  NOT NULL,
    票据类型     INT                  NOT NULL COMMENT '对应字典表的dicgrpid=31',
    票号       VARCHAR(12)                NULL,
    操作员      INT                      NULL COMMENT '对应用户表的userid',
    使用时间     DATE             ,
    票据状态     INT DEFAULT 0        COMMENT '0:正常   1:作废  2:报损  3:遗失',
    CHOSCODE VARCHAR(20)                NULL,
    CODE     VARCHAR(20)                NULL COMMENT '门诊为处方号,住院为住院号',
    日结序号     INT                      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 日结表
(
    SERIALNO     INT                  NULL,
    TOTALFARE    INT                  NULL COMMENT '总金额',
    YJFARE       INT                  NULL COMMENT '应交合计',
    CREATETIME   DATE                    NULL,
    UPOPTIME     DATE                    NULL,
    OPERATORCODE VARCHAR(20)            NULL COMMENT '交账人',
    CHOSCODE     VARCHAR(20)            NULL,
    STATUS       INT DEFAULT 0        COMMENT '0:未收款   1:已收款',
    SKOPERATOR   VARCHAR(20)            NULL COMMENT '审核人',
    SKDATE       DATE                    NULL COMMENT '审核时间',
    MZPJ         VARCHAR(500)           NULL COMMENT '门诊区间票号',
    MZZF         VARCHAR(100)          NULL COMMENT '门诊作废票据',
    MZOK         INT                  NULL COMMENT '门诊有效票数',
    MZNUM        INT                  NULL COMMENT '门诊总票数',
    ZYPJ         VARCHAR(500)           NULL,
    ZYZF         VARCHAR(100)          NULL,
    ZYOK         INT                  NULL,
    ZYNUM        INT                  NULL,
    DEPPJ        VARCHAR(500)           NULL,
    DEPZF        VARCHAR(100)          NULL,
    DEPOK        INT                  NULL,
    DEPNUM       INT                  NULL,
    DAYKIND      INT DEFAULT 0        COMMENT '日结类型 0:全部  1:门诊  2:预交款  3:住院结算',
    RECDATE      DATE             ,
    OPCODE       VARCHAR(20)            NULL,
    TOTALDEP     INT                  NULL,
    FARE1        INT                  NULL COMMENT '总金额',
    FARE2        INT                  NULL COMMENT '总预交金',
    HZID         INT                  NULL,
    COMMENTS     VARCHAR(30)            NULL,
    TYPEID       INT                  NULL,
    FAREPOS      INT                  NULL,
    FARETPOS     INT                  NULL,
    CHECKMAN     VARCHAR(20)            NULL COMMENT '二次审核人',
    CHECKDATE    DATE                    NULL COMMENT '二次审核日期',
    CHECKSTATUS  INT DEFAULT 0        COMMENT '审核状态  0  未审核  1 审核',
    WXFARE       INT                  NULL COMMENT '微信支付金额',
    ZFBFARE      INT                  NULL COMMENT '支付宝支付金额',
    CHECKMANID   VARCHAR(20)            NULL COMMENT '审核人编码',
    SKOPERATORID VARCHAR(20)            NULL COMMENT '收款操作员编码'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 日结汇总表
(
    ID         INT                  PRIMARY KEY,
    OPERATORID VARCHAR(20)            NOT NULL,
    OPDATE     DATE             ,
    DAYKIND    INT                  NOT NULL COMMENT '日结类型 0:全部  1:门诊  2:预交款  3:住院结算',
    HZUSER     VARCHAR(500)              NULL,
    HZSERIALNO VARCHAR(200)             NULL,
    CN         INT                      NULL,
    CHOSCODE   VARCHAR(20)            NOT NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 日结明细表
(
    SERIALNO INT            NULL,
    KIND     VARCHAR(4)       NULL,
    病人类型     VARCHAR(20)      NULL,
    人次       INT            NULL,
    结算金额     INT            NULL,
    结算预交金    INT            NULL,
    农合报销     INT            NULL,
    降消报销     INT            NULL COMMENT '其他报销',
    降消人次     INT            NULL,
    押金数额     INT            NULL,
    结算退补     INT            NULL,
    应交合计     INT            NULL,
    CHOSCODE VARCHAR(20)      NULL,
    优惠减免     INT DEFAULT 0 ,
    账户支付     INT DEFAULT 0 ,
    WXFARE   INT            NULL COMMENT '微信支付',
    ZFBFARE  INT            NULL COMMENT '支付宝支付'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 日结明细分类表
(
    SERIALNO  INT            NULL,
    KIND      VARCHAR(4)       NULL,
    CLASSNAME VARCHAR(30)      NULL,
    CLASSFARE INT            NULL,
    CHOSCODE  VARCHAR(20)      NULL,
    CLASSCODE VARCHAR(10)      NULL COMMENT '对应费用编码或者财务码，根据classtype决定',
    CLASSTYPE INT DEFAULT 0  COMMENT '0：对应费用类别表ID   1:对应财务分类表ItemCode'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 入库单
(
    单据编号     VARCHAR(20)            NOT NULL,
    过单日期     DATE             ,
    入库方式     VARCHAR(10)                NULL,
    备注       VARCHAR(100)              NULL,
    状态       CHAR(1)                     NULL,
    制单人      VARCHAR(20)                NULL,
    审核人      VARCHAR(20)                NULL,
    存放位置     INT                      NULL,
    客商单位     VARCHAR(100)               NULL,
    成本合计     INT                      NULL,
    零售合计     INT                      NULL,
    制单时间     DATE                        NULL,
    CHOSCODE VARCHAR(20)                NULL,
    发票号      VARCHAR(50)                NULL,
    随货单号     VARCHAR(50)                NULL,
    RECDATE  DATE              COMMENT '记录日期'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 入库数据
(
    单据编号     VARCHAR(12)    NOT NULL,
    编号       VARCHAR(20)        NULL,
    数量       INT              NULL,
    金额       INT              NULL,
    生产批号     VARCHAR(15)        NULL,
    有效期至     DATE                NULL,
    单项备注     VARCHAR(50)       NULL,
    单价       INT              NULL,
    行序       INT              NULL,
    零售单价     INT              NULL,
    生产单位     VARCHAR(60)        NULL,
    药品单位     VARCHAR(5)        NULL,
    零售金额     INT              NULL,
    原库存流水    INT              NULL,
    单位编码     VARCHAR(5)         NULL,
    CHOSCODE VARCHAR(20)        NULL,
    RKEY     VARCHAR(30)        NULL,
    批准文号     VARCHAR(128)      NULL,
    条码号      VARCHAR(20)        NULL,
    生产日期     DATE                NULL,
    产地       VARCHAR(50)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 特殊操作日志
(
    CHOSCODE VARCHAR(20)            NULL,
    CHOSNAME VARCHAR(50)            NULL,
    操作功能     INT                  NULL COMMENT '0:业务数据删除 1:药品字典数据删除 2:清除库存数据 3:库存初始化 4:单独强制删除住院数据 5:住院退号 6:冲红农合端住院结算 7:领用就诊卡',
    授权人      VARCHAR(20)            NULL,
    授权手机号码   VARCHAR(20)            NULL,
    操作员      VARCHAR(20)            NULL,
    操作机器     VARCHAR(400)           NULL,
    辅助说明     VARCHAR(100)           NULL,
    OPDATE   DATE
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 退药信息表
(
    自动编码     INT        NOT NULL,
    业务类型     VARCHAR(30)      NULL,
    登记号      VARCHAR(20)      NULL,
    处方号      VARCHAR(20)      NULL,
    药品编码     VARCHAR(20)      NULL,
    药品名称     VARCHAR(80)      NULL,
    药品规格     VARCHAR(50)      NULL,
    药品单位     VARCHAR(20)      NULL,
    退药数量     INT            NULL,
    零售价      INT            NULL,
    金额       INT            NULL,
    操作员      VARCHAR(20)      NULL,
    操作时间     DATE              NULL,
    库存流水     INT            NULL,
    CHOSCODE VARCHAR(20)      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 系统参数
(
    ID          INT                  PRIMARY KEY,
    SYSNAME     VARCHAR(100)               NULL,
    SYSVALUE    VARCHAR(300)               NULL,
    SYSEXPLAIN  VARCHAR(300)               NULL,
    CHOSCODE    VARCHAR(20)            ,
    CREATE_TIME DATE             ,
    IS_CHARGE   INT DEFAULT 0        NOT NULL COMMENT '是否收费参数(1:是 0:否)'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 项目表
(
    项目编码          VARCHAR(20)          PRIMARY KEY,
    拼音码           VARCHAR(50)              NULL,
    项目名称          VARCHAR(100)         NOT NULL,
    项目单位          VARCHAR(20)          NOT NULL,
    项目价格          FLOAT                     NULL,
    费用类别          VARCHAR(20)          NOT NULL,
    备注            VARCHAR(100)            NULL,
    核算科室          VARCHAR(20)              NULL,
    CHOSCODE      VARCHAR(20)          ,
    有效标志          CHAR(1) DEFAULT '1 '  NOT NULL COMMENT '0-无效,1-有效',
    财务编码          VARCHAR(2)           NOT NULL,
    批准文号          VARCHAR(50)              NULL,
    物价编码          VARCHAR(20)              NULL,
    检查类型          VARCHAR(8)               NULL COMMENT '统一平台(字典表1353)',
    HISCORETYPE   INT                    NULL,
    WBCODE        VARCHAR(40)              NULL COMMENT '五笔码',
    ISOUTHOSPITAL INT DEFAULT 0      COMMENT '是否外院项目(1:是 0:否-默认)',
    MIN_PRICE     FLOAT                     NULL COMMENT '最低价格',
    MAX_PRICE     FLOAT                     NULL COMMENT '最高价格'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 项目单位表
(
    编号       INT        PRIMARY KEY,
    名称       VARCHAR(20)  NULL,
    CHOSCODE VARCHAR(20)  NULL,
    PYCODE   VARCHAR(10)  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 押金表
(
    ID       INT                    NOT NULL,
    住院号      VARCHAR(20)                  NULL,
    押金数额     INT DEFAULT 0         ,
    交付日期     DATE               ,
    押金人      VARCHAR(50)                  NULL,
    剩余金额     INT DEFAULT 0         ,
    操作员      VARCHAR(20)                  NULL,
    CHOSCODE VARCHAR(20)                  NULL,
    状态       INT DEFAULT 0          COMMENT '0:正常  1:作废',
    发票号      VARCHAR(20)                  NULL,
    PAYTYPE  INT DEFAULT 0          COMMENT '交款方式  0:现金    1:支票',
    日结序号     INT                        NULL,
    是否结算     INT                        NULL COMMENT '0:否  1:是',
    结算流水号    INT                        NULL,
    平台交易号    VARCHAR(50) DEFAULT '0'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 药房表
(
    ID       INT             NOT NULL,
    药房名称     VARCHAR(20)           NULL,
    对应科室     INT                 NULL,
    CHOSCODE VARCHAR(20)           NULL,
    是否药库     INT DEFAULT 0   NOT NULL,
    ORDID    INT                 NULL COMMENT '门诊库房排序',
    ZYORDID  INT                 NULL COMMENT '住院库房排序',
    是否冻结     VARCHAR(2)            NULL COMMENT '1冻结'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 药品处方表
(
    处方号         VARCHAR(12)   NULL,
    收款标志        CHAR(1)        NULL,
    发药标志        CHAR(1)        NULL,
    过单时间        DATE           NULL,
    药房          INT         NULL,
    CHOSCODE    VARCHAR(20)   NULL,
    划价标志        CHAR(1)        NULL,
    住院标志        INT         NULL,
    付           INT         NULL,
    姓名          VARCHAR(50)   NULL,
    性别          VARCHAR(4)    NULL,
    年龄          VARCHAR(8)    NULL,
    开单科室        INT         NULL,
    开单医生        INT         NULL,
    接单科室        INT         NULL,
    接单医生        INT         NULL,
    备注          VARCHAR(100)  NULL,
    REGCODE     VARCHAR(20)   NULL,
    SENDNAME    VARCHAR(20)   NULL,
    RECVNAME    VARCHAR(20)   NULL,
    MEDICALTYPE INT         NULL,
    金额          INT         NULL,
    PYCODE      VARCHAR(10)   NULL,
    CODE        VARCHAR(12)   NULL,
    疾病名称        VARCHAR(50)   NULL,
    疾病编码        VARCHAR(20)   NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 药品处方明细表
(
    自动编码     INT         PRIMARY KEY,
    处方号      VARCHAR(20)   NOT NULL,
    标志       INT             NULL,
    编码       VARCHAR(20)       NULL,
    名称       VARCHAR(100)      NULL,
    规格       VARCHAR(30)       NULL,
    单位       VARCHAR(20)       NULL,
    数量       FLOAT              NULL,
    价格       INT             NULL,
    金额       INT             NULL,
    费用类别     VARCHAR(10)       NULL,
    发药状态     INT             NULL,
    退药数量     INT             NULL,
    操作员      VARCHAR(20)       NULL,
    药品辅助编码   INT             NULL,
    农合名称     VARCHAR(100)      NULL,
    农合编码     VARCHAR(20)       NULL,
    剂型       VARCHAR(10)       NULL,
    核算科室     INT             NULL,
    执行单价     INT             NULL,
    处方科室     INT             NULL,
    处方医生     VARCHAR(20)       NULL,
    处方时间     DATE               NULL,
    CHOSCODE VARCHAR(20)       NULL,
    频次       VARCHAR(20)       NULL,
    用法       VARCHAR(20)       NULL,
    用量       VARCHAR(30)       NULL,
    付        VARCHAR(2)        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 药品字典表
(
    ID           INT                   NOT NULL,
    药品编码         VARCHAR(30)             PRIMARY KEY COMMENT '药品编码',
    拼音码          VARCHAR(40)             NOT NULL,
    药品名称         VARCHAR(100)                NULL,
    药品规格         VARCHAR(200)                NULL,
    辅助单位         VARCHAR(20)                 NULL,
    计价单位         VARCHAR(20)                 NULL,
    换算关系         INT DEFAULT 1        ,
    药品分类         VARCHAR(10)                 NULL COMMENT '字典表  2',
    费用归类         VARCHAR(10)                 NULL COMMENT '费用类别表',
    剂型           VARCHAR(10)                 NULL,
    存贮条件         VARCHAR(80)                 NULL,
    性状           VARCHAR(10)                 NULL,
    进口           CHAR(1) DEFAULT '0'      NOT NULL,
    贵重           CHAR(1) DEFAULT '0'      NOT NULL,
    毒麻           CHAR(1) DEFAULT '0'      NOT NULL,
    OTC          CHAR(1) DEFAULT '0'      NOT NULL,
    内服           CHAR(1) DEFAULT '0'      NOT NULL,
    适用对象         VARCHAR(20)                 NULL,
    批准文号         VARCHAR(128)                NULL,
    备注           BIT                         NULL,
    零售价格         INT DEFAULT 0        ,
    最近成本         INT DEFAULT 0        ,
    CHOSCODE     VARCHAR(20)             ,
    禁用标志         INT DEFAULT 0         NOT NULL,
    生产厂家         VARCHAR(128)                NULL,
    基药ID         INT DEFAULT 0         NOT NULL COMMENT '0 非基药   1 基药  ',
    加成率          INT                       NULL,
    抗生素          INT DEFAULT 0         NOT NULL COMMENT '0:普通   1:抗生素   2:特殊抗生素',
    DDD          INT                       NULL COMMENT '成人药物平均日剂量',
    剂量系数         INT                       NULL COMMENT '抗生素对应剂量系数',
    是否可撤分        INT DEFAULT 0         COMMENT '门诊是否可以撤分（最小计价单位拆分）',
    五笔码          VARCHAR(40)                 NULL,
    门诊单位         VARCHAR(30)                 NULL,
    门诊系数         INT                       NULL,
    住院单位         VARCHAR(30)                 NULL,
    住院系数         INT                       NULL,
    单次用量         VARCHAR(50)                 NULL,
    给药途径         VARCHAR(20)                 NULL,
    给药频率         VARCHAR(20)                 NULL,
    精二           INT DEFAULT 0         NOT NULL,
    用药提示         VARCHAR(100)                NULL,
    皮试           VARCHAR(1) DEFAULT '0'  NOT NULL,
    使用范围         INT DEFAULT 0         NOT NULL COMMENT '0 通用 1 门诊 2住院',
    条形码          VARCHAR(50)                 NULL COMMENT '药品条形码',
    产地           VARCHAR(50)                 NULL,
    HISCORETYPE  INT                       NULL COMMENT '药品中心编码',
    HISCAIWUTYPE VARCHAR(10)                 NULL COMMENT '财务分类',
    ZYSPLIT      INT DEFAULT 0         COMMENT '住院是否可以撤分（最小计价单位拆分）',
    GMP          VARCHAR(3)                  NULL COMMENT '药品生产质量管理规范( 1 是  0 否)',
    最低库存         INT                       NULL COMMENT '最低库存'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 医生表
(
    ID                   INT                     PRIMARY KEY,
    姓名                   VARCHAR(20)               NOT NULL,
    拼音码                  VARCHAR(10)                   NULL,
    性别                   VARCHAR(2) DEFAULT '男' ,
    出生年月                 DATE                           NULL,
    科室                   INT                         NULL,
    职务                   VARCHAR(10)                   NULL,
    CHOSCODE             VARCHAR(20)                   NULL,
    UNITCODE             VARCHAR(20)                   NULL,
    IFDOCTOR             INT DEFAULT 1          ,
    IFHEAD               INT DEFAULT 0          ,
    IFUSE                INT DEFAULT 1          ,
    DOCTOR               VARCHAR(30)                   NULL,
    IFOPERATOR           INT DEFAULT 0           COMMENT '是否操作员标志',
    USERACCOUNT          VARCHAR(20)                   NULL COMMENT '对应 用户表的账号',
    NHOPCODE             VARCHAR(20)                   NULL COMMENT '农合端操作员编码',
    NHOPNAME             VARCHAR(50)                   NULL COMMENT '农合端操作员姓名',
    RECDATE              DATE                ,
    身份证号                 VARCHAR(20)                   NULL COMMENT '用来当做证件号码',
    执业类别                 VARCHAR(20)                   NULL,
    医师级别                 VARCHAR(20)                   NULL,
    执业证书编码               VARCHAR(30)                   NULL,
    毕业院校                 VARCHAR(50)                   NULL,
    执业范围                 VARCHAR(30)                   NULL,
    执业证书时间               DATE                           NULL,
    处方权                  INT                         NULL,
    主治疾病内容               VARCHAR(500)                  NULL,
    XNHZH                VARCHAR(20)                   NULL,
    XNHMM                VARCHAR(100)                  NULL,
    PHOTO                BIT                           NULL,
    QMPHOTO              BIT                           NULL,
    DBID                 VARCHAR(20)                   NULL,
    公卫用户名                VARCHAR(50)                   NULL,
    公卫密码                 VARCHAR(20)                   NULL,
    联系方式                 VARCHAR(20)                   NULL,
    NATIONID             VARCHAR(10)                   NULL COMMENT '民族编码（对应字典编码50）',
    IDENTITYID           VARCHAR(10)                   NULL COMMENT '证件类型（对应字典编码53）',
    EDUCATIONBACKGROUND  VARCHAR(10)                   NULL COMMENT '学历（）',
    JOINWORKDATE         DATE                           NULL COMMENT '参加工作日期',
    GRADUATEDSCHOOL      VARCHAR(50)                   NULL COMMENT '毕业学校',
    PRACTISINGFALG       VARCHAR(1) DEFAULT '0'    COMMENT '多点执业标志 1=是
0=否
',
    SERVICEFLAG          VARCHAR(1) DEFAULT '0'    COMMENT '医师医保服务资格状态 1=是
0=否
',
    MONITORLEVEL         VARCHAR(1) DEFAULT '0'    COMMENT '监控等级 1=是
0=否
',
    POISONFLAG           VARCHAR(1) DEFAULT '0'    COMMENT '毒麻精神药品资格  1=是
0=否
 ',
    YBDEPTCODE           VARCHAR(20)                   NULL COMMENT '社保所属科室编码',
    JOBNUMBER            VARCHAR(20)                   NULL COMMENT '工号',
    WORKSTATE            VARCHAR(2)                    NULL COMMENT '0=不在职
1=在职
2=返聘
3=临聘
4=返聘不满半年
5=临聘不满半年
',
    STARTDATE            DATE                           NULL COMMENT '指在本机构执业开始日期',
    NOWPROFESSIONNAME    VARCHAR(100)                  NULL COMMENT '现从事专业名称',
    STUDYSPECIALTY       VARCHAR(100)                  NULL COMMENT '所学的专业名称',
    SPECIALTYLEVEL       VARCHAR(10)                   NULL COMMENT '专业技术职务级别',
    CATEGORY             VARCHAR(1)                    NULL COMMENT ' 医生类别  1  医师  2  药师',
    CERTIFICATECODE      VARCHAR(100)                  NULL COMMENT '医（药）师资格证编码',
    FPUSER               VARCHAR(20)                   NULL COMMENT '发票用户(广西贵港)',
    FPPASSWORD           VARCHAR(20)                   NULL COMMENT '发票密码(广西贵港)',
    FPTZH                VARCHAR(50)                   NULL COMMENT '发票套帐号(广西贵港)',
    WBCODE               VARCHAR(10)                   NULL COMMENT '五笔码',
    AREA_COMMAN_ACCOUNT  VARCHAR(20)                   NULL COMMENT '区域公卫账号',
    AREA_COMMAN_PASSWORD VARCHAR(40)                   NULL COMMENT '区域公卫密码',
    UUID                 VARCHAR(40)                  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 用户表
(
    USERID       INT                 NOT NULL,
    USERACCOUNT  VARCHAR(20)           NOT NULL,
    USERPASSWORD VARCHAR(32)               NULL,
    USERPOWER    INT                     NULL,
    NAME         VARCHAR(60)               NULL,
    所属科室         INT                     NULL,
    性别           CHAR(2)                    NULL,
    CHOSCODE     VARCHAR(20)           NOT NULL,
    EFFICET      CHAR(1) DEFAULT '0' ,
    FIXEDFLAG    INT DEFAULT (0)     COMMENT '固有用户，不允许用户删除的标志',
    MOBILEPHONE  VARCHAR(11)               NULL COMMENT '手机号绑定',
    PYCODE       VARCHAR(20)               NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 职务表
(
    ID       INT        NOT NULL,
    名称       VARCHAR(20)  NOT NULL,
    CHOSCODE VARCHAR(20)      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院处方表
(
    处方号        VARCHAR(20)              NOT NULL,
    住院号        VARCHAR(20)                  NULL,
    处方医生       INT                        NULL,
    处方日期       DATE ,
    总金额        INT                        NULL,
    处方科室       INT                        NULL,
    药房         INT                        NULL,
    病人类型       VARCHAR(2)                   NULL,
    CHOSCODE   VARCHAR(20)                  NULL,
    接单医生       VARCHAR(20)                  NULL,
    接单科室       VARCHAR(20)                  NULL,
    记录日期       DATE ,
    发药人        VARCHAR(20)                  NULL,
    发药时间       DATE                          NULL,
    执行序号       INT                        NULL,
    HZID       INT                        NULL,
    付          INT DEFAULT 1         ,
    KIND       INT DEFAULT 0         ,
    SICKDEPTID INT                        NULL,
    是否结算       INT DEFAULT 0          COMMENT '未结算= 0;中途结算=1;出院结算=2',
    结算流水号      VARCHAR(20)                  NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院处方明细表
(
    自动编码            INT                    NOT NULL,
    住院号             VARCHAR(20)                  NULL,
    处方号             VARCHAR(10)                  NULL,
    处方时间            DATE ,
    处方医生            VARCHAR(50)                  NULL,
    标志              INT                        NULL,
    编码              VARCHAR(30)                  NULL,
    名称              VARCHAR(100)                 NULL,
    规格              VARCHAR(500)                 NULL,
    单位              VARCHAR(50)                  NULL,
    数量              INT DEFAULT 0          NOT NULL,
    价格              INT DEFAULT 0         ,
    金额              INT                        NULL,
    费用类别            VARCHAR(20)                  NULL,
    发药状态            INT                        NULL COMMENT '0未发药,1发药,2退药,3 未发药退费',
    退药数量            INT DEFAULT 0         ,
    操作员             VARCHAR(20)              NOT NULL,
    药品辅助编码_123      INT                        NULL COMMENT '对应药品表的ID',
    上传标志            CHAR(1) DEFAULT '0'       COMMENT '0-未上传，1-已上传',
    农合条目编码          VARCHAR(80)                  NULL,
    农合名称            VARCHAR(100)                 NULL,
    农合编码            VARCHAR(20)                  NULL,
    剂型              VARCHAR(10)                  NULL,
    已退药数量           INT DEFAULT 0          COMMENT '实际已退药的数量',
    核算科室            INT                        NULL,
    处方科室            INT                        NULL,
    执行单价            INT                        NULL,
    CHOSCODE        VARCHAR(20)                  NULL,
    医嘱序号            INT                        NULL,
    打包名             VARCHAR(80)                  NULL,
    用法              VARCHAR(20)                  NULL,
    用量              VARCHAR(30)                  NULL,
    频次              VARCHAR(20)                  NULL,
    DBID            INT                        NULL,
    退费原因            VARCHAR(100)                 NULL,
    IFBABY          CHAR(1) DEFAULT '0'       COMMENT '是否婴儿 0 否 1 是',
    付               VARCHAR(2)                   NULL,
    退费编码            INT                        NULL COMMENT '对应被退费的明细自动编码',
    药品辅助编码          VARCHAR(20)                  NULL,
    IS_GET_MEDICINE INT DEFAULT 0          COMMENT '是否已领药(1:是 0:否)',
    CREATE_DATE     DATE               ,
    CHRGITM_LV      VARCHAR(10)                  NULL COMMENT '收费项目等级（甲乙丙类）'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院登记表
(
    住院号                  VARCHAR(20)                    NULL COMMENT '住院流水号',
    登记时间                 DATE                            NULL,
    入院科室                 VARCHAR(20)                    NULL,
    接诊医生                 VARCHAR(20)                    NULL,
    病人姓名                 VARCHAR(20)                    NULL,
    病人性别                 VARCHAR(4)                     NULL,
    病人年龄                 VARCHAR(8)                     NULL,
    病人住址                 VARCHAR(80)                    NULL,
    工作单位                 VARCHAR(50)                    NULL,
    联系人                  VARCHAR(20)                    NULL,
    联系电话                 VARCHAR(20)                    NULL,
    疾病                   VARCHAR(100)                   NULL,
    金额                   INT DEFAULT 0           ,
    是否在院                 INT                          NULL,
    出院时间                 DATE                            NULL,
    出院诊断                 VARCHAR(20)                    NULL,
    出院交纳                 INT DEFAULT 0           ,
    是否结算                 INT                          NULL,
    个人编码                 VARCHAR(20)                    NULL,
    参合标志                 VARCHAR(200) DEFAULT '0'  COMMENT '0-普通病人，1-参合病人',
    医疗证号                 VARCHAR(20)                    NULL,
    上传标志                 CHAR(1) DEFAULT '0'         COMMENT '0-未上传，1-已上传入院，2-已作废，3-已上传出院',
    住院编码                 VARCHAR(20)                    NULL COMMENT '医保住院登记流水号',
    作废标志                 CHAR(1) DEFAULT '0'         COMMENT '0-正常，1-作废',
    病人类型                 INT                          NULL,
    审核标志                 INT DEFAULT 0           ,
    审核日期                 DATE                            NULL,
    操作员                  VARCHAR(20)                    NULL,
    审核人                  VARCHAR(20)                    NULL,
    出院退款                 INT DEFAULT 0            NOT NULL,
    CHOSCODE             VARCHAR(20)                    NULL,
    农合报销                 INT DEFAULT 0           ,
    其他诊断                 VARCHAR(128)                   NULL,
    入院状态                 VARCHAR(20)                    NULL,
    证件是否齐全               VARCHAR(20)                    NULL,
    出院状态                 VARCHAR(20)                    NULL,
    出院科室                 VARCHAR(20)                    NULL,
    结算时间                 DATE                            NULL,
    结算人                  VARCHAR(20)                    NULL,
    账户支付                 INT DEFAULT 0           ,
    基本统筹                 INT DEFAULT 0           ,
    大额统筹                 INT DEFAULT 0           ,
    其他报销                 INT DEFAULT 0           ,
    保内                   INT DEFAULT 0           ,
    保外                   INT DEFAULT 0           ,
    手术代码                 VARCHAR(30)                    NULL,
    床号                   VARCHAR(20)                    NULL,
    优惠减免                 INT DEFAULT 0           ,
    农合登记类型               VARCHAR(10)                    NULL,
    备注                   VARCHAR(150)                   NULL,
    发票号                  VARCHAR(12)                    NULL,
    就诊卡号                 VARCHAR(50)                    NULL,
    证件号码                 VARCHAR(20)                    NULL,
    手术名称                 VARCHAR(100)                   NULL,
    入院诊断名称               VARCHAR(100)                   NULL,
    出院诊断名称               VARCHAR(100)                   NULL,
    辅助类型                 INT DEFAULT 0            COMMENT '1:包干病人,用作贵阳市医保的“清算方式”',
    结算编号                 VARCHAR(50)                    NULL,
    RECDATE              DATE                 ,
    门诊医生                 INT                          NULL,
    拼音码                  VARCHAR(20)                    NULL,
    押金                   INT DEFAULT 0           ,
    担保金                  INT DEFAULT 0           ,
    疾病分类                 INT                          NULL,
    支付类别                 VARCHAR(20)                    NULL,
    中心编号                 VARCHAR(20)                    NULL,
    IFBADY               INT DEFAULT 0           ,
    体重                   VARCHAR(10)                    NULL,
    分娩时间                 DATE                            NULL,
    父母姓名                 VARCHAR(20)                    NULL,
    NOTE1                VARCHAR(20)                    NULL,
    NURSELEVEL           VARCHAR(10)                    NULL,
    ZYCODE               VARCHAR(20)                    NULL COMMENT '住院号,多次住院住院号不变',
    VID                  INT                          NULL COMMENT '住院院次',
    职业                   VARCHAR(30)                    NULL,
    出生日期                 DATE                            NULL,
    地区编码                 VARCHAR(50)                    NULL,
    未结总费用                INT                          NULL,
    未结预交金                INT                          NULL,
    GWINFO               VARCHAR(100)                   NULL COMMENT '公卫信息 接口类型 1 万达 2 晶奇 | 档案号 | 人群分类   | 随访日期 | 下次随访日期 | 管理卡id',
    AGE                  VARCHAR(20)                    NULL,
    BEDNURSE             VARCHAR(20)                    NULL,
    其他多诊断编码              VARCHAR(100)                   NULL,
    其他多诊断名称              VARCHAR(100)                   NULL,
    多诊断治疗方式编码            VARCHAR(100)                   NULL,
    多诊断治疗方式名称            VARCHAR(100)                   NULL,
    重大疾病编码               VARCHAR(100)                   NULL,
    重大疾病名称               VARCHAR(100)                   NULL,
    转诊单号                 VARCHAR(22)                    NULL,
    家庭编号                 VARCHAR(20)                    NULL,
    转诊类型                 VARCHAR(2)                     NULL,
    已结总报销                INT                          NULL,
    是否中途结算               VARCHAR(2)                     NULL,
    ISENTERCP            INT                          NULL COMMENT '是否进入临床路径',
    其他诊断编码               VARCHAR(100)                   NULL,
    SOURCE               INT DEFAULT 0            COMMENT '病人来源 0 住院登记  1 门诊转入院   2  转诊',
    SOURCECODE           VARCHAR(50)                    NULL COMMENT '病人来源编码',
    INSURETYPE           VARCHAR(20)                    NULL COMMENT '医保保险办法',
    YBJIESUANSTATUE      INT DEFAULT 0            COMMENT '医保结算状态(0 未提交  1  已提交  2  已提交确认 3 已完成结算）',
    YBJISSUANDATE        DATE                            NULL COMMENT '医保结算经办日期',
    RUKEDATE             DATE                            NULL COMMENT '入科时间',
    UPLOAD_DATE          DATE                            NULL COMMENT '上传时间',
    UPLOAD_USER_ID       VARCHAR(20)                    NULL COMMENT '上传者',
    DIP_UPLOAD_DATE      DATE                            NULL COMMENT 'DIP上传时间',
    DIP_UPLOAD_USER_ID   VARCHAR(20)                    NULL COMMENT 'DIP上传者',
    BINGQING             VARCHAR(100)                  NULL COMMENT '主要病情描述',
    BINGZHONG_CODE       VARCHAR(30)                    NULL COMMENT '病种编码',
    BINGZHONG_NAME       VARCHAR(500)                   NULL COMMENT '病种名称',
    SHENGYU_NO           VARCHAR(50)                    NULL COMMENT '计划生育服务证号',
    SHENGYU_TYPE         VARCHAR(6)                     NULL COMMENT '生育类别',
    SHENGYU_SURGERY_TYPE VARCHAR(6)                     NULL COMMENT '计划生育手术类别',
    IS_WANYU             INT                          NULL COMMENT '晚育标志',
    SHENGYU_MONTHS       INT                          NULL COMMENT '孕周数',
    SHENGYU_COUNT        INT                          NULL COMMENT '胎次',
    SHENGYU_BABIES       INT                          NULL COMMENT '胎儿数',
    IS_SHENGYU_ZAOCHAN   INT                          NULL COMMENT '早产标志',
    BINGZHONG_TYPE       VARCHAR(6)                     NULL COMMENT '病种类型',
    RUYUAN_ZHENGDUAN     VARCHAR(200)                  NULL COMMENT '入院诊断列表',
    UPLOAD_ID            VARCHAR(50)                    NULL COMMENT '上传ID',
    MAX_LIMIT            INT DEFAULT 9999999      COMMENT '最大欠费上限',
    SHENGYU_WEEKS        INT                          NULL COMMENT '孕周数'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院号生成规则表
(
    CHOSCODE VARCHAR(20)  NOT NULL,
    前缀规则     VARCHAR(20)      NULL,
    编号规则     VARCHAR(20)      NULL,
    起始号      VARCHAR(20)      NULL,
    主体长度     INT            NULL,
    主体是否补零   CHAR(1)           NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院结算表
(
    住院号        VARCHAR(20)            NULL,
    金额         INT DEFAULT 0        COMMENT '费用总金额',
    医保报销       INT DEFAULT 0        COMMENT '基本统筹+账户支付+大额统筹+其他报销',
    结算预交金      INT DEFAULT 0       ,
    出院交款       INT DEFAULT 0       ,
    出院退款       INT DEFAULT 0       ,
    账户支付       INT DEFAULT 0       ,
    基本统筹       INT DEFAULT 0       ,
    大额统筹       INT DEFAULT 0       ,
    其他报销       INT DEFAULT 0       ,
    优惠减免       INT DEFAULT 0       ,
    发票号        VARCHAR(12)            NULL,
    OPERATORID INT                  NULL,
    OPDATE     DATE             ,
    备注         VARCHAR(80)            NULL,
    STATUS     INT DEFAULT 0       ,
    CHOSCODE   VARCHAR(20)            NULL,
    OLDOPDATE  DATE                    NULL,
    支票         INT DEFAULT 0       ,
    日结序号       INT                  NULL,
    结算标志       INT                  NULL COMMENT '中途结算=1;出院结算=2',
    结算流水号      INT DEFAULT 0       ,
    医保结算编号     VARCHAR(50)            NULL,
    中途结算时间     DATE             ,
    上次中途结算时间   DATE                    NULL,
    收费方式       INT                  NULL COMMENT 'gy_paytype的PAYCODE'
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 住院作废表
(
    住院号      VARCHAR(20)  NOT NULL,
    CHOSCODE VARCHAR(20)  NOT NULL,
    病人姓名     VARCHAR(20)  NOT NULL,
    退号时间     DATE          NOT NULL,
    操作员      VARCHAR(20)  NOT NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 字典表
(
    DICGRPID INT              NOT NULL,
    DICID    VARCHAR(10)        NOT NULL,
    DICDESC  VARCHAR(100)           NULL,
    PYCODE   VARCHAR(50)            NULL,
    FIXED    INT DEFAULT (1) ,
    DEFVALUE INT DEFAULT (0) ,
    ORDID    INT                  NULL COMMENT '排序号',
    PTCODE   VARCHAR(20)            NULL COMMENT '对应基卫数据交换平台的编码',
    BACODE   VARCHAR(50)            NULL COMMENT '对应病案数据交换平台的编码',
    IFUSE    INT DEFAULT 1
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 字典组表
(
    DICGRPID INT         NOT NULL,
    REMARK   VARCHAR(100)      NULL,
    IFUSE    INT             NULL,
    PYCODE   VARCHAR(20)       NULL,
    USERANGE VARCHAR(20)       NULL,
    MEMO     VARCHAR(200)      NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 作废票据表
(
    票号       VARCHAR(12)              NOT NULL,
    票据类型     INT                    NOT NULL,
    日结       INT DEFAULT (0)       ,
    操作员      INT                        NULL,
    操作日期     DATE ,
    CHOSCODE VARCHAR(20)                  NULL,
    更换新票号    VARCHAR(12)                  NULL,
    日结序号     INT                        NULL
)
COMMENT '' COLLATE = utf8mb4_unicode_ci;


# MZCASEREC 外键定义
ALTER TABLE MZCASEREC
    ADD CONSTRAINT FK_MZCASERE_REFERENCE_MZJZREC
        FOREIGN KEY (FLOWNO) REFERENCES MZJZREC (FLOWNO)
                 ON UPDATE CASCADE;

# MZJZREC 外键定义
ALTER TABLE MZJZREC
    ADD CONSTRAINT FK_MZJZREC_REFERENCE_DICTMZVI
        FOREIGN KEY (VISCODE) REFERENCES DICTMZVIS (CODE)
                 ON UPDATE CASCADE;
ALTER TABLE MZJZREC
    ADD CONSTRAINT FK_MZJZREC_REFERENCE_DICTMZVI2
        FOREIGN KEY (CHOSCODE) REFERENCES DICTMZVIS (CHOSCODE)
                 ON UPDATE CASCADE;

# MZYZMODELDETAIL 外键定义
ALTER TABLE MZYZMODELDETAIL
    ADD CONSTRAINT FK_MZYZMOM_REFERENCE_MZYZMOD
        FOREIGN KEY (MODELID) REFERENCES MZYZMODELMAIN (ID)
                 ON UPDATE CASCADE;

# YJAPPLYDETAIL 外键定义
ALTER TABLE YJAPPLYDETAIL
    ADD CONSTRAINT FK_YJAPPLYD_REFERENCE_YJAPPLYM
        FOREIGN KEY (CHOSCODE) REFERENCES YJAPPLYMAIN (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE YJAPPLYDETAIL
    ADD CONSTRAINT FK_YJAPPLYD_REFERENCE_YJAPPLYM2
        FOREIGN KEY (APPLYID) REFERENCES YJAPPLYMAIN (APPLYID)
                 ON UPDATE CASCADE;

# YJAPPLYDETAILRESULT 外键定义
ALTER TABLE YJAPPLYDETAILRESULT
    ADD CONSTRAINT FK_YJAPPLYD_REFERENCE_YJAPPLYD
        FOREIGN KEY (CHOSCODE) REFERENCES YJAPPLYDETAIL (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE YJAPPLYDETAILRESULT
    ADD CONSTRAINT FK_YJAPPLYD_REFERENCE_YJAPPLYD2
        FOREIGN KEY (APPLYID) REFERENCES YJAPPLYDETAIL (APPLYID)
                 ON UPDATE CASCADE;
ALTER TABLE YJAPPLYDETAILRESULT
    ADD CONSTRAINT FK_YJAPPLYD_REFERENCE_YJAPPLYD3
        FOREIGN KEY (YJCODE) REFERENCES YJAPPLYDETAIL (YJCODE)
                 ON UPDATE CASCADE;

# YJAPPLYXDRESULT 外键定义
ALTER TABLE YJAPPLYXDRESULT
    ADD CONSTRAINT FK_YJAPPLYX_REFERENCE_YJAPPLYD
        FOREIGN KEY (CHOSCODE) REFERENCES YJAPPLYDETAIL (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE YJAPPLYXDRESULT
    ADD CONSTRAINT FK_YJAPPLYX_REFERENCE_YJAPPLYD
        FOREIGN KEY (APPLYID) REFERENCES YJAPPLYDETAIL (APPLYID)
                 ON UPDATE CASCADE;
ALTER TABLE YJAPPLYXDRESULT
    ADD CONSTRAINT FK_YJAPPLYX_REFERENCE_YJAPPLYD
        FOREIGN KEY (YJCODE) REFERENCES YJAPPLYDETAIL (YJCODE)
                 ON UPDATE CASCADE;

# ZYYZFAREREC 外键定义
ALTER TABLE ZYYZFAREREC
    ADD CONSTRAINT FK_ZYYZFARE_REFERENCE_ZYYZREC
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZREC (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFAREREC
    ADD CONSTRAINT FK_ZYYZFARE_REFERENCE_ZYYZREC
        FOREIGN KEY (SICKCODE) REFERENCES ZYYZREC (SICKCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFAREREC
    ADD CONSTRAINT FK_ZYYZFARE_REFERENCE_ZYYZREC
        FOREIGN KEY (VIRTUE) REFERENCES ZYYZREC (VIRTUE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFAREREC
    ADD CONSTRAINT FK_ZYYZFARE_REFERENCE_ZYYZREC
        FOREIGN KEY (YZNO) REFERENCES ZYYZREC (YZNO)
                 ON UPDATE CASCADE;

# ZYYZFARERECNEW 外键定义
ALTER TABLE ZYYZFARERECNEW
    ADD CONSTRAINT FK_ZYYZFARE_F_ZYYZREC
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZREC (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFARERECNEW
    ADD CONSTRAINT FK_ZYYZFARE_F_ZYYZREC
        FOREIGN KEY (SICKCODE) REFERENCES ZYYZREC (SICKCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFARERECNEW
    ADD CONSTRAINT FK_ZYYZFARE_F_ZYYZREC
        FOREIGN KEY (VIRTUE) REFERENCES ZYYZREC (VIRTUE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZFARERECNEW
    ADD CONSTRAINT FK_ZYYZFARE_F_ZYYZREC
        FOREIGN KEY (YZNO) REFERENCES ZYYZREC (YZNO)
                 ON UPDATE CASCADE;

# ZYYZMODELDETAIL 外键定义
ALTER TABLE ZYYZMODELDETAIL
    ADD CONSTRAINT FK_ZYYZMODE_REF_ZYYZMODEDETAIL
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZMODELMAIN (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZMODELDETAIL
    ADD CONSTRAINT FK_ZYYZMODE_REF_ZYYZMODEDETAIL
        FOREIGN KEY (MODELID) REFERENCES ZYYZMODELMAIN (MODELID)
                 ON UPDATE CASCADE;

# ZYYZMODELFARE 外键定义
ALTER TABLE ZYYZMODELFARE
    ADD CONSTRAINT FK_ZYYZMODE_REFYZMODE_ZYYZMODE
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZMODELDETAIL (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZMODELFARE
    ADD CONSTRAINT FK_ZYYZMODE_REFYZMODE_ZYYZMODE
        FOREIGN KEY (MODELID) REFERENCES ZYYZMODELDETAIL (MODELID)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZMODELFARE
    ADD CONSTRAINT FK_ZYYZMODE_REFYZMODE_ZYYZMODE
        FOREIGN KEY (YZNO) REFERENCES ZYYZMODELDETAIL (YZNO)
                 ON UPDATE CASCADE;

# ZYYZOPERATEREC 外键定义
ALTER TABLE ZYYZOPERATEREC
    ADD CONSTRAINT FK_ZYYZOPER_REFERENCE_ZYYZREC
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZREC (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZOPERATEREC
    ADD CONSTRAINT FK_ZYYZOPER_REFERENCE_ZYYZREC
        FOREIGN KEY (SICKCODE) REFERENCES ZYYZREC (SICKCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZOPERATEREC
    ADD CONSTRAINT FK_ZYYZOPER_REFERENCE_ZYYZREC
        FOREIGN KEY (VIRTUE) REFERENCES ZYYZREC (VIRTUE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZOPERATEREC
    ADD CONSTRAINT FK_ZYYZOPER_REFERENCE_ZYYZREC
        FOREIGN KEY (YZNO) REFERENCES ZYYZREC (YZNO)
                 ON UPDATE CASCADE;

# ZYYZPERFORMREC 外键定义
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZPERF
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZPERFORMMAIN (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZPERF
        FOREIGN KEY (PERFORMNO) REFERENCES ZYYZPERFORMMAIN (PERFORMNO)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZREC
        FOREIGN KEY (CHOSCODE) REFERENCES ZYYZREC (CHOSCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZREC
        FOREIGN KEY (SICKCODE) REFERENCES ZYYZREC (SICKCODE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZREC
        FOREIGN KEY (VIRTUE) REFERENCES ZYYZREC (VIRTUE)
                 ON UPDATE CASCADE;
ALTER TABLE ZYYZPERFORMREC
    ADD CONSTRAINT FK_ZYYZPERF_REFERENCE_ZYYZREC
        FOREIGN KEY (YZNO) REFERENCES ZYYZREC (YZNO)
                 ON UPDATE CASCADE;

# 门诊处方 外键定义
ALTER TABLE 门诊处方表
    ADD CONSTRAINT 门诊处方_医生ID
        FOREIGN KEY (处方医生) REFERENCES 医生表 (ID)
                 ON UPDATE CASCADE;

# 住院处方 外键定义
ALTER TABLE 住院处方表
    ADD CONSTRAINT 住院处方BAK_医生ID
        FOREIGN KEY (处方医生) REFERENCES 医生表 (ID)
                 ON UPDATE CASCADE;

