<%-- 
    Document   : sidebar
    Created on : Feb 5, 2025, 4:57:17 PM
    Author     : LAPTOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <div class="page-wrapper doctris-theme toggled">
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

            <li><a href="ConsultantProfile"><i class="uil uil-user me-2 d-inline-block"></i>My profile</a></li>         

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Deposite Service</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="dep-option-service">View option</a></li>                      
                    </ul>
                </div>
            </li>            

            <li><a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Loan Service</a></li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="OnlineSupport">Chat</a></li>
<!--                        <li><a href="email.html">Email</a></li>
                        <li><a href="calendar.html">Calendar</a></li>-->
                    </ul>
                </div>
            </li>

<!--            <li class="sidebar-dropdown">
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
            </li>-->
<!--            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="login.html">Login</a></li>
                        <li><a href="signup.html">Signup</a></li>
                        <li><a href="forgot-password.html">Forgot Password</a></li>
                        <li><a href="lock-screen.html">Lock Screen</a></li>
                        <li><a href="thankyou.html">Thank you...!</a></li>
                    </ul>
                </div>
            </li>            -->

            <li><a href="home"><i class="uil uil-window me-2 d-inline-block"></i>Home page</a></li>
        </ul>
        <!-- sidebar-menu  -->
    </div>
            </html>
