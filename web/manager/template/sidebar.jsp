<%-- 
    Document   : sidebar
    Created on : Jan 31, 2025, 12:38:49 PM
    Author     : JIGGER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    function showSection(sectionId) {
        // Ẩn tất cả các phần
        document.getElementById('viewAccount').style.display = 'none';
        document.getElementById('editGmail').style.display = 'none';
        document.getElementById('editPassword').style.display = 'none';

        // Hiển thị phần được chọn
        document.getElementById(sectionId).style.display = 'block';
        
        // Loại bỏ lớp 'active' từ tất cả các liên kết
        document.getElementById('viewAccountLink').classList.remove('active');
        document.getElementById('editGmailLink').classList.remove('active');
        document.getElementById('editPasswordLink').classList.remove('active');

        // Thêm lớp 'active' vào liên kết được chọn
        document.getElementById(linkId).classList.add('active');
    }
</script>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="index.html">
                <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">
            <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
            <li><a href="customer-manager">
                    <i class="uil uil-stethoscope me-2 d-inline-block"></i>Customer list</a>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Account Setting</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="profile-manager" id="viewAccountLink" onclick="showSection('viewAccount')">View account</a></li>
                        <li><a href="profile-manager" id="editGmailLink" onclick="showSection('editGmail')">Edit gmail</a></li>
                        <li><a href="profile-manager" id="editPasswordLink" onclick="showSection('editPassword')">Edit password</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Customer's Loan List</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="patients.html">All Patients</a></li>
                        <li><a href="add-patient.html">Add Patients</a></li>
                        <li><a href="patient-profile.html">Profile</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="chat.html">Chat</a></li>
                        <li><a href="email.html">Email</a></li>
                        <li><a href="calendar.html">Calendar</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="faqs.html">FAQs</a></li>
                        <li><a href="review.html">Reviews</a></li>
                        <li><a href="invoice-list.html">Invoice List</a></li>
                        <li><a href="invoice.html">Invoice</a></li>
                        <li><a href="terms.html">Terms & Policy</a></li>
                        <li><a href="privacy.html">Privacy Policy</a></li>
                        <li><a href="error.html">404 !</a></li>
                        <li><a href="blank-page.html">Blank Page</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i
                        class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="login.html">Login</a></li>
                        <li><a href="signup.html">Signup</a></li>
                        <li><a href="forgot-password.html">Forgot Password</a></li>
                        <li><a href="lock-screen.html">Lock Screen</a></li>
                        <li><a href="thankyou.html">Thank you...!</a></li>
                    </ul>
                </div>
            </li>

            <li><a href="profile-manager"><i class="uil uil-cube me-2 d-inline-block"></i>My profile</a></li>

            <li><a href="../landing/index-two.html" target="_blank"><i
                        class="uil uil-window me-2 d-inline-block"></i>Home page</a></li>
        </ul>
        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->
    <ul class="sidebar-footer list-unstyled mb-0">
        <li class="list-inline-item mb-0 ms-1">
            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                <i class="uil uil-comment icons"></i>
            </a>
        </li>
    </ul>
</nav>

