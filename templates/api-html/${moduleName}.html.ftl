<!DOCTYPE html>
<html lang="zh-CN" style="font-size: 16px;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${name}</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">

    <link rel="icon" href="http://www.yunpian.com/favicon.ico">
    <link rel="stylesheet" href="./res/reset.css">
    <link rel="stylesheet" href="./res/index.css">
    <link rel="stylesheet" href="./res/api.css">
</head>

<#macro single_line>
    <@compress single_line=true>
    <#nested>
    </@compress>
</#macro>

<body>
<header id="top" class="clearfix">
    <div class="top clearfix">
        <div class="logo">
            <img src="./res/yunpian.png">
        </div>
        <nav class="top-nav">
            <ul class="top-nav-ul item clearfix">
                <li><a class="" href="#">首页</a></li>
                <li class="p-r " id="yun_hover">
                    <a class="" href="javascript:void(0);">产品</a>
                </li>
                <li class="mob-hide"><a class=" active " href="#">API 文档</a></li>
            </ul>
        </nav>
    </div>
</header>


<div id="tpl" class="main">
    <nav class="apileft">

        <#list modules as module>
            <h2 class="cos">
                <@single_line><a href="${module.name}.html" class="item
                    <#if module.name==moduleName>
                        active
                    </#if>
                ">${module.name}</a>
                </@single_line>

                <@single_line><ul class="sub-nav"
                    <#if module.name==moduleName>
                        style="display: block;"
                    </#if>
                >
                </@single_line>

                <#list module.apis as api>
                    <li><a href="#${api.id}">${api.name}</a></li>
                </#list>
                </ul>
            </h2>
        </#list>
    </nav>
    <div class="content">
        <h2 class="page-title">${moduleName}</h2>
        <article class="doc">
            <section class="one">
                <#list module.apis as api>
                <h3 id="${api.id}">${api_index+1}、${api.name}</h3>
                    <br/>
                <#if api.description?? && (api.description?length > 0)>
                    <p>${api.description}</p>
                </#if>
                <code>
                ${api.requestMethod}：${basePath}${module.path}${api.path}
                </code>
                <#if api.params?? && (api.params?size > 0) >
                <p>参数：</p>
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
                            <td><#if !param.nullable>是</#if></td>
                            <td>${param.description}</td>
                            <td>${param.sample}</td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
                </#if>
                <#if api.body?? && api.body.sample??>
                    <p>Body数据：【${api.body.contentType}】</p>
                    <pre><code>${api.body.sample}</code></pre>
                </#if>
                <#if api.response?? && api.response.sample??>
                    <p>调用成功的返回值示例：【${api.response.contentType}】</p>
                    <pre><code>${api.response.sample}</code></pre>
                </#if>
                </#list>
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
    })(jQuery);
</script>
</body>
</html>