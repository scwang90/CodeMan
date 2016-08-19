package com.codesmither.apidoc.impl;

import com.codesmither.apidoc.XmlApidocConfig;
import com.codesmither.apidoc.model.*;
import com.codesmither.apidoc.util.FormatUtil;
import com.codesmither.engine.api.IModelBuilder;
import com.codesmither.engine.api.IRootModel;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * Created by SCWANG on 2016/8/19.
 */
public class XmlApidocModelBuilder implements IModelBuilder {

    private static final String TAG_BODY = "bodyreplace";

    private XmlApidocConfig config;

    public XmlApidocModelBuilder(XmlApidocConfig config) {
        this.config = config;
    }

    @Override
    public IRootModel build() throws Exception {
        File file = new File(config.getXmlSourcePath());
        String charset = config.getXmlSourceCharset();
        StringBuilder builder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),charset))){
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
            }
        }
        String doc = builder.toString().replace("body", TAG_BODY).replace("&#x000A;", "<br/>");
        Element service = Jsoup.parse(doc).select("service").first();

        ApiService apiService = new ApiService();
        apiService.setName(service.attr("name"));
        apiService.setBasePath(service.attr("basePath"));
        apiService.setDescription(service.attr("description"));

        Element description = service.select(">description").first();
        if (description != null) {
            apiService.setDescription(description.html());
        }

        apiService.setModules(buildModules(service));
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

            Element description = service.select(">description").first();
            if (description != null) {
                apiModule.setDescription(description.html());
            }

            apiModule.setApis(buildApis(module));

            apiModules.add(apiModule);
        }
        return apiModules;
    }

    private List<Api> buildApis(Element module) {
        List<Api> apiList = new ArrayList<>();
        Elements apis = module.select(">api");
        for (Element api : apis) {
            Api apiMpdel = new Api();
            apiMpdel.setName(api.attr("name"));
            apiMpdel.setPath(api.attr("path"));
            apiMpdel.setDescription(api.attr("description"));
            apiMpdel.setRequestMethod(api.attr("requestMethod"));

            Element description = api.select(">description").first();
            if (description != null) {
                apiMpdel.setDescription(description.html());
            }
            apiMpdel.setBody(buildBody(api));
            apiMpdel.setResponse(buildResponse(api));
            apiMpdel.setHeaders(buildHeaders(api));
            apiMpdel.setParams(buildParams(api));

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
            apiHeader.setSample(header.attr("sample"));
            apiHeader.setNullable("true".equals(header.attr("nullable")));
            apiHeader.setDescription(header.attr("description"));

            Element description = header.select(">description").first();
            if (description != null) {
                apiHeader.setDescription(description.html());
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
                apiParam.setDescription(description.html());
            }

            apiParams.add(apiParam);
        }
        return apiParams;
    }

    private ApiBody buildBody(Element api) {
        Element body = api.select(">"+TAG_BODY).first();
        if (body != null) {
            ApiBody apiBody = new ApiBody();
            apiBody.setSample(body.text());
            apiBody.setContentType(body.attr("contentType"));

            if (apiBody.getContentType().toLowerCase().equals("json")) {
                apiBody.setSample(FormatUtil.formatJson(apiBody.getSample()));
            }
            return apiBody;
        }
        return null;
    }

    private ApiResponse buildResponse(Element api) {
        Element response = api.select(">response").first();
        if (response != null) {
            ApiResponse apiResponse = new ApiResponse();
            apiResponse.setSample(response.text());
            apiResponse.setContentType(response.attr("contentType"));

            if (apiResponse.getContentType().toLowerCase().equals("json")) {
                apiResponse.setSample(FormatUtil.formatJson(apiResponse.getSample()));
            }

            apiResponse.setHeaders(buildHeaders(response));

            return apiResponse;
        }
        return null;
    }

}
