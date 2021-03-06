<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>BLOG | YOUR BEST CHOICE</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <link rel="stylesheet" type="text/css" href="${basePath}/resources/plugins/metronic/plugins/select2/select2.css">
    <%@ include file="./../common/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${basePath}/resources/plugins/metronic/css/dataTables.bootstrap.css">
</head>
<body class="page-md">
<%@ include file="./../common/header.jsp" %>
<!-- BEGIN PAGE CONTAINER -->
<div class="page-container">
    <!-- BEGIN PAGE HEAD -->
    <div class="page-head">
        <div class="container">
            <!-- BEGIN PAGE TITLE -->
            <div class="page-title">
                <h1>博客搜索
                    <small>love & peace</small>
                </h1>
            </div>
            <!-- END PAGE TITLE -->
        </div>
    </div>
    <!-- END PAGE HEAD -->
    <!-- BEGIN PAGE CONTENT -->
    <div class="page-content">
        <div class="container">
            <!-- BEGIN PAGE BREADCRUMB -->
            <ul class="page-breadcrumb breadcrumb">
                <li>
                    <a href="<c:url value="/"/>" style="color: #5b9bd1">Home</a><i class="fa fa-circle"></i>
                </li>
                <li class="active">
                    博客搜索
                </li>
            </ul>
            <!-- END PAGE BREADCRUMB -->
            <!-- BEGIN PAGE CONTENT INNER -->
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-gift font-green-sharp"></i>
                                <span class="caption-subject font-green-sharp bold uppercase">博客搜索</span>
                                <span class="caption-helper">博客搜索结果</span>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="table-container">
                                <div class="table-actions-wrapper">
                                    <label class="control-label">博客标题</label>
                                    <input class="table-group-action-input form-control input-inline input-small input-sm" type="text" id="title" value="${title}"/>
                                    <button class="btn btn-sm yellow table-group-action-submit"><i class="fa fa-check"></i> Search</button>
                                </div>
                                <table class="table table-striped table-bordered table-hover" id="datatable_ajax">
                                    <thead>
                                    <tr role="row" class="heading">
                                        <th width="35%">
                                            博客标题
                                        </th>
                                        <th width="28%">
                                            创建时间
                                        </th>
                                        <th width="27%">
                                            作者
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- End: life time stats -->
                </div>
            </div>
            <!-- END PAGE CONTENT INNER -->
        </div>
    </div>
    <!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->
<%@ include file="./../common/preFooter.jsp" %>
<%@ include file="./../common/footer.jsp" %>
<div class="scroll-to-top">
    <i class="icon-arrow-up"></i>
</div>
<script src="${basePath}/resources/plugins/metronic/script/jquery.dataTables.js" type="text/javascript"></script>
<script src="${basePath}/resources/plugins/metronic/script/dataTables.bootstrap.js" type="text/javascript"></script>
<script src="${basePath}/resources/plugins/metronic/script/datatable.js" type="text/javascript"></script>
<script src="${basePath}/resources/scripts/blog/blogSearchList.js" type="text/javascript"></script>
<script>
    jQuery(document).ready(function() {
        TableAjax.init();
    });
</script>
</body>
</html>