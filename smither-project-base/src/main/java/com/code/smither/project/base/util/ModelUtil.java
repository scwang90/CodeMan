package com.code.smither.project.base.util;

import com.code.smither.project.base.model.Table;
import com.code.smither.project.base.model.TableColumn;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 *
 *
 * @author SCWANG
 * @since 2022/11/28
 */
public class ModelUtil {

    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Map<Object,Boolean> seen = new ConcurrentHashMap<>();
        return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
    }

    public static List<Table> distinctTables(List<Table> tables) {
        return tables.stream().filter(distinctByKey(Table::getName)).collect(Collectors.toList());
    }

    public static List<TableColumn> distinctColumns(List<TableColumn> tables) {
        return tables.stream().filter(distinctByKey(TableColumn::getName)).collect(Collectors.toList());
    }

}
