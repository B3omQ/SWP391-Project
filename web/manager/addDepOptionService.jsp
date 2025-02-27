<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

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
        <!-- Icons -->
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css">



    </head>
    <style>

    </style>

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

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="template/sidebar.jsp"/>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">   

                <c:set value="${sessionScope.staff}" var="staff"/>
                <jsp:include page="template/header.jsp"/>               


                <div class="container-fluid">                    

                    <div class="layout-specing">
                        
                        <form action="add-saving-option" method="POST">
                            <div class="row align-items-center">
                                <!-- Title & Breadcrumb -->
                                <div class="row mt-2">
                                    <div class="col-md-6">
                                        <label class="form-label head" for="minimumDep">Deposite Minimum</label>
                                        <input class="form-control" type="number" id="minimumDep" name="minimumDep" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label head" for="duringTime">During Time (Months)</label>
                                        <input class="form-control" type="number" id="duringTime" name="duringTime" required>
                                    </div>
                                </div>                    
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="form-label head" for="savingRate">Saving Rate (%)</label>
                                        <input class="form-control" type="number" step="0.01" id="savingRate" name="savingRate" required min="0">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label head" for="savingRateMinimum">Saving Rate Minimum (%)</label>
                                        <input class="form-control" type="number" step="0.01" id="savingRateMinimum" name="savingRateMinimum" required>
                                    </div>
                                </div>                   

                            </div>

                            <div class ="row align-items-center">

                                <div class="col-md-12">
                                    <label class="form-label head" for="description">Description</label>
                                    <textarea name ="description" id="description"></textarea>
                                </div>

                            </div>
                            <div class="footer-bar">
                                <p id="error-message" class="text-danger"></p>                            
                                <button type="submit" class="btn btn-primary">Send request approvement</button>
                            </div>

                        </form>
                        <!-- Header Section -->

                    </div>
                </div>



                <!-- Footer Start -->
                <jsp:include page="template/footer.jsp"/>
                <!-- End -->
            </main>
            <!--End page-content-->

        </div>
        <script src ="resources/script/jquery-3.7.1.min.js"></script>
        <script src="./assets/tinymce/tinymce.min.js"></script>
        <script src="./resources/script/tinymceConfig.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2"></script>
        <script src="https://unpkg.com/tippy.js@6"></script>
        <script src="./resources/script/script.js"></script>


        <!-- page-wrapper -->
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