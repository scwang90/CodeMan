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
* @author ${author}
* @since ${now?string("yyyy-MM-dd zzzz")}
*/
@Mapper
@Component
public interface UploadMapper {

    @Insert("INSERT INTO upload_file (id, name, type, path, mime_type, time) VALUES (${r"#"}{id}, ${r"#"}{name}, ${r"#"}{type}, ${r"#"}{path}, ${r"#"}{mimeType}, ${r"#"}{time})")
    int insert(Upload file);

    @Select("SELECT * FROM upload_file WHERE id=${r"#"}{id} LIMIT 1")
    Upload findById(@Param("id") String id);

    @Delete("DELETE FROM upload_file WHERE id=${r"#"}{id}")
    int deleteById(@Param("id") String id);

}
