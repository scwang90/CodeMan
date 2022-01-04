package ${packageName}.mapper;

import ${packageName}.model.api.Upload;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

/**
 * 文件上传 mapper 接口
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Mapper
@Component
public interface UploadMapper {

    @Insert("INSERT INTO upload_file (id, name, size, type, path, mime_type, time) VALUES (${r"#"}{id}, ${r"#"}{name}, ${r"#"}{size}, ${r"#"}{type}, ${r"#"}{path}, ${r"#"}{mimeType}, ${r"#"}{time})")
    int insert(Upload file);

    @Select("SELECT * FROM upload_file WHERE id=${r"#"}{id} LIMIT 1")
    Upload findById(@Param("id") Object id);

    @Delete("DELETE FROM upload_file WHERE id=${r"#"}{id}")
    int deleteById(@Param("id") Object id);

}
