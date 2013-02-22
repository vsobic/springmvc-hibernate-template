<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html ng-app>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${pageContext.request.contextPath}/web/assets/js/jquery-1.7.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/web/assets/js/angular-1.0.0rc6.js"></script>
    <script src="${pageContext.request.contextPath}/web/views/customers.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/web/assets/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web/views/customers.css"/>

</head>
<body>
<script language="javascript" type="text/javascript">
    <!--
    $(function () {
        utils.setup('${pageContext.request.contextPath}');
    });

    //-->
</script>

<div ng-controller="CustomerCtrl">

    <div style=" z-index: -21; float: left;padding-top :10px; padding:10px;min-width: 250px;max-width:300px;  ">
        <form class="well form-search" ng-submit="search()">
                <div>
                    <input type="text" id="search" class="input-medium search-query" ng-model="query"/>
                    <a href="#" class="icon-search" ng-click="search()"></a>
                </div>
                <div style="padding-top: 10px;">
                    <div ng-show=" !searchResultsFound()">
                        <span class="no-records">(no results)</span>
                    </div>

                    <div ng-show=" searchResultsFound()">

                        <div ng-repeat="customer in customers" class="search-results">
                            <span class="title">
                                <span style="font-size: smaller"><span>#</span>{{customer.id}}</span>
                                <a ng-click="load(customer)">{{customer.firstName}} {{customer.lastName}}</a> </span>
                        </div>

                    </div>
                </div>
            </form>
    </div>
<%--

    <div>
        <form class="well form-search" ng-submit="lookupCustomer()">
            <label> Search by Name</label>
            <input type="text" ng-model="name" class="input-medium search-query" width="5" size="5"
                   placeholder="customer name">
            <button type="submit" class="btn btn-primary" ng-click="lookupCustomer()">
                <a class="icon-search"></a>
            </button>
        </form>
    </div>--%>

    <form class="form-horizontal" ng-submit="updateCustomer">
        <fieldset>
            <legend>
                <span class="customer-visible-{{!isCustomerLoaded()}}"> Create New Customer </span>
                <span class="customer-visible-{{isCustomerLoaded()}}"> Update {{customer.firstName}} {{customer.lastName}} - {{customer.id}} </span>
            </legend>
            <div class="control-group">
                <label class="control-label" for="fn">First Name:</label>

                <div class="controls">
                    <input class="input-xlarge" id="fn" type="text" ng-model="customer.firstName"
                           placeholder="first name" required="required"/>

                    <p class="help-block">Change the first name</p>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="ln">Last Name:</label>

                <div class="controls">
                    <input class="input-xlarge" id="ln" type="text" ng-model="customer.lastName" placeholder="last name"
                           required="required"/>

                    <p class="help-block">Change the last name</p>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary" ng-click="save()" ng-model-instant>
                    <a class="icon-plus"></a> Save
                </button>
                <button class="btn " ng-click="trash()"><a class="icon-trash"></a> Cancel</button>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>