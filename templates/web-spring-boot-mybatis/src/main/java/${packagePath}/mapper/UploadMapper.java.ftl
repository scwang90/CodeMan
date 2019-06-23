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
* @since ${.now?string("yyyy-MM-dd zzzz")}
*/
@Mapper
@Component
public interface UploadMapper {
                                                                            
    @Insert("INSERT INTO upload_file (id, name, type, path, media_type, create_time, update_time) VALUES (${r"#{token}"}, ${r"#{name}"}, ${r"#{type}"}, ${r"#{mimeType}"}, ${r"#{path}"}, ${r"#{time}"}, ${r"#{time}"})")
    int insert(Upload file);

    @Select("SELECT id AS token, name, type, path, media_type AS mimeType, create_time AS time FROM upload_file WHERE id=${r"#{token}"} LIMIT 1")
    Upload findByToken(@Param("token") String token);

    @Delete("DELETE FROM upload_file WHERE id=${r"#{token}"}")
    int deleteByToken(@Param("token") String token);

}
