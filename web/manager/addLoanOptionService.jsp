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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">


    </head>
    <style>
        /* Tổng thể container */
        .kofi-inspired-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        /* Tiêu đề */
        .kofi-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.75rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Nhóm input */
        .kofi-input-group {
            margin-bottom: 1.5rem;
        }

        .kofi-input-group label {
            font-family: 'Poppins', sans-serif;
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }

        .kofi-input-group label i {
            margin-right: 8px;
        }

        /* Input và Textarea */
        .kofi-input {
            width: 100%;
            padding: 12px 15px;
            font-size: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            background: #fafafa;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        .kofi-input:focus {
            border-color: #ff6f61; /* Màu hồng nhạt của Ko-fi */
            background: #fff;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 111, 97, 0.3);
        }

        .kofi-textarea {
            resize: vertical;
            min-height: 120px;
        }

        /* Nút Submit */
        .kofi-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 25px;
            font-size: 1.1rem;
            font-weight: 500;
            color: #fff;
            background: #ff6f61; /* Màu hồng đặc trưng của Ko-fi */
            border: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        .kofi-btn:hover {
            background: #ff867a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 111, 97, 0.4);
        }

        .kofi-btn i {
            margin-right: 8px;
        }

        /* Footer */
        .kofi-footer {
            text-align: center;
        }

        /* Hiệu ứng hover cho card (nếu cần) */
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

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

            <main class="page-content bg-light">   
                <c:set value="${sessionScope.staff}" var="staff"/>
                <jsp:include page="template/header.jsp"/>               

                <div class="container-fluid">                    
                    <div class="layout-specing">
                        <div class="row align-items-center">
                            <!-- Title & Breadcrumb -->
                            <div class="col-md-6">
                                <h5 class="mb-0">Trang quản lí dịch vụ gói vay</h5>
                                <nav aria-label="breadcrumb" class="mt-2">
                                    <ul class="breadcrumb breadcrumb-muted bg-transparent rounded mb-0 p-0">
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">SmartBanking</a>
                                        </li>
                                        <li class="breadcrumb-item">
                                            <a href="#" class="text-decoration-none text-danger">Dịch vụ cho vay</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Tạo mới gói dịch vụ</li>
                                    </ul>
                                </nav>
                            </div>                           
                        </div>
                        </br>
                        <div class="kofi-inspired-container">
                            <h5 class="kofi-title">
                                <i class="fas fa-piggy-bank me-2" style="color: red;"></i>
                                Tạo dịch vụ khoản vay
                            </h5>

                            <form id="loanForm" action="add-loan-option" method="POST">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="loanServiceName">
                                                <i class="fas fa-comment-dots text-success"></i> Tên gói vay
                                            </label>
                                            <input type="text" id="loanServiceName" name="loanServiceName" 
                                                   class="kofi-input" placeholder="Nhập tên gói" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="duringTime">
                                                <i class="fas fa-clock text-success"></i> Thời gian vay
                                            </label>
                                            <input type="number" id="duringTime" name="duringTime" 
                                                   class="kofi-input" placeholder="Nhập số tháng" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="onTermRate">
                                                <i class="fas fa-percentage text-primary"></i> Lãi suất trong kì hạn
                                            </label>
                                            <input type="number" step="0.01" id="onTermRate" 
                                                   name="onTermRate" 
                                                   class="kofi-input" placeholder="Nhập tỉ lệ (%)" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="penaltyRate">
                                                <i class="fas fa-percentage text-warning"></i> Lãi suất sau kì hạn
                                            </label>
                                            <input type="number" step="0.01" id="penaltyRate" 
                                                   name="penaltyRate" class="kofi-input" 
                                                   placeholder="Nhập tỉ lệ (%)" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="minimumLoan">
                                                <i class="fas fa-dollar-sign text-danger"></i> Giá trị tối thiểu vay
                                            </label>
                                            <input type="number" id="minimumLoan" 
                                                   name="minimumLoan" class="kofi-input" 
                                                   placeholder="Nhập giá trị (VNĐ)" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="kofi-input-group">
                                            <label for="maximumLoan">
                                                <i class="fas fa-dollar-sign text-danger"></i> Giá trị tối đa vay
                                            </label>
                                            <input type="number" id="maximumLoan" 
                                                   name="maximumLoan" class="kofi-input" 
                                                   placeholder="Nhập giá trị (VNĐ)" required>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="kofi-input-group">
                                            <label for="description">
                                                <i class="fas fa-comment-dots text-info"></i> Thông tin mô tả
                                            </label>
                                            <textarea name="description" id="description" 
                                                      class="kofi-input kofi-textarea" 
                                                      placeholder="Nhập thông tin mô tả về gói vay này..."></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="kofi-footer mt-2">                                    
                                    <button type="submit" class="kofi-btn">
                                        <i class="fas fa-paper-plane me-2"></i>
                                        Gửi phê duyệt
                                    </button>
                                </div>

                                <div class="modal fade" id="leaveConfirmationModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Rời khỏi trang?</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Những thay đổi của bạn trên trang sẽ không được lưu</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Ở lại trang</button>
                                                <button type="button" class="btn btn-primary" id="confirmLeaveBtn">Rời trang</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <jsp:include page="template/footer.jsp"/>
            </main>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
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
        <!-- Thêm đoạn script này vào phần script hiện có -->
        <script>
            $(document).ready(function () {
                let formDirty = false;
                let nextUrl = null;
                let isLeaving = false;


                function updateFormDirty() {
                    let isAnyFieldFilled = false;
                    $('.kofi-input, .kofi-textarea').each(function () {
                        if ($(this).val().trim() !== '') {
                            isAnyFieldFilled = true;
                            return false; // Thoát vòng lặp khi tìm thấy input có giá trị
                        }
                    });
                    formDirty = isAnyFieldFilled; // Nếu không có input nào có giá trị, đặt lại formDirty = false
                }


                $('.kofi-input, .kofi-textarea').on('input', function () {
                    updateFormDirty();
                });

                $('#loanForm').on('submit', function (e) {
                    e.preventDefault(); // Ngăn form submit mặc định

                    let formData = {
                        loanServiceName: $('#loanServiceName').val(),
                        duringTime: $('#duringTime').val(),
                        onTermRate: $('#onTermRate').val(),
                        penaltyRate: $('#penaltyRate').val(),
                        minimumLoan: $('#minimumLoan').val(),
                        maximumLoan: $('#maximumLoan').val(),
                        description: $('#description').val()
                    };

                    $.ajax({
                        url: 'add-loan-option',
                        type: 'POST',
                        data: formData,
                        dataType: 'json',
                        success: function (response) {
                            if (response.success) {
                                Swal.fire({
                                    title: 'Thành công!',
                                    text: 'Gửi yêu cầu phê duyệt thành công',
                                    icon: 'success',
                                    confirmButtonText: 'OK'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.reload();
                                    }
                                });
                                formDirty = false;
                            } else {
                                showErrorMessage("Error", response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            toastr.error("Lỗi khi gửi yêu cầu: " + error);
                        }
                    });
                });


                // Xử lý khi người dùng cố gắng rời trang
                window.onbeforeunload = function (e) {
                    if (formDirty && !isLeaving) {
                        return 'Thay đổi trên trang của bạn sẽ không được lưu.';
                    }
                };

                // Xử lý click vào các link
                $('a').on('click', function (e) {
                    if (formDirty && !isLeaving) {
                        e.preventDefault();
                        nextUrl = $(this).attr('href');
                        $('#leaveConfirmationModal').modal('show');
                    }
                });

                // Xử lý nút confirm trong modal
                $('#confirmLeaveBtn').on('click', function () {
                    isLeaving = true;
                    $('#leaveConfirmationModal').modal('hide');
                    if (nextUrl) {
                        window.location.href = nextUrl;
                    } else {
                        window.location.reload();
                    }
                });

                // Xử lý nút back của trình duyệt
                let originalUrl = window.location.href;
                history.pushState({page: 'current'}, document.title, originalUrl);

                $(window).on('popstate', function (e) {
                    if (formDirty && !isLeaving) {
                        e.preventDefault();
                        $('#leaveConfirmationModal').modal('show');
                        nextUrl = null;
                        history.pushState({page: 'current'}, document.title, originalUrl);
                    }
                });

                // Reset nextUrl khi modal đóng mà không rời trang
                $('#leaveConfirmationModal').on('hidden.bs.modal', function () {
                    if (!isLeaving) {
                        nextUrl = null;
                    }
                });
            });
        </script>
    </body>

</html>