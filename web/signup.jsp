<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Sign Up</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

</head>
<body>
    <section class="bg-half-150 d-table w-100 bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <div class="card login-page bg-white shadow mt-4 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Sign Up</h4>

            
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success text-center">
                                    ${successMessage}
                                </div>
                            </c:if>

               
                            <form action="<%= request.getContextPath() %>/register" method="post" class="login-form mt-4">
                                <div class="row">
                                    <!-- Full Name -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Full Name</label>
                                            <input type="text" class="form-control" name="fullName" value="${param.fullName}" required>
                                            <c:if test="${not empty errorFullName}">
                                                <span class="text-danger">${errorFullName}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Email -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Email</label>
                                            <input type="email" class="form-control" name="email" value="${param.email}" required>
                                            <c:if test="${not empty errorEmail}">
                                                <span class="text-danger">${errorEmail}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Phone Number -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Phone Number</label>
                                            <input type="text" class="form-control" name="phoneNumber" value="${param.phoneNumber}" required>
                                            <c:if test="${not empty errorPhoneNumber}">
                                                <span class="text-danger">${errorPhoneNumber}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Address -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Address</label>
                                            <input type="text" class="form-control" name="address" value="${param.address}" required>
                                            <c:if test="${not empty errorAddress}">
                                                <span class="text-danger">${errorAddress}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Gender -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Gender</label>
                                            <select class="form-control" name="gender" required>
                                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Password</label>
                                            <input type="password" class="form-control" name="password" required>
                                            <c:if test="${not empty errorPassword}">
                                                <span class="text-danger">${errorPassword}</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- Confirm Password -->
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label>Confirm Password</label>
                                            <input type="password" class="form-control" name="password2" required>
                                            <c:if test="${not empty errorPassword2}">
                                                <span class="text-danger">${errorPassword2}</span>
                                            </c:if>
                                        </div>
                                    </div>

                       
                                    <div class="col-md-12">
                                        <button class="btn btn-primary w-100">Register</button>
                                    </div>
                                </div>
                            </form>

            
                            <div class="text-center mt-3">
                                <p>Already have an account? 
                                    <a href="<%= request.getContextPath() %>/login.jsp">Sign in</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
