package ${packageName}.mapper.intent.impl;import ${packageName}.mapper.intent.api.Query;public class WhereItem<T> implements Query<T> {    protected String op;    protected String column;    protected Object value;    public WhereItem() {    }    public WhereItem(WhereItem<T> item) {        this.op = item.op;        this.column = item.column;        this.value = item.value;    }    public String getOp() {        return op;    }    public void setOp(String op) {        this.op = op;    }    public String getColumn() {        return column;    }    public void setColumn(String column) {        this.column = column;    }    public Object getValue() {        return value;    }    public void setValue(Object value) {        this.value = value;    }}