/*
 * This file is generated by jOOQ.
 */
package com.code.smither.generated.tables.records;


import com.code.smither.generated.tables.UploadFile;

import java.time.LocalDateTime;

import org.jooq.Field;
import org.jooq.Record1;
import org.jooq.Record6;
import org.jooq.Row6;
import org.jooq.impl.UpdatableRecordImpl;


/**
 * 文件上传
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class UploadFileRecord extends UpdatableRecordImpl<UploadFileRecord> implements Record6<String, Integer, String, String, String, LocalDateTime> {

    private static final long serialVersionUID = 1L;

    /**
     * Setter for <code>traveler.upload_file.id</code>. 文件标识
     */
    public void setId(String value) {
        set(0, value);
    }

    /**
     * Getter for <code>traveler.upload_file.id</code>. 文件标识
     */
    public String getId() {
        return (String) get(0);
    }

    /**
     * Setter for <code>traveler.upload_file.type</code>. 文件类型
     */
    public void setType(Integer value) {
        set(1, value);
    }

    /**
     * Getter for <code>traveler.upload_file.type</code>. 文件类型
     */
    public Integer getType() {
        return (Integer) get(1);
    }

    /**
     * Setter for <code>traveler.upload_file.name</code>. 文件名称
     */
    public void setName(String value) {
        set(2, value);
    }

    /**
     * Getter for <code>traveler.upload_file.name</code>. 文件名称
     */
    public String getName() {
        return (String) get(2);
    }

    /**
     * Setter for <code>traveler.upload_file.path</code>. 存储路径
     */
    public void setPath(String value) {
        set(3, value);
    }

    /**
     * Getter for <code>traveler.upload_file.path</code>. 存储路径
     */
    public String getPath() {
        return (String) get(3);
    }

    /**
     * Setter for <code>traveler.upload_file.mime_type</code>. 媒体类型
     */
    public void setMimeType(String value) {
        set(4, value);
    }

    /**
     * Getter for <code>traveler.upload_file.mime_type</code>. 媒体类型
     */
    public String getMimeType() {
        return (String) get(4);
    }

    /**
     * Setter for <code>traveler.upload_file.time</code>. 上传日期时间
     */
    public void setTime(LocalDateTime value) {
        set(5, value);
    }

    /**
     * Getter for <code>traveler.upload_file.time</code>. 上传日期时间
     */
    public LocalDateTime getTime() {
        return (LocalDateTime) get(5);
    }

    // -------------------------------------------------------------------------
    // Primary key information
    // -------------------------------------------------------------------------

    @Override
    public Record1<String> key() {
        return (Record1) super.key();
    }

    // -------------------------------------------------------------------------
    // Record6 type implementation
    // -------------------------------------------------------------------------

    @Override
    public Row6<String, Integer, String, String, String, LocalDateTime> fieldsRow() {
        return (Row6) super.fieldsRow();
    }

    @Override
    public Row6<String, Integer, String, String, String, LocalDateTime> valuesRow() {
        return (Row6) super.valuesRow();
    }

    @Override
    public Field<String> field1() {
        return UploadFile.UPLOAD_FILE.ID;
    }

    @Override
    public Field<Integer> field2() {
        return UploadFile.UPLOAD_FILE.TYPE;
    }

    @Override
    public Field<String> field3() {
        return UploadFile.UPLOAD_FILE.NAME;
    }

    @Override
    public Field<String> field4() {
        return UploadFile.UPLOAD_FILE.PATH;
    }

    @Override
    public Field<String> field5() {
        return UploadFile.UPLOAD_FILE.MIME_TYPE;
    }

    @Override
    public Field<LocalDateTime> field6() {
        return UploadFile.UPLOAD_FILE.TIME;
    }

    @Override
    public String component1() {
        return getId();
    }

    @Override
    public Integer component2() {
        return getType();
    }

    @Override
    public String component3() {
        return getName();
    }

    @Override
    public String component4() {
        return getPath();
    }

    @Override
    public String component5() {
        return getMimeType();
    }

    @Override
    public LocalDateTime component6() {
        return getTime();
    }

    @Override
    public String value1() {
        return getId();
    }

    @Override
    public Integer value2() {
        return getType();
    }

    @Override
    public String value3() {
        return getName();
    }

    @Override
    public String value4() {
        return getPath();
    }

    @Override
    public String value5() {
        return getMimeType();
    }

    @Override
    public LocalDateTime value6() {
        return getTime();
    }

    @Override
    public UploadFileRecord value1(String value) {
        setId(value);
        return this;
    }

    @Override
    public UploadFileRecord value2(Integer value) {
        setType(value);
        return this;
    }

    @Override
    public UploadFileRecord value3(String value) {
        setName(value);
        return this;
    }

    @Override
    public UploadFileRecord value4(String value) {
        setPath(value);
        return this;
    }

    @Override
    public UploadFileRecord value5(String value) {
        setMimeType(value);
        return this;
    }

    @Override
    public UploadFileRecord value6(LocalDateTime value) {
        setTime(value);
        return this;
    }

    @Override
    public UploadFileRecord values(String value1, Integer value2, String value3, String value4, String value5, LocalDateTime value6) {
        value1(value1);
        value2(value2);
        value3(value3);
        value4(value4);
        value5(value5);
        value6(value6);
        return this;
    }

    // -------------------------------------------------------------------------
    // Constructors
    // -------------------------------------------------------------------------

    /**
     * Create a detached UploadFileRecord
     */
    public UploadFileRecord() {
        super(UploadFile.UPLOAD_FILE);
    }

    /**
     * Create a detached, initialised UploadFileRecord
     */
    public UploadFileRecord(String id, Integer type, String name, String path, String mimeType, LocalDateTime time) {
        super(UploadFile.UPLOAD_FILE);

        setId(id);
        setType(type);
        setName(name);
        setPath(path);
        setMimeType(mimeType);
        setTime(time);
    }
}
