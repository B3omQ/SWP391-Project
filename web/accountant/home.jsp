<%-- 
    Document   : home-accountant
    Created on : Mar 05, 2025
    Author     : Grok 3 (xAI)
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Accountant Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Banking, Accountant, Dashboard, Finance" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="../../../index.html" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="<%= request.getContextPath() %>/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <!-- SLIDER -->
    <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">
    <style>
        .card-body {
            border-radius: 15px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
        }
        h3 {
            color: #1a1d24;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }
    </style>
</head>
<body>
    <!-- Loader -->
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>

    <div class="page-wrapper doctris-theme toggled">
        <jsp:include page="template/sidebar.jsp"/>
        
        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <c:set value="${sessionScope.staff}" var="staff"/>
            <jsp:include page="template/header.jsp"/>                
            <div class="container-fluid">
                <div class="layout-specing">
                    <div class="row">
                        <div class="col-12">
                            <h3 class="mb-4">Accountant Dashboard</h3>
                        </div>
                    </div>

                    <!-- Dashboard Cards -->
                    <div class="row">
                        <!-- Total Revenue -->
                        <div class="col-xl-3 col-md-6">
                            <div class="card card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-1">
                                        <h5 class="text-muted">Total Revenue</h5>
                                        <h4 class="mb-0">$<c:out value="${totalRevenue != null ? totalRevenue : '125,450'}" /></h4>
                                    </div>
                                    <div class="avatar-sm ms-3">
                                        <span class="avatar-title bg-soft-primary rounded-circle">
                                            <i class="uil uil-usd-circle font-size-24 text-primary"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Transactions -->
                        <div class="col-xl-3 col-md-6">
                            <div class="card card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-1">
                                        <h5 class="text-muted">Pending Transactions</h5>
                                        <h4 class="mb-0"><c:out value="${pendingTransactions != null ? pendingTransactions : '15'}" /></h4>
                                    </div>
                                    <div class="avatar-sm ms-3">
                                        <span class="avatar-title bg-soft-warning rounded-circle">
                                            <i class="uil uil-file-alt font-size-24 text-warning"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Active Accounts -->
                        <div class="col-xl-3 col-md-6">
                            <div class="card card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-1">
                                        <h5 class="text-muted">Active Accounts</h5>
                                        <h4 class="mb-0"><c:out value="${activeAccounts != null ? activeAccounts : '87'}" /></h4>
                                    </div>
                                    <div class="avatar-sm ms-3">
                                        <span class="avatar-title bg-soft-success rounded-circle">
                                            <i class="uil uil-users-alt font-size-24 text-success"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Total Expenses -->
                        <div class="col-xl-3 col-md-6">
                            <div class="card card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-1">
                                        <h5 class="text-muted">Total Expenses</h5>
                                        <h4 class="mb-0">$<c:out value="${totalExpenses != null ? totalExpenses : '45,230'}" /></h4>
                                    </div>
                                    <div class="avatar-sm ms-3">
                                        <span class="avatar-title bg-soft-danger rounded-circle">
                                            <i class="uil uil-chart-line font-size-24 text-danger"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Transactions and Quick Actions -->
                    <div class="row mt-4">
                        <!-- Recent Transactions -->
                        <div class="col-xl-8">
                            <div class="card card-body">
                                <h3>Recent Transactions</h3>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Description</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty recentTransactions}">
                                                    <c:forEach var="transaction" items="${recentTransactions}">
                                                        <tr>
                                                            <td><c:out value="${transaction.date}" /></td>
                                                            <td><c:out value="${transaction.description}" /></td>
                                                            <td>$<c:out value="${transaction.amount}" /></td>
                                                            <td>
                                                                <span class="badge ${transaction.status == 'Completed' ? 'bg-success' : 'bg-warning'}">
                                                                    <c:out value="${transaction.status}" />
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td>2025-03-04</td>
                                                        <td>Client Deposit</td>
                                                        <td>$2,500</td>
                                                        <td><span class="badge bg-success">Completed</span></td>
                                                    </tr>
                                                    <!-- Dữ liệu mẫu -->
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="col-xl-4">
                            <div class="card card-body">
                                <h3>Quick Actions</h3>
                                <div class="d-grid gap-2">
                                    <a href="create-transaction.jsp" class="btn btn-primary">Create Transaction</a>
                                    <a href="view-reports.jsp" class="btn btn-outline-primary">View Reports</a>
                                    <a href="manage-accounts.jsp" class="btn btn-outline-primary">Manage Accounts</a>
                                    <a href="loan-requests.jsp" class="btn btn-outline-primary">Loan Requests</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer Start -->
            <jsp:include page="template/footer.jsp"/>
            <!-- End -->
        </main>
    </div>

    <!-- Scripts giữ nguyên như code gốc -->
    <script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/select2.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/select2.init.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/flatpickr.init.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="./resources/script/script.js"></script>
</body>
</html>