package @{packageName}.api;

<#macro single_line>
    <@compress single_line=true>
        <#nested>
    </@compress>

</#macro>

public interface SrviceApi {

<#list modules as module>
    <#list module.apis as api>
        <#if ((module.path?length>0) || (api.path?length>0)) >
            <#if api.forms?? && (api.forms?size > 0) >
    @FormUrlEncoded
            </#if>
    @POST("${module.path}${api.path}")
    Object ${module.path?replace("/","")}<#if (module.path?length>0) >${api.path?replace("/","")?cap_first}<#else>${api.path?replace("/","")}</#if>(<@single_line>
            <#if api.forms?? && (api.forms?size > 0) >
                <#list api.forms as form>
                @Field("${form.name}") ${form.type?replace("string","String")} ${form.name}<#if form_has_next>, </#if>
                </#list>
            </#if>
            <#if api.forms?? && (api.forms?size > 0) && api.params?? && (api.params?size > 0)>,</#if>
            <#if api.params?? && (api.params?size > 0) >
                <#list api.params as param>
                @Field("${param.name}") ${param.type?replace("string","String")} ${param.name}<#if param_has_next>, </#if>
                </#list>
            </#if>);
        </@single_line>

        </#if>
    </#list>
</#list>

}