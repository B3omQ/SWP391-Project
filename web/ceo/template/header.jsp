<%-- 
    Document   : headbar
    Created on : Jan 31, 2025, 12:41:12 PM
    Author     : JIGGER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                            src="${staff.image}"
                            class="avatar avatar-ex-small rounded-circle" alt=""></button>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                         style="min-width: 200px;">
                        <a class="dropdown-item d-flex align-items-center text-dark"
                           href="ceoProfileServlet">
                            <img src="${staff.image}"
                                 class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                            <div class="flex-1 ms-2">
                                <small class="d-block mb-1" style="font-weight: bold">${staff.username}</small>
                                <small class="text-muted" >${staff.fullname}</small>
                            </div>
                        </a>
                        <div class="dropdown-divider border-top"></div>
                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/LogoutServlet">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div>


</div>

