<!DOCTYPE html>
<html lang="zh-CN" style="font-size: 16px;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${displayName}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="icon" href="http://www.yunpian.com/favicon.ico">
    <link rel="stylesheet" href="./res/reset.css">
    <link rel="stylesheet" href="./res/index.css">
    <link rel="stylesheet" href="./res/api.css">
    <style>
        .apileft ul li .selected {
            background-color: #0000;
            color: #3286c1;
            font-weight: bold;
        }
    </style>
</head>
<body>
<header id="top" class="clearfix">
    <div class="top clearfix">
        <div class="logo">
            <img src="./res/yunpian.png">
        </div>
        <nav class="top-nav">
            <ul class="top-nav-ul item clearfix">
                <li><a class="" href="index.html">首页</a></li>
                <li class="mob-hide"><a class=" active " href="#">API 文档</a></li>
            </ul>
        </nav>
    </div>
</header>


<div id="tpl" class="main">
    <nav class="apileft">
    <#list modules as module>
        <h2 class="cos">
            <a href="${module.name}.html"
               class="item ${(module.name==moduleName)?string("active","")}">${module.displayName}</a>
            <ul class="sub-nav" ${(module.name==moduleName)?string("style='display: block;'","")}>
                <#list module.apis as api>
                    <li><a href="javascript:void(0)" id="${api.id}">${api.name}</a></li>
                </#list>
            </ul>
        </h2>
    </#list>
    </nav>
    <div class="content">
        <article class="doc">
            <section class="one">
            <#if module.description?? && (module.description?length > 0)>
                <h3>${module.displayName}</h3>
                <p>${module.description}</p>
            </#if>

            <#list module.apis as api>
            <div id="${api.id}" class="api-div">
                <div class="frame">
                    <h3>${api?counter}、${api.name}</h3>
                    <#if api.description?? && (api.description?length > 0)>
                        <p>${api.description}</p>
                    </#if>
                    <#if api.path?? && (api.path?length > 0)>
                        <p><b>接口链接</b></p>
                        <code>
                        ${api.requestMethod}：${api.url}
                        </code>
                    </#if>
                    <#if api.headers?? && (api.headers?size > 0) >
                        <p><b>头部（Header）：</b></p>
                        <div class="can">
                            <table>
                                <tbody>
                                <tr>
                                    <th>参数名</th>
                                    <th>类型</th>
                                    <th>是否必须</th>
                                    <th>描述</th>
                                    <th>示例</th>
                                </tr>
                                    <#list api.headers as header>
                                    <tr>
                                        <td>${header.name}</td>
                                        <td>${header.type}</td>
                                        <td>${header.nullable?string("否","是")}</td>
                                        <td>${header.description}</td>
                                        <td>${header.example}</td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </#if>
                    <#if api.params?? && (api.params?size > 0) >
                        <p><b>参数（Url）：</b></p>
                        <div class="can">
                            <table>
                                <tbody>
                                <tr>
                                    <th>参数名</th>
                                    <th>类型</th>
                                    <th>是否必须</th>
                                    <th>描述</th>
                                    <th>示例</th>
                                </tr>
                                    <#list api.params as param>
                                    <tr>
                                        <td>${param.name}</td>
                                        <td>${param.type}</td>
                                        <td>${param.nullable?string("否","是")}</td>
                                        <td>${param.description}</td>
                                        <td>${param.example}</td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </#if>
                    <#if api.forms?? && (api.forms?size > 0) >
                        <p><b>表单(Form) ：</b></p>
                        <div class="can">
                            <table>
                                <tbody>
                                <tr>
                                    <th>参数名</th>
                                    <th>类型</th>
                                    <th>是否必须</th>
                                    <th>描述</th>
                                    <th>示例</th>
                                </tr>
                                    <#list api.forms as form>
                                    <tr>
                                        <td>${form.name}</td>
                                        <td>${form.type}</td>
                                        <td>${form.nullable?string("否","是")}</td>
                                        <td>${form.description}</td>
                                        <td>${form.example}</td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </#if>
                    <#if api.body?? && api.body.example??>
                        <p><b>Body数据：【${api.body.contentType}】</b></p>
                        <#if api.body.contentType?lower_case=="xml">
                            <pre><code>${api.body.example?html}</code></pre>
                        <#else>
                            <pre><code>${api.body.example}</code></pre>
                        </#if>

                    </#if>
                    <#if api.response?? && api.response.headers?? && (api.response.headers?size > 0) >
                        <p><b>调用成功的返回值头部(Header) ：</b></p>
                        <div class="can">
                            <table>
                                <tbody>
                                <tr>
                                    <th>参数名</th>
                                    <th>类型</th>
                                    <th>是否必须</th>
                                    <th>描述</th>
                                    <th>示例</th>
                                </tr>
                                    <#list api.response.headers as header>
                                    <tr>
                                        <td>${header.name}</td>
                                        <td>${header.type}</td>
                                        <td>${header.nullable?string("否","是")}</td>
                                        <td>${header.description}</td>
                                        <td>${header.example}</td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </#if>
                    <#if api.response?? && api.response.example??>
                        <p><b>调用成功的返回值示例：【${api.response.contentType}】</b></p>
                        <#if api.response.contentType?lower_case=="xml">
                            <pre><code>${api.response.example?html}</code></pre>
                        <#else>
                            <pre><code>${api.response.example}</code></pre>
                        </#if>
                    </#if>
                </div>
            </#list>
            </div>
            </section>
        </article>
    </div>
</div>
<script type="text/javascript" src="./res/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
    (function ($) {
        $('nav.apileft').find('.item.active').hover(function () {
            $(this).css({'background': '#3286c1', 'color': '#fff'});
        });
        $("nav.apileft li>a").click(function () {
            $("nav.apileft li>a").removeClass("selected");
            var id = $(this).addClass("selected").attr('id');
            $(".api-div").each(function () {
                if ($(this).attr('id') == id) {
                    $(this).find("div.frame").show();
                } else {
                    $(this).find("div.frame").hide();
                }
            });
        });
    })(jQuery);
</script>
</body>
</html>