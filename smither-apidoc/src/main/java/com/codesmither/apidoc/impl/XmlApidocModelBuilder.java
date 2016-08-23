package com.codesmither.apidoc.impl;

import com.codesmither.apidoc.XmlApidocConfig;
import com.codesmither.apidoc.model.*;
import com.codesmither.apidoc.util.FormatUtil;
import com.codesmither.engine.api.IModelBuilder;
import com.codesmither.engine.api.IRootModel;
import com.codesmither.engine.util.Reflecter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.TextNode;
import org.jsoup.parser.Parser;
import org.jsoup.parser.Tag;
import org.jsoup.parser.XmlTreeBuilder;
import org.jsoup.select.Elements;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * Created by SCWANG on 2016/8/19.
 */
public class XmlApidocModelBuilder implements IModelBuilder {

    private static final String TAG_BODY = "body";
    private static final String TAG_FORM = "form";

    private XmlApidocConfig config;

    public XmlApidocModelBuilder(XmlApidocConfig config) {
        this.config = config;
    }

    @Override
    public IRootModel build() throws Exception {
        ApiService apiService = new ApiService();

        checkJsonpTag("body");
        checkJsonpTag("description");
        checkJsonpTag("apidescription");

        try (InputStream input = new FileInputStream(config.getXmlSourcePath())) {
            Element service = Jsoup.parse(input, config.getXmlSourceCharset(), "", new Parser(new XmlTreeBuilder())).select("service").first();

            apiService.setName(service.attr("name"));
            apiService.setBasePath(service.attr("basePath"));
            apiService.setDescription(service.attr("description"));

            Element description = service.select(">description").first();
            if (description != null) {
                apiService.setDescription(getHtml(description));
            }
            apiService.setModules(buildModules(service));
        }


//        File file = new File(config.getXmlSourcePath());
//        String charset = config.getXmlSourceCharset();
//        StringBuilder builder = new StringBuilder();
//        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),charset))){
//            String line;
//            while ((line = reader.readLine()) != null) {
//                builder.append(line);
//            }
//        }
//        String doc = builder.toString();//.replace("body", TAG_BODY).replace("form", TAG_FORM).replace("&#x000A;", "<br/>");
//        Element service = Jsoup.parse(doc,"",new Parser(new XmlTreeBuilder())).select("service").first();


        return apiService;
    }

    private List<ApiModule> buildModules(Element service) {
        List<ApiModule> apiModules = new ArrayList<>();
        Elements modules = service.select(">module");
        for (Element module : modules) {
            ApiModule apiModule = new ApiModule();
            apiModule.setName(module.attr("name"));
            apiModule.setPath(module.attr("path"));
            apiModule.setDescription(module.attr("description"));

            Element description = module.select(">description").first();
            if (description != null) {
                apiModule.setDescription(getHtml(description));
            }

            apiModule.setApis(buildApis(module));

            apiModules.add(apiModule);
        }
        return apiModules;
    }

    private List<Api> buildApis(Element module) {
        List<Api> apiList = new ArrayList<>();
        Elements apis = module.select(">*");
        for (Element api : apis) {
            Api apiMpdel = new Api();
            apiMpdel.setName(api.attr("name"));

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

//        Elements apidescriptions = module.select(">apidescription");
//        for (Element apidescription : apidescriptions) {
//            Api apiMpdel = new Api();
//            apiMpdel.setName(apidescription.attr("name"));
//            apiMpdel.setDescription(getHtml(apidescription));
//            apiList.add(apiMpdel);
//        }

        return apiList;
    }

    private List<ApiHeader> buildHeaders(Element api) {
        List<ApiHeader> apiHeaders = new ArrayList<>();
        Elements headers = api.select(">header");
        for (Element header : headers) {
            ApiHeader apiHeader = new ApiHeader();
            apiHeader.setName(header.attr("name"));
            apiHeader.setType(header.attr("type"));
            apiHeader.setSample(header.attr("sample"));
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
            apiParam.setSample(param.attr("sample"));
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
            apiForm.setSample(form.attr("sample"));
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
            apiBody.setSample(body.attr("sample"));
            apiBody.setContentType(body.attr("contentType"));

            String text = body.text();
            if (text != null && text.length() > 0) {
                apiBody.setSample(text);
            }
            if (apiBody.getContentType().toLowerCase().equals("json")) {
                apiBody.setSample(FormatUtil.formatJson(apiBody.getSample()));
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

    private ApiResponse buildResponse(Element api) {
        Element response = api.select(">response").first();
        if (response != null) {
            ApiResponse apiResponse = new ApiResponse();
            apiResponse.setSample(response.attr("sample"));
            apiResponse.setContentType(response.attr("contentType"));

            String text = response.text();
            if (text != null && text.length() > 0) {
                apiResponse.setSample(text);
            }
            if (apiResponse.getContentType().toLowerCase().equals("json")) {
                apiResponse.setSample(FormatUtil.formatJson(apiResponse.getSample()));
            }
//            if (apiResponse.getContentType().toLowerCase().equals("xml")) {
//                Element cresponse = response.clone();
//                cresponse.select("header").remove();
//                String html = cresponse.html();
//                if (html != null && html.length() > 0) {
//                    apiResponse.setSample(html);
//                }
//            } else {
//            }

            apiResponse.setHeaders(buildHeaders(response));

            return apiResponse;
        }
        return null;
    }

    private static String getHtml(Element description) {
        return description.text().replaceAll("(\\s*\\n)+","<br/>");//html().replace("&lt;","<").replace("&gt;",">").replace("&#10;","<br/>");
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
