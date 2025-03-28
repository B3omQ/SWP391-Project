<%-- 
    Document   : headbar
    Created on : Jan 31, 2025, 12:41:12 PM
    Author     : JIGGER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Staff" %>
<%@ page import="model.Notification" %>
<%@ page import="dal.NotifyDAO" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    HttpSession sessionObj = request.getSession(false);
    Staff staff = (sessionObj != null) ? (Staff) sessionObj.getAttribute("staff") : null;
    pageContext.setAttribute("staff", staff);
    NotifyDAO ndao = new NotifyDAO();
    List<Notification> notifyList = ndao.getAllNotificationByCusIdNotRead(staff.getId(), false);
    if (notifyList == null) {
        notifyList = new ArrayList<>();
    }
    int count = ndao.countNotificationNotReadByCusId(staff.getId(), false);
    pageContext.setAttribute("count", count);
    pageContext.setAttribute("notifyList", notifyList);
%>


<div class="top-header">
    <div class="header-bar d-flex justify-content-between border-bottom">
        <div class="d-flex align-items-center">
            <a href="#" class="logo-icon">
                <img src="<%= request.getContextPath() %>/assets/images/logo-icon2.png" height="30" class="small" alt="">
                <span class="big">
                    <img src="<%= request.getContextPath() %>/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                    <img src="<%= request.getContextPath() %>/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </span>
            </a>
            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                <i class="uil uil-bars"></i>
            </a>
        </div>

        <ul class="list-unstyled mb-0">            

            <li class="list-inline-item mb-0 ms-1">
                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                   aria-controls="offcanvasRight">
                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings"
                                                                            class="fea icon-sm"></i></div>
                </a>
            </li>

            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <button type="button"
                            class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i
                            data-feather="mail" class="fea icon-sm"></i></button>
                    <span
                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${count}
                        <span class="visually-hidden">unread mail</span></span>

                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2"
                         data-simplebar style="height: auto; width: 300px;">
                        <c:choose>
                            <c:when test="${empty notifyList}">
                                <div class="text-dark mb-0 d-block text-truncat ms-3">Danh sách thông báo trống</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notify" items="${notifyList}">
                                    <div class="d-flex bubble align-items-center justify-content-between py-2 notify-item" 
                                         data-id="${notify.id}"> 
                                        <div class="d-inline-flex position-relative overflow-hidden">
                                            <img src="<%= request.getContextPath() %>/assets/images/logo-icon2.png"
                                                 class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                            <small class="text-dark mb-0 d-block ms-3">
                                                ${notify.description} 
                                                <small class="text-muted fw-normal d-inline-block">${notify.createTime}</small>
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                document.querySelectorAll(".notify-item").forEach(item => {
                                    item.addEventListener("click", function () {
                                        let notifyId = this.getAttribute("data-id");

                                        // Tạo form ẩn để gửi dữ liệu bằng POST
                                        let form = document.createElement("form");
                                        form.method = "POST";
                                        form.action = "${pageContext.request.contextPath}/identity-information-switch-case";

                                        let input = document.createElement("input");
                                        input.type = "hidden";
                                        input.name = "notifyId";
                                        input.value = notifyId;

                                        form.appendChild(input);
                                        document.body.appendChild(form);
                                        form.submit();
                                    });
                                });
                            });
                        </script>
                    </div>
                </div>
            </li>


            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                            src="${staff.image}"
                            class="avatar avatar-ex-small rounded-circle" alt=""></button>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                         style="min-width: 200px;">
                        <a class="dropdown-item d-flex align-items-center text-dark"
                           href="profile-manager">
                            <img src="${staff.image}"
                                 class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                            <div class="flex-1 ms-2">
                                <small class="d-block mb-1" style="font-weight: bold">${staff.username}</small>
                                <small class="text-muted" >${staff.fullname}</small>
                            </div>
                        </a>
                        <div class="dropdown-divider border-top"></div>
                        <a class="dropdown-item text-dark" href="logout"><span
                                class="mb-0 d-inline-block me-1"><i
                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                    </div>
                </div>
            </li>
        </ul>
    </div>


</div>

