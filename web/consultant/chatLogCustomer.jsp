<%-- 
    Document   : chatLogCustomer
    Created on : Mar 18, 2025, 7:47:38 AM
    Author     : LAPTOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <!-- DataTables CSS & jQuery -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <head>
        <meta charset="utf-8" />
        <title>SmartBanking</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
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
        <!-- Date picker -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/flatpickr.min.css">
        <link href="<%= request.getContextPath() %>/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- DataTables CSS & jQuery -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

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
        <!-- Loader -->
        <nav id="sidebar" class="sidebar-wrapper">
            <jsp:include page="template/sidebar.jsp"/>
            <!-- sidebar-content  -->
            <ul class="sidebar-footer list-unstyled mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                        <i class="uil uil-comment icons"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- sidebar-wrapper  -->

        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <jsp:include page="template/header.jsp"/>      
            <div class="container-fluid">
                <div class="layout-specing">
                    <h2 class="text-center">Lịch Sử Cuộc Trò Chuyện</h2>
                    <form id="chatHistoryForm" action="ChatLogCustomer" method="GET">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="customerId">Chọn Customer:</label>
                                <select id="customerId" name="senderId" class="form-control">
                                    <c:forEach var="customers" items="${customers}">
                                        <option value="${customers.id}">${customers.username}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <button class="btn btn-primary mt-4" onclick="fetchChatHistory()">Xem lịch sử</button>
                            </div>
                        </div>
                    </form>
                    <div class="chat-box mt-4">
                        <div id="chatMessages">
                            <c:forEach var="message" items="${chatHistory}">
                                <p><strong>${message.senderType}:</strong> ${message.message} <small>(${message.timestamp})</small></p>
                            </c:forEach>
                        </div>
                    </div>
                </div>

        <!-- Footer Start -->
        <jsp:include page="template/footer.jsp"/>
        <!-- End -->
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->

<!-- Offcanvas Start -->

<!-- javascript -->
<script src="<%= request.getContextPath() %>/assets/js/jquery.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
<!-- Select2 -->
<script src="<%= request.getContextPath() %>/assets/js/select2.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/select2.init.js"></script>
<!-- Datepicker -->
<script src="<%= request.getContextPath() %>/assets/js/flatpickr.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/flatpickr.init.js"></script>
<!-- Datepicker -->
<script src="<%= request.getContextPath() %>/assets/js/jquery.timepicker.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/timepicker.init.js"></script>
<!-- Icons -->
<script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="<%= request.getContextPath() %>/assets/js/app.js"></script>

</body>

</html>
