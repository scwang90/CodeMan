<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${table.remark}</title>
    <script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div ng-app="app" ng-controller="main" ng-init="arrays=[{},{},{},{},{},{}]" class="container">
    <br/>
    <h1 style="text-align:center;">${table.remark}</h1>
    <br/>
    <div class="container" style="overflow-x: auto">
        <table class="table table-hover table-bordered table-condensed table-striped">
            <thead>
            <tr>
                <th ng-repeat="column in columns">
                    <div style="height:0px;color:transparent">{{column.replace($regex,"aa")}}<br/></div>
                    {{column}}
                </th>
            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="model in arrays">
                <td><input type="radio" name="model.${table.idColumn.fieldName}" ng-click="select(model.${table.idColumn.fieldName})" value="{{model.${table.idColumn.fieldName}}}" /></td>
            <#list table.columns as column>
                <td>
                    <#if column.type?upper_case?ends_with("TEXT") || column.type?upper_case?ends_with("CHAR")>
                    <div style="height:0px;color:transparent">{{model.${column.fieldName}.replace($regex,"aa")}}<br/></div>
                    </#if>
                    {{model.${column.fieldName}}}
                </td>
            </#list>
            </tr>
            </tbody>
        </table>
    </div>
    <button ng-click="prev()">上一页</button>
    <button ng-click="next()">下一页</button>
</div>
</body>
<script>
    angular.module("app", []).controller('main',['$scope', '$http', function ($scope, $http) {
        $scope.$index = -1;
        $scope.$regex = /[^\x00-\xff]/g;
        $scope.columns = [
            "选择"
            <#list table.columns as column>
            ,"${column.remark}"
            </#list>
        ];
        $scope.prev = function(){
            if($scope.$index > 0){
                $http.post("list/10/"+(--$scope.$index),{page:10}).success(function(res) {
                    console.log(res);
                    $scope.arrays = res.result.datas;
                });
            }
        };
        $scope.next = function(){
            $http.post("list/10/"+(++$scope.$index),{page:10}).success(function(res) {
                console.log(res);
                $scope.arrays = res.result.datas;
            });
        };
        $scope.next();
    }]);
</script>
</html>
