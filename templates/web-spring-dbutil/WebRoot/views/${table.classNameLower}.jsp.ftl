<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User</title>
    <script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div ng-app="app" ng-controller="main" ng-init="arrays=[{},{},{},{},{},{}]" class="container">
    <br/>
    <h1 style="text-align:center;">${table.remark}</h1>
    <br/>
    <table class="table table-hover table-bordered table-condensed table-striped">
        <thead>
        <tr>
        <#list table.columns as column>
            <th>${column.remark}</th>
        </#list>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="model in arrays">
        <#list table.columns as column>
            <th>{{mode.${column.fieldName}}}</th>
        </#list>
        </tr>
        </tbody>
    </table>
    <button ng-click="prev()">上一页</button>
    <button ng-click="next()">下一页</button>
</div>
</body>
<script>
    angular.module("app", []).controller('main',['$scope', '$http', function ($scope, $http) {
        $scope.index = 0;
        $scope.prev = function(){
            if($scope.index > 0){
                $http.post("list/10/"+(--$scope.index),{page:10}).success(function(res) {
                    console.log(res);
                    $scope.arrays = res.results;
                });
            }
        };
        $scope.next = function(){
            $http.post("list/10/"+(++$scope.index),{page:10}).success(function(res) {
                console.log(res);
                $scope.arrays = res.results;
            });
        };
        $scope.next();
    }]);
</script>
</html>
