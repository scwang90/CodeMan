package ${packageName}.mapper;

import ${packageName}.model.api.Upload;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

/**
* 文件上传 mapper 接口
* @author ${author}
* @date ${.now?string("yyyy-MM-dd HH:mm:ss zzzz")}
*/
@Mapper
@Component
public interface UploadMapper {

    @Insert("INSERT INTO upload_file (token, name, type, path, create_time) VALUES (${r"#{token}"}, ${r"#{name}"}, ${r"#{type}"}, ${r"#{path}"}, ${r"#{time}"})")
    int insert(Upload file);

    @Select("SELECT id , token, name, type, path, create_time AS time FROM upload_file WHERE token=${r"#{token}"} LIMIT 1")
    Upload findByToken(@Param("token") String token);

}
