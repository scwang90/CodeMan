package com.code.smither.apidoc.impl;

import com.code.smither.apidoc.XmlApiDocConfig;
import com.code.smither.apidoc.model.*;
import com.code.smither.apidoc.util.FormatUtil;
import com.code.smither.engine.api.ModelBuilder;
import com.code.smither.engine.api.RootModel;
import com.code.smither.engine.util.Reflecter;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.parser.Tag;
import org.jsoup.parser.XmlTreeBuilder;
import org.jsoup.select.Elements;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by SCWANG on 2016/8/19.
 */
public class XmlApidocModelBuilder implements ModelBuilder {

    private static final String TAG_BODY = "body";
    private static final String TAG_FORM = "form";
    private static final String KEY_CANCEL = "cancel";

    private XmlApiDocConfig config;

    public XmlApidocModelBuilder(XmlApiDocConfig config) {
        this.config = config;
    }

    @Override
    public RootModel build() throws Exception {
        ApiService apiService = new ApiService();

        checkJsonpTag("body");
        checkJsonpTag("description");
        checkJsonpTag("apidescription");

        try (InputStream input = new FileInputStream(config.getXmlSourcePath())) {
            Element service = Jsoup.parse(input, config.getXmlSourceCharset(), "", new Parser(new XmlTreeBuilder())).select("service").first();

            apiService.setName(service.attr("name"));
            apiService.setDisplayName(service.attr("displayName"));
            apiService.setBasePath(service.attr("basePath"));
            apiService.setDescription(service.attr("description"));

            Element description = service.select(">description").first();
            if (description != null) {
                apiService.setDescription(getHtml(description));
            }
            apiService.setHeaders(buildHeaders(service));
            apiService.setModules(buildModules(service));
        }

        if (apiService.getDisplayName() == null || apiService.getDisplayName().isEmpty()) {
            apiService.setDisplayName(apiService.getName());
        }
        List<ApiHeader> serviceHeaders = apiService.getHeaders();
        for (ApiModule apiModule : apiService.getModules()) {
            if (apiModule.getDisplayName() == null || apiModule.getDisplayName().isEmpty()) {
                apiModule.setDisplayName(apiModule.getName());
            }
            List<ApiHeader> moduleHeaders = apiModule.getHeaders();
            for (Api api : apiModule.getApis()) {
                Map<String, ApiHeader> headers = new LinkedHashMap<>();
                List<ApiHeader> apiHeaders = api.getHeaders();
                convertHeaders(headers, serviceHeaders);
                convertHeaders(headers, moduleHeaders);
                convertHeaders(headers, apiHeaders);
                api.setHeaders(new ArrayList<>(headers.values()));
                api.setUrl(buildApiUrl(api, apiService, apiModule));
            }
        }

        return apiService;
    }

    private String buildApiUrl(Api api, ApiService service, ApiModule module) {
        if (api.getPath() == null || api.getPath().startsWith("http://")) {
            return api.getPath();
        }
        if (api.getPath().startsWith("/")) {
            int index = service.getBasePath().indexOf('/');
            if (service.getBasePath().startsWith("http://")) {
                index = service.getBasePath().indexOf('/', "http://".length());
            }
            if (index > 0) {
                return service.getBasePath().substring(0, index) + api.getPath();
            }
            return service.getBasePath() + api.getPath();
        }
        if (module.getPath().startsWith("/")) {
            int index = service.getBasePath().indexOf('/');
            if (service.getBasePath().startsWith("http://")) {
                index = service.getBasePath().indexOf('/', "http://".length());
            }
            if (index > 0) {
                return service.getBasePath().substring(0, index) + module.getPath() + api.getPath();
            }
        }
        return service.getBasePath() + module.getPath() + api.getPath();
    }

    private void convertHeaders(Map<String, ApiHeader> headers, List<ApiHeader> apiHeaders) {
        for (ApiHeader header : apiHeaders) {
            if (KEY_CANCEL.equals(header.getType())) {
                headers.remove(header.getName());
            } else {
                headers.put(header.getName(), header);
            }
        }
    }

    private List<ApiModule> buildModules(Element service) throws JsonProcessingException {
        List<ApiModule> apiModules = new ArrayList<>();
        Elements modules = service.select(">module");
        for (Element module : modules) {
            ApiModule apiModule = new ApiModule();
            apiModule.setName(module.attr("name"));
            apiModule.setDisplayName(module.attr("displayName"));
            apiModule.setPath(module.attr("path"));
            apiModule.setAssistant(module.attr("assistant"));
            apiModule.setDescription(module.attr("description"));

            Element description = module.select(">description").first();
            if (description != null) {
                apiModule.setDescription(getHtml(description));
            }

            apiModule.setHeaders(buildHeaders(module));
            apiModule.setApis(buildApis(module));

            apiModules.add(apiModule);
        }
        return apiModules;
    }

    private List<Api> buildApis(Element module) throws JsonProcessingException {
        List<Api> apiList = new ArrayList<>();
        Elements apis = module.select(">*");
        for (Element api : apis) {
            Api apiMpdel = new Api();
            apiMpdel.setName(api.attr("name"));
            //防止空指针
            apiMpdel.setHeaders(new ArrayList<ApiHeader>());

            if ("api".equals(api.tag().getName())) {
                apiMpdel.setPath(api.attr("path"));
                apiMpdel.setDescription(api.attr("description"));
                apiMpdel.setRequestMethod(api.attr("requestMethod"));

                Element description = api.select(">description").first();
                if (description != null) {
                    apiMpdel.setDescription(getHtml(description));
                }
                apiMpdel.setBody(buildBody(api));
                apiMpdel.setResponse(buildResponse(api));
                apiMpdel.setHeaders(buildHeaders(api));
                apiMpdel.setParams(buildParams(api));
                apiMpdel.setForms(buildForms(api));
            } else if ("apidescription".equals(api.tag().getName())) {
                apiMpdel.setDescription(getHtml(api));
            }

            apiList.add(apiMpdel);
        }

        return apiList;
    }

    private List<ApiHeader> buildHeaders(Element api) {
        List<ApiHeader> apiHeaders = new ArrayList<>();
        Elements headers = api.select(">header");
        for (Element header : headers) {
            ApiHeader apiHeader = new ApiHeader();
            apiHeader.setName(header.attr("name"));
            apiHeader.setType(header.attr("type"));
            apiHeader.setExample(header.attr("example"));
            apiHeader.setNullable("true".equals(header.attr("nullable")));
            apiHeader.setDescription(header.attr("description"));

            Element description = header.select(">description").first();
            if (description != null) {
                apiHeader.setDescription(getHtml(description));
            }

            apiHeaders.add(apiHeader);
        }
        return apiHeaders;
    }

    private List<ApiParam> buildParams(Element api) {
        List<ApiParam> apiParams = new ArrayList<>();
        Elements params = api.select(">param");
        for (Element param : params) {
            ApiParam apiParam = new ApiParam();
            apiParam.setName(param.attr("name"));
            apiParam.setType(param.attr("type"));
            apiParam.setExample(param.attr("example"));
            apiParam.setNullable("true".equals(param.attr("nullable")));
            apiParam.setDescription(param.attr("description"));

            Element description = param.select(">description").first();
            if (description != null) {
                apiParam.setDescription(getHtml(description));
            }

            apiParams.add(apiParam);
        }
        return apiParams;
    }

    private List<ApiForm> buildForms(Element api) {
        List<ApiForm> apiForms = new ArrayList<>();
        Elements forms = api.select(">" + TAG_FORM);
        for (Element form : forms) {
            ApiForm apiForm = new ApiForm();
            apiForm.setName(form.attr("name"));
            apiForm.setType(form.attr("type"));
            apiForm.setExample(form.attr("example"));
            apiForm.setNullable("true".equals(form.attr("nullable")));
            apiForm.setDescription(form.attr("description"));

            Element description = form.select(">description").first();
            if (description != null) {
                apiForm.setDescription(getHtml(description));
            }

            apiForms.add(apiForm);
        }
        return apiForms;
    }

    private ApiBody buildBody(Element api) {
        Element body = api.select(">"+TAG_BODY).first();
        if (body != null) {
            ApiBody apiBody = new ApiBody();
            apiBody.setExample(body.attr("example"));
            apiBody.setContentType(body.attr("contentType"));

            String text = body.text();
            if (text != null && text.length() > 0) {
                apiBody.setExample(text);
            }
            if (apiBody.getContentType().toLowerCase().equals("json")) {
                apiBody.setExample(FormatUtil.formatJson(apiBody.getExample()));
            }
//            if (apiBody.getContentType().toLowerCase().equals("xml")) {
//                String html = body.html();
//                if (html != null && html.length() > 0) {
//                    apiBody.setSample(html);
//                }
//            } else {
//            }
            return apiBody;
        }
        return null;
    }

    private ApiResponse buildResponse(Element api) throws JsonProcessingException {
        Element response = api.select(">response").first();
        if (response != null) {
            ApiResponse apiResponse = new ApiResponse();
            apiResponse.setExample(response.attr("example"));
            apiResponse.setContentType(response.attr("contentType"));

            String text = response.text();
            if (text != null && text.length() > 0) {
                apiResponse.setExample(text);
                if ("json".equalsIgnoreCase(apiResponse.getContentType())) {
                    apiResponse.setExample(FormatUtil.formatJson(apiResponse.getExample()));
                }
            }

            Element xml = response.select(">xml").first();
            if (xml != null) {
                apiResponse.setExample(xml.outerHtml());
                if ("json".equalsIgnoreCase(apiResponse.getContentType())) {
                    apiResponse.setExample(FormatUtil.formatJson(new ObjectMapper().writeValueAsString(xmlToMap(xml.outerHtml()))));
                }
            }

            apiResponse.setHeaders(buildHeaders(response));

            return apiResponse;
        }
        return null;
    }

    private Object xmlToMap(String xml) {
        return parseElement(Jsoup.parse(xml).select("body>xml").first());
    }

    private Object parseElement(Element root) {
        Elements children = root.children();
        if (children.size() > 0) {
            Map<String, Object> map = new LinkedHashMap<>();
            for (Element element : children) {
                map.put(element.attr("name"), parseElement(element));
            }
            return map;
        } else {
            String data = root.text();
            try {
                return Integer.parseInt(data);
            } catch (NumberFormatException ignored) {
            }
            try {
                return Float.parseFloat(data);
            } catch (NumberFormatException ignored) {
            }
            try {
                return Boolean.parseBoolean(data);
            } catch (NumberFormatException ignored) {
            }
            return data;
        }
    }

    private static String getHtml(Element description) {
        String text = description.text();
        if (text.indexOf('<') > -1 && text.indexOf('>') > text.indexOf('<')) {
            return text;
        }
        return text.replaceAll("(\\s*\\n)+","<br/>");//html().replace("&lt;","<").replace("&gt;",">").replace("&#10;","<br/>");
//        Pattern pattern = Pattern.compile("^<[^>]+>((.*\\n?)*)</\\w+>$");
//        Matcher matcher = pattern.matcher(description.toString());
//        if (matcher.find()) {
//            return matcher.group(1);
//        }
//        return description.html();
    }

    private static void checkJsonpTag(String tag) {
        if (!Tag.isKnownTag(tag)) {
            Tag apiTag = Tag.valueOf(tag);
            Reflecter.setMemberNoException(apiTag, "preserveWhitespace", true);
            Reflecter.doStaticMethod(Tag.class, "register", apiTag);
        }
    }

}
