/*
 * This file is generated by jOOQ.
 */
package com.code.smither.generated.tables;


import com.code.smither.generated.Keys;
import com.code.smither.generated.Traveler;
import com.code.smither.generated.tables.records.OrderRecord;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.jooq.Field;
import org.jooq.ForeignKey;
import org.jooq.Identity;
import org.jooq.Name;
import org.jooq.Record;
import org.jooq.Schema;
import org.jooq.Table;
import org.jooq.TableField;
import org.jooq.TableOptions;
import org.jooq.UniqueKey;
import org.jooq.impl.DSL;
import org.jooq.impl.SQLDataType;
import org.jooq.impl.TableImpl;


/**
 * 订单
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class Order extends TableImpl<OrderRecord> {

    private static final long serialVersionUID = 1L;

    /**
     * The reference instance of <code>traveler.order</code>
     */
    public static final Order ORDER = new Order();

    /**
     * The class holding records for this type
     */
    @Override
    public Class<OrderRecord> getRecordType() {
        return OrderRecord.class;
    }

    /**
     * The column <code>traveler.order.id</code>. 主键标识
     */
    public final TableField<OrderRecord, Integer> ID = createField(DSL.name("id"), SQLDataType.INTEGER.nullable(false).identity(true), this, "主键标识");

    /**
     * The column <code>traveler.order.client_id</code>. 客户ID
     */
    public final TableField<OrderRecord, Integer> CLIENT_ID = createField(DSL.name("client_id"), SQLDataType.INTEGER.nullable(false), this, "客户ID");

    /**
     * The column <code>traveler.order.company_id</code>. 公司ID
     */
    public final TableField<OrderRecord, Integer> COMPANY_ID = createField(DSL.name("company_id"), SQLDataType.INTEGER.nullable(false), this, "公司ID");

    /**
     * The column <code>traveler.order.creator_id</code>. 开单人ID
     */
    public final TableField<OrderRecord, Integer> CREATOR_ID = createField(DSL.name("creator_id"), SQLDataType.INTEGER.nullable(false), this, "开单人ID");

    /**
     * The column <code>traveler.order.reviewer_id</code>. 审核人ID
     */
    public final TableField<OrderRecord, Integer> REVIEWER_ID = createField(DSL.name("reviewer_id"), SQLDataType.INTEGER.nullable(false), this, "审核人ID");

    /**
     * The column <code>traveler.order.code</code>. 编号
     */
    public final TableField<OrderRecord, String> CODE = createField(DSL.name("code"), SQLDataType.VARCHAR(16).nullable(false), this, "编号");

    /**
     * The column <code>traveler.order.name</code>. 名称
     */
    public final TableField<OrderRecord, String> NAME = createField(DSL.name("name"), SQLDataType.VARCHAR(32).nullable(false), this, "名称");

    /**
     * The column <code>traveler.order.amount</code>. 数量
     */
    public final TableField<OrderRecord, Integer> AMOUNT = createField(DSL.name("amount"), SQLDataType.INTEGER.nullable(false), this, "数量");

    /**
     * The column <code>traveler.order.customer</code>. 客户（填入名称）
     */
    public final TableField<OrderRecord, String> CUSTOMER = createField(DSL.name("customer"), SQLDataType.VARCHAR(32).nullable(false), this, "客户（填入名称）");

    /**
     * The column <code>traveler.order.type</code>. 类型（使用字典配置）
     */
    public final TableField<OrderRecord, String> TYPE = createField(DSL.name("type"), SQLDataType.VARCHAR(32), this, "类型（使用字典配置）");

    /**
     * The column <code>traveler.order.order_date</code>. 订单日期
     */
    public final TableField<OrderRecord, LocalDate> ORDER_DATE = createField(DSL.name("order_date"), SQLDataType.LOCALDATE.nullable(false), this, "订单日期");

    /**
     * The column <code>traveler.order.close_date</code>. 看板日期
     */
    public final TableField<OrderRecord, LocalDate> CLOSE_DATE = createField(DSL.name("close_date"), SQLDataType.LOCALDATE.nullable(false), this, "看板日期");

    /**
     * The column <code>traveler.order.pay_status</code>. 付款状态
     */
    public final TableField<OrderRecord, Byte> PAY_STATUS = createField(DSL.name("pay_status"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "付款状态");

    /**
     * The column <code>traveler.order.order_price</code>. 订单金额（整数表示价格，需要除以100）
     */
    public final TableField<OrderRecord, Integer> ORDER_PRICE = createField(DSL.name("order_price"), SQLDataType.INTEGER, this, "订单金额（整数表示价格，需要除以100）");

    /**
     * The column <code>traveler.order.actual_price</code>. 实付金额（整数表示价格，需要除以100）
     */
    public final TableField<OrderRecord, Integer> ACTUAL_PRICE = createField(DSL.name("actual_price"), SQLDataType.INTEGER, this, "实付金额（整数表示价格，需要除以100）");

    /**
     * The column <code>traveler.order.remark</code>. 备注说明
     */
    public final TableField<OrderRecord, String> REMARK = createField(DSL.name("remark"), SQLDataType.VARCHAR(64).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "备注说明");

    /**
     * The column <code>traveler.order.sketchy_ids</code>. 初修人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> SKETCHY_IDS = createField(DSL.name("sketchy_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "初修人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.fine_ids</code>. 精修人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> FINE_IDS = createField(DSL.name("fine_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "精修人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.color_ids</code>. 调色人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> COLOR_IDS = createField(DSL.name("color_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "调色人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.quality_ids</code>. 质检人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> QUALITY_IDS = createField(DSL.name("quality_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "质检人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.design_ids</code>. 设计人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> DESIGN_IDS = createField(DSL.name("design_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "设计人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.kanban_ids</code>. 看板人员（多个Id逗号隔开）
     */
    public final TableField<OrderRecord, String> KANBAN_IDS = createField(DSL.name("kanban_ids"), SQLDataType.VARCHAR(32).nullable(false), this, "看板人员（多个Id逗号隔开）");

    /**
     * The column <code>traveler.order.upload_state</code>. 上传状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> UPLOAD_STATE = createField(DSL.name("upload_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "上传状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.sketchy_state</code>. 初修状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> SKETCHY_STATE = createField(DSL.name("sketchy_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "初修状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.fine_state</code>. 精修状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> FINE_STATE = createField(DSL.name("fine_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "精修状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.color_state</code>. 调色状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> COLOR_STATE = createField(DSL.name("color_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "调色状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.quality_state</code>. 质检状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> QUALITY_STATE = createField(DSL.name("quality_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "质检状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.design_state</code>. 设计状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> DESIGN_STATE = createField(DSL.name("design_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "设计状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.kanban_state</code>. 看板状态（0：未完成 1：完成）
     */
    public final TableField<OrderRecord, Byte> KANBAN_STATE = createField(DSL.name("kanban_state"), SQLDataType.TINYINT.defaultValue(DSL.inline("0", SQLDataType.TINYINT)), this, "看板状态（0：未完成 1：完成）");

    /**
     * The column <code>traveler.order.liaison</code>. 联系人
     */
    public final TableField<OrderRecord, String> LIAISON = createField(DSL.name("liaison"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "联系人");

    /**
     * The column <code>traveler.order.salesman</code>. 业务员
     */
    public final TableField<OrderRecord, String> SALESMAN = createField(DSL.name("salesman"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "业务员");

    /**
     * The column <code>traveler.order.address</code>. 地址
     */
    public final TableField<OrderRecord, String> ADDRESS = createField(DSL.name("address"), SQLDataType.VARCHAR(64).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "地址");

    /**
     * The column <code>traveler.order.qq</code>. 电话
     */
    public final TableField<OrderRecord, String> QQ = createField(DSL.name("qq"), SQLDataType.VARCHAR(12).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "电话");

    /**
     * The column <code>traveler.order.telephone</code>. 联系方式
     */
    public final TableField<OrderRecord, String> TELEPHONE = createField(DSL.name("telephone"), SQLDataType.CHAR(11).defaultValue(DSL.inline("", SQLDataType.CHAR)), this, "联系方式");

    /**
     * The column <code>traveler.order.create_time</code>. 创建时间
     */
    public final TableField<OrderRecord, LocalDateTime> CREATE_TIME = createField(DSL.name("create_time"), SQLDataType.LOCALDATETIME(0).nullable(false), this, "创建时间");

    /**
     * The column <code>traveler.order.update_time</code>. 更新时间
     */
    public final TableField<OrderRecord, LocalDateTime> UPDATE_TIME = createField(DSL.name("update_time"), SQLDataType.LOCALDATETIME(0).nullable(false), this, "更新时间");

    private Order(Name alias, Table<OrderRecord> aliased) {
        this(alias, aliased, null);
    }

    private Order(Name alias, Table<OrderRecord> aliased, Field<?>[] parameters) {
        super(alias, null, aliased, parameters, DSL.comment("订单"), TableOptions.table());
    }

    /**
     * Create an aliased <code>traveler.order</code> table reference
     */
    public Order(String alias) {
        this(DSL.name(alias), ORDER);
    }

    /**
     * Create an aliased <code>traveler.order</code> table reference
     */
    public Order(Name alias) {
        this(alias, ORDER);
    }

    /**
     * Create a <code>traveler.order</code> table reference
     */
    public Order() {
        this(DSL.name("order"), null);
    }

    public <O extends Record> Order(Table<O> child, ForeignKey<O, OrderRecord> key) {
        super(child, key, ORDER);
    }

    @Override
    public Schema getSchema() {
        return Traveler.TRAVELER;
    }

    @Override
    public Identity<OrderRecord, Integer> getIdentity() {
        return (Identity<OrderRecord, Integer>) super.getIdentity();
    }

    @Override
    public UniqueKey<OrderRecord> getPrimaryKey() {
        return Keys.KEY_ORDER_PRIMARY;
    }

    @Override
    public List<UniqueKey<OrderRecord>> getKeys() {
        return Arrays.<UniqueKey<OrderRecord>>asList(Keys.KEY_ORDER_PRIMARY);
    }

    @Override
    public List<ForeignKey<OrderRecord, ?>> getReferences() {
        return Arrays.<ForeignKey<OrderRecord, ?>>asList(Keys.ORDER_COMPANY_ID_FK);
    }

    private transient Company _company;

    public Company company() {
        if (_company == null)
            _company = new Company(this, Keys.ORDER_COMPANY_ID_FK);

        return _company;
    }

    @Override
    public Order as(String alias) {
        return new Order(DSL.name(alias), this);
    }

    @Override
    public Order as(Name alias) {
        return new Order(alias, this);
    }

    /**
     * Rename this table
     */
    @Override
    public Order rename(String name) {
        return new Order(DSL.name(name), null);
    }

    /**
     * Rename this table
     */
    @Override
    public Order rename(Name name) {
        return new Order(name, null);
    }
}
