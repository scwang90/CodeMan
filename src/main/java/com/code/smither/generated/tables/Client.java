/*
 * This file is generated by jOOQ.
 */
package com.code.smither.generated.tables;


import com.code.smither.generated.Keys;
import com.code.smither.generated.Traveler;
import com.code.smither.generated.tables.records.ClientRecord;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.jooq.Field;
import org.jooq.ForeignKey;
import org.jooq.Identity;
import org.jooq.Name;
import org.jooq.Record;
import org.jooq.Row14;
import org.jooq.Schema;
import org.jooq.Table;
import org.jooq.TableField;
import org.jooq.TableOptions;
import org.jooq.UniqueKey;
import org.jooq.impl.DSL;
import org.jooq.impl.SQLDataType;
import org.jooq.impl.TableImpl;


/**
 * 客户（店铺商户）
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class Client extends TableImpl<ClientRecord> {

    private static final long serialVersionUID = 1L;

    /**
     * The reference instance of <code>traveler.client</code>
     */
    public static final Client CLIENT = new Client();

    /**
     * The class holding records for this type
     */
    @Override
    public Class<ClientRecord> getRecordType() {
        return ClientRecord.class;
    }

    /**
     * The column <code>traveler.client.id</code>. 主键标识
     */
    public final TableField<ClientRecord, Integer> ID = createField(DSL.name("id"), SQLDataType.INTEGER.nullable(false).identity(true), this, "主键标识");

    /**
     * The column <code>traveler.client.company_id</code>. 公司ID
     */
    public final TableField<ClientRecord, Integer> COMPANY_ID = createField(DSL.name("company_id"), SQLDataType.INTEGER.nullable(false), this, "公司ID");

    /**
     * The column <code>traveler.client.code</code>. 编号
     */
    public final TableField<ClientRecord, String> CODE = createField(DSL.name("code"), SQLDataType.VARCHAR(16).nullable(false), this, "编号");

    /**
     * The column <code>traveler.client.name</code>. 名称
     */
    public final TableField<ClientRecord, String> NAME = createField(DSL.name("name"), SQLDataType.VARCHAR(32).nullable(false), this, "名称");

    /**
     * The column <code>traveler.client.linkman</code>. 联系人
     */
    public final TableField<ClientRecord, String> LINKMAN = createField(DSL.name("linkman"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "联系人");

    /**
     * The column <code>traveler.client.salesman</code>. 业务员
     */
    public final TableField<ClientRecord, String> SALESMAN = createField(DSL.name("salesman"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "业务员");

    /**
     * The column <code>traveler.client.type</code>. 类型（使用字典配置）
     */
    public final TableField<ClientRecord, String> TYPE = createField(DSL.name("type"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "类型（使用字典配置）");

    /**
     * The column <code>traveler.client.address</code>. 地址
     */
    public final TableField<ClientRecord, String> ADDRESS = createField(DSL.name("address"), SQLDataType.VARCHAR(64).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "地址");

    /**
     * The column <code>traveler.client.qq</code>. QQ
     */
    public final TableField<ClientRecord, String> QQ = createField(DSL.name("qq"), SQLDataType.VARCHAR(12).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "QQ");

    /**
     * The column <code>traveler.client.mail</code>. 邮箱
     */
    public final TableField<ClientRecord, String> MAIL = createField(DSL.name("mail"), SQLDataType.VARCHAR(32).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "邮箱");

    /**
     * The column <code>traveler.client.telephone</code>. 联系方式
     */
    public final TableField<ClientRecord, String> TELEPHONE = createField(DSL.name("telephone"), SQLDataType.CHAR(11).defaultValue(DSL.inline("", SQLDataType.CHAR)), this, "联系方式");

    /**
     * The column <code>traveler.client.remark</code>. 备注说明
     */
    public final TableField<ClientRecord, String> REMARK = createField(DSL.name("remark"), SQLDataType.VARCHAR(64).defaultValue(DSL.inline("", SQLDataType.VARCHAR)), this, "备注说明");

    /**
     * The column <code>traveler.client.create_time</code>. 创建时间
     */
    public final TableField<ClientRecord, LocalDateTime> CREATE_TIME = createField(DSL.name("create_time"), SQLDataType.LOCALDATETIME(0).nullable(false), this, "创建时间");

    /**
     * The column <code>traveler.client.update_time</code>. 更新时间
     */
    public final TableField<ClientRecord, LocalDateTime> UPDATE_TIME = createField(DSL.name("update_time"), SQLDataType.LOCALDATETIME(0).nullable(false), this, "更新时间");

    private Client(Name alias, Table<ClientRecord> aliased) {
        this(alias, aliased, null);
    }

    private Client(Name alias, Table<ClientRecord> aliased, Field<?>[] parameters) {
        super(alias, null, aliased, parameters, DSL.comment("客户（店铺商户）"), TableOptions.table());
    }

    /**
     * Create an aliased <code>traveler.client</code> table reference
     */
    public Client(String alias) {
        this(DSL.name(alias), CLIENT);
    }

    /**
     * Create an aliased <code>traveler.client</code> table reference
     */
    public Client(Name alias) {
        this(alias, CLIENT);
    }

    /**
     * Create a <code>traveler.client</code> table reference
     */
    public Client() {
        this(DSL.name("client"), null);
    }

    public <O extends Record> Client(Table<O> child, ForeignKey<O, ClientRecord> key) {
        super(child, key, CLIENT);
    }

    @Override
    public Schema getSchema() {
        return Traveler.TRAVELER;
    }

    @Override
    public Identity<ClientRecord, Integer> getIdentity() {
        return (Identity<ClientRecord, Integer>) super.getIdentity();
    }

    @Override
    public UniqueKey<ClientRecord> getPrimaryKey() {
        return Keys.KEY_CLIENT_PRIMARY;
    }

    @Override
    public List<UniqueKey<ClientRecord>> getKeys() {
        return Arrays.<UniqueKey<ClientRecord>>asList(Keys.KEY_CLIENT_PRIMARY);
    }

    @Override
    public List<ForeignKey<ClientRecord, ?>> getReferences() {
        return Arrays.<ForeignKey<ClientRecord, ?>>asList(Keys.CLIENT_COMPANY_ID_FK);
    }

    private transient Company _company;

    public Company company() {
        if (_company == null)
            _company = new Company(this, Keys.CLIENT_COMPANY_ID_FK);

        return _company;
    }

    @Override
    public Client as(String alias) {
        return new Client(DSL.name(alias), this);
    }

    @Override
    public Client as(Name alias) {
        return new Client(alias, this);
    }

    /**
     * Rename this table
     */
    @Override
    public Client rename(String name) {
        return new Client(DSL.name(name), null);
    }

    /**
     * Rename this table
     */
    @Override
    public Client rename(Name name) {
        return new Client(name, null);
    }

    // -------------------------------------------------------------------------
    // Row14 type methods
    // -------------------------------------------------------------------------

    @Override
    public Row14<Integer, Integer, String, String, String, String, String, String, String, String, String, String, LocalDateTime, LocalDateTime> fieldsRow() {
        return (Row14) super.fieldsRow();
    }
}
